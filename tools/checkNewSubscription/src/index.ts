import { EmailMessage } from "cloudflare:email";
import { createMimeMessage } from "mimetext";
import PostalMime, { Email } from 'postal-mime';

const DEV = false;
const DEBUG = DEV || false;

const useragent = 'mai-api (v0.1)';
const sender = 'webmaster@lyrion.org';

const fromMatcher = new RegExp(/^noreply-[-a-z0-9]+@vbulletin\.net|postmaster@\w+\.outbound-mail\.sendgrid\.net$/);
const toMatcher = new RegExp(/^forum-registration-checker@lms-community\.org$/);

const userEmailMatcher = new RegExp(/Email Address : ([-_+\w.@]+)/);
const userIpMatcher = new RegExp(/IP Address: (\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b|(?:(?:[0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?:(?::[0-9a-fA-F]{1,4}){1,6})|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(?:ffff(?::0{1,4}){0,1}:){0,1}(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9]))\b)/);

export default {
  async email(message: any, env?: any, ctx?: any) {
    let email: Email;

    try {
      email = await PostalMime.parse(message.raw);
    }
    catch (e) {
      console.error('Failed to parse email:', e);
      return message.setReject('Failed to parse email');
    }

    DEBUG && console.log(email);

    // TODO - forward 1:1 if something fails?
    if (!fromMatcher.test(email.from?.address || '')) {
      console.error(`Sender not allowed: '${message.from}'`);
      return message.setReject(`Sender not allowed: '${message.from}'`);
    }

    if (!toMatcher.test(email.to?.[0]?.address || '')) {
      console.error(`Recipient not allowed: '${message.to}'`);
      return message.setReject(`Recipient not allowed: '${message.to}'`);
    }

    const userEmail = (userEmailMatcher.exec(email.html || email.text || ''))?.[1];
    const userIp = (userIpMatcher.exec(email.html || email.text || ''))?.[1];

    DEBUG && console.log({ userEmail, userIp });

    const emailReputation = await checkEmailAddress(userEmail || '', env?.EMAILREP_API_KEY || '');
    DEBUG && console.log('Email reputation:', emailReputation);

    const ipReputation = await checkIpAddress(userIp || '', env?.IPQS_API_KEY || '');
    DEBUG && console.log('IP reputation:', ipReputation);

    await sendResponse(email, emailReputation, ipReputation, env);
  },
};

async function sendResponse(email: Email, emailReputation: any, ipReputation: any, env: any) {
  const mime = createMimeMessage();

  mime.setSender({ name: 'Webmaster Lyrion.org', addr: sender });
  mime.setRecipient({ addr: env.EMAIL });
  mime.setSubject(email.subject || `New user registration`);

  let body = email.text?.replaceAll(/\n/, '<br/>') || email.html || `A new user has registered at Lyrion : Community : Forums<br/><br/>`;

  body += `<br/>--- Email Reputation ---<br/>`;
  if (emailReputation.error) {
    body += `Error checking email reputation: ${emailReputation.error}\n`;
  }
  else {
    body += `Reputation: ${emailReputation.reputation}<br/>`;
    body += `Suspicious: ${emailReputation.suspicious}<br/>`;
    body += `<pre>${ JSON.stringify(emailReputation, null, 2) }</pre><br/>`;
  }

  body += `<br/>--- IP Reputation ---<br/>`;
  if (ipReputation.error) {
    body += `Error checking IP reputation: ${ipReputation.error}\n`;
  }
  else {
    body += `Fraud Score: ${ipReputation.fraud_score}<br/>`;
    body += `<pre>${ JSON.stringify(ipReputation, null, 2)}</pre><br/>`;
  }

  mime.addMessage({ contentType: 'text/html', data: body });

  const message = new EmailMessage(sender, env.EMAIL, mime.asRaw());

  return env.EMAIL.send(message);
}

async function checkEmailAddress(address: string, apiKey: string): Promise<{ [key: string]: any }> {
  if (!address) return { error: 'No address provided' };
  if (!apiKey) return { error: 'No API key provided' };

  const response = DEV ? EXAMPLE_EMAILREP_RESPONSE : await fetch(`https://emailrep.io/${encodeURIComponent(address)}`, {
    headers: {
      'Key': apiKey,
      'User-Agent': useragent,
      'Accept': 'application/json'
    },
    cf: {
        cacheEverything: true,
        cacheTtlByStatus: {
          '200-299': 30 * 86400,
        }
    }
  } as any);

  !DEV && DEBUG && console.log(response);

  if (response.status === 429) {
    console.warn('EmailRep rate limit exceeded');
    return { error: 'Rate limit exceeded' };
  }

  if (response.status === 404) {
    console.warn('EmailRep address not found:', address);
    return { error: 'Address not found' };
  }

  if (!response.ok) {
    console.error('EmailRep request failed:', response.status, await response.text());
    return { error: `Request failed with status ${response.status}` };
  }

  return response.json();
}

async function checkIpAddress(ip: string, apiKey: string): Promise<any> {
  if (!ip) return { error: 'No IP provided' };
  if (!apiKey) return { error: 'No API key provided' };

  // This optional parameter controls the level of strictness for the lookup. Setting this option higher will increase
  // the chance for false-positives as well as the time needed to perform the IP analysis. Increase this setting if you
  // still continue to see fraudulent IPs with our base setting (level 1 is recommended) or decrease this setting for
  // faster lookups with less false-positives. Current options for this parameter are
  // 0 (fastest), 1 (recommended), 2 (more strict), or 3 (strictest).
	const strictness = 1;

  // Bypasses certain checks for IP addresses from education and research institutions, schools, and some corporate
  // connections to better accommodate audiences that frequently use public connections. This value can be set to
  // true to make the service less strict while still catching the riskiest connections.
	const allow_public_access_points = 'true';

	const response = await fetch(`https://www.ipqualityscore.com/api/json/ip/${ apiKey }/${ ip }?strictness=${ strictness }&allow_public_access_points=${ allow_public_access_points }`, {
    headers: {
      'User-Agent': useragent,
      'Accept': 'application/json'
    },
    cf: {
      cacheEverything: true,
      cacheTtlByStatus: {
        '200-299': 7 * 86400,
      }
    }
  } as any);

  if (!response.ok) {
    console.error('IPQS request failed:', response.status, await response.text());
    return { error: `Request failed with status ${response.status}` };
  }

  return response.json();
}

const EXAMPLE_EMAILREP_RESPONSE = {
  status: 200,
  ok: true,
  text: () => 'some boddy',
  json: () => { return {
    details: {
      email: 'hugepotato@gmail.com',
      reputation: 'high',
      suspicious: false,
      references: 6,
      details: {
        blacklisted: false,
        malicious_activity: false,
        malicious_activity_recent: false,
        credentials_leaked: true,
        credentials_leaked_recent: false,
        data_breach: true,
        first_seen: '10/04/2013',
        last_seen: '01/01/2021',
        domain_exists: true,
        domain_reputation: 'n/a',
        new_domain: false,
        days_since_domain_creation: 11022,
        suspicious_tld: false,
        spam: false,
        free_provider: true,
        disposable: false,
        deliverable: true,
        accept_all: false,
        valid_mx: true,
        primary_mx: 'gmail-smtp-in.l.google.com',
        spoofable: true,
        spf_strict: false,
        dmarc_enforced: false,
        profiles: [Array]
      }
    }
  } }
};
#!/usr/bin/perl

use strict;

# use Data::Dump;
use JSON;
use LWP::UserAgent;
use YAML;

use constant REPO_FILE => 'https://raw.githubusercontent.com/LMS-Community/lms-server-repository/master/servers.json';
use constant DATA_YAML => 'docs/downloads/downloads.yaml';

my @platforms = (
   ['win', ':material-microsoft-windows: Windows 32-bit'],
   ['win64', ':material-microsoft-windows: Windows 64-bit'],
   ['mac', ':material-apple: Apple macOS'],
   ['debamd64', ':material-debian: Debian / :material-ubuntu: Ubuntu x86_64'],
   ['debarm', ':material-debian: Debian / :material-ubuntu: Ubuntu - ARM'],
   ['debi386', ':material-debian: Debian / :material-ubuntu: Ubuntu - i386'],
   ['deb', ':material-debian: Debian / :material-ubuntu: Ubuntu - i386, x86_64, ARM'],
   ['rpm', ':material-redhat: RedHat / :material-fedora: Fedora'],
   ['tararm', ':material-linux::material-code-braces: ARM Linux Tarball'],
   ['src', ':material-linux::material-code-braces: Linux/Unix Tarball - i386, x86_64, i386 FreeBSD, ARM'],
   ['nocpan', ':material-linux::material-code-braces: Linux/Unix Tarball - No CPAN Libraries'],
);

my $repo;
eval {
    my $ua = LWP::UserAgent->new();
    # $ua->ssl_opts(verify_hostname => 0);
    my $resp = $ua->get(REPO_FILE);
	$repo = from_json($resp->content);
} || die "$@";

my ($stable, $dev) = sort grep {
    $_ ne 'stable'
} keys %$repo;

my %versions = (
    stable => $stable,
    dev => $dev,
);

my %placeholders;
foreach ('latest', 'stable', 'dev') {
    my ($releases, $version) = renderRelease($versions{$_} || $_);

    $placeholders{$_} = {
        mac => $releases->{osx},
        win => $releases->{win},
        win64 => $releases->{win64},
        debamd64 => $releases->{debamd64},
        debarm => $releases->{debarm},
        debi386 => $releases->{debi386},
        deb => $releases->{deb},
        rpm => $releases->{rpm},
        tararm => $releases->{tararm},
        src => $releases->{src},
        nocpan => $releases->{nocpan},
        version => $version,
    };

    if ($_ eq 'latest') {
        my $latestItems = $placeholders{latest};
        foreach (@platforms) {
            my $platformId = $_->[0];
            my $item = $latestItems->{$platformId};
            $placeholders{$platformId} = sprintf('[%s (%s)](%s){ .md-button }', $item->{desc}, $item->{size}, $item->{url});
        }

        $placeholders{win} = "$placeholders{win} $placeholders{win64}";
        $placeholders{deb} = "$placeholders{debamd64} $placeholders{debarm}";

        $placeholders{debpi} = $placeholders{debarm};
        $placeholders{debpi} =~ s/:material-debian: Debian \/ :material-ubuntu: Ubuntu - ARM/:simple-raspberrypi: Raspberry Pi OS/;
    }
}

YAML::DumpFile(DATA_YAML, \%placeholders);

sub renderRelease {
    my ($key) = @_;
    my $downloads = $repo->{$key} || return {};

    my %releases;
    my $version;

    foreach (@platforms) {
        my $platformId = $_->[0];
        $platformId = 'osx' if $platformId eq 'mac';

        my $download = $downloads->{$platformId};

        if (my $url = $download->{url}) {
            $version ||= $download->{version};

            $url =~ s/^http:/https:/;
            my $filename = (split(m|/|, $url))[-1];

            $releases{$platformId} = {
                name => $filename,
                desc => $_->[1],
                size => $download->{size},
                url => $url,
                timestamp => scalar localtime $download->{revision}
            }
        }
    }

    return (\%releases, $version);
}

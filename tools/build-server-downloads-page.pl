#!/usr/bin/perl

use strict;

# use Data::Dump;
use JSON;
use LWP::UserAgent;
use YAML;

use constant REPO_FILE => 'https://raw.githubusercontent.com/LMS-Community/lms-server-repository/master/servers.json';
use constant DATA_YAML => 'docs/getting-started/downloads.yaml';

my @platforms = (
   ['win', ':material-microsoft-windows: Windows 32-bit'],
   ['win64', ':material-microsoft-windows: Windows 64-bit'],
   ['osx', ':material-apple: Apple macOS'],
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

my $downloads = $repo->{latest};

my %releases;
my $version;
foreach (@platforms) {
    my $platformId = $_->[0];
    my $download = $downloads->{$platformId};

    if (my $url = $download->{url}) {
        $version ||= $download->{version};

        $url =~ s/^http:/https:/;
        my $filename = (split(m|/|, $url))[-1];
        my $timestamp = $download->{revision};
        $releases{$_->[0]} = "[$_->[1] ($download->{size})]($url){ .md-button }";
    }
}

$releases{pi} = $releases{debarm};
$releases{pi} =~ s/:material-debian: Debian \/ :material-ubuntu: Ubuntu - ARM/:simple-raspberrypi: Raspberry Pi OS/;

my %placeholders = (
    win => "$releases{win} $releases{win64}",
    deb => "$releases{debamd64} $releases{debarm}",
    debpi => $releases{pi},
    rpm => $releases{rpm},
    mac => $releases{osx},
    version => $version
);

YAML::DumpFile(DATA_YAML, \%placeholders);

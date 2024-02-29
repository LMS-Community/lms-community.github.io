#!/usr/bin/perl

use strict;

# use Data::Dump;
use JSON;
use LWP::Simple;

use constant REPO_FILE => 'https://raw.githubusercontent.com/LMS-Community/lms-server-repository/master/servers.json';
use constant TEMPLATE => 'docs/getting-started/index.md';

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
	$repo = from_json(get(REPO_FILE));
} || die "$@";

my $downloads = $repo->{latest};

my %releases;
foreach (@platforms) {
	my $platformId = $_->[0];
	my $download = $downloads->{$platformId};

	if (my $url = $download->{url}) {
		$url =~ s/^http:/https:/;
		my $filename = (split(m|/|, $url))[-1];
		my $timestamp = $download->{revision};
		$releases{$_->[0]} = "[$_->[1] ($download->{size})]($url){ .md-button }";
	}
}

$releases{pi} = $releases{debarm};
$releases{pi} =~ s/:material-debian: Debian \/ :material-ubuntu: Ubuntu - ARM/:simple-raspberrypi: Raspberry Pi OS/;

my $content = qq(
=== ":material-microsoft-windows: Windows"
    $releases{win}
    $releases{win64}

=== ":material-debian: Debian / :material-ubuntu: Ubuntu"
    $releases{debamd64}
    $releases{debarm}

=== ":simple-raspberrypi: Raspberry Pi OS:"
    $releases{pi}

=== ":material-redhat: RedHat / :material-fedora: Fedora"
    $releases{rpm}

=== ":material-apple: Apple macOS"
    $releases{osx}
);

my $document = do {
	local $/ = undef;
	open my $fh, '<', TEMPLATE
		or die "could not open: $!";
	<$fh>;
};

$document =~ s/<!--DOWNLOADS-->.*<!--ENDDOWNLOADS-->/<!--DOWNLOADS-->\n$content\n<!--ENDDOWNLOADS-->/s;

open my $fh, '>', TEMPLATE or die "could not open: $!";
print $fh $document;
close($fh);


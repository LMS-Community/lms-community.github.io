#!/usr/bin/perl

use strict;

use Data::Dump;
use LWP::UserAgent;
use YAML;

use constant VERSION => '8.5.1';
use constant COMMUNITY_FIRMWARE_REPOSITORY => 'https://ralph_irving.gitlab.io/lms-community-firmware/update/firmware/%s/%s';
use constant FIRMWARE_YAML => 'docs/players-and-controllers/firmware-versions.yaml';

my $versions = YAML::LoadFile(FIRMWARE_YAML);

my $ua = LWP::UserAgent->new();
$ua->ssl_opts(verify_hostname => 0);

foreach ('jive', 'baby', 'fab4') {
    my $res = $ua->get(sprintf(COMMUNITY_FIRMWARE_REPOSITORY, VERSION, "$_.version"));

    if ($res->code == 200) {
        my ($version, $revision) = $res->content =~ /(\d+\.\d+\.\d+) (r\d+)/;
        if ($version && $revision) {
            $versions->{$_} = "$version-$revision";
        }
    }
}

YAML::DumpFile(FIRMWARE_YAML, $versions);
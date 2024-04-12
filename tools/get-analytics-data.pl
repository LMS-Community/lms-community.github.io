#!/usr/bin/perl

use strict;

use Data::Dump;
use JSON;
use LWP::UserAgent;
use YAML;

use constant STATS_SUMMARY => 'https://stats.lms-community.org/api/stats';
use constant STATS_HISTORY => 'https://stats.lms-community.org/api/stats/history';
use constant STATS_YAML    => 'docs/analytics/stats.yaml';

my ($stats, $history);

eval {
    my $ua = LWP::UserAgent->new();
    # $ua->ssl_opts(verify_hostname => 0);
    my $resp = $ua->get(STATS_SUMMARY);
	$stats   = from_json($resp->content);

    $resp    = $ua->get(STATS_HISTORY);
	$history = from_json($resp->content);
} || die "$@";

my $c;
my %stats = (
    versions  => join("\n", map { my ($k, $v) = each %$_; qq("$k": $v) } @{$stats->{versions} || []}),
    countries => join("\n", map { my ($k, $v) = each %$_; qq("$k": $v) } @{$stats->{countries} || []}),
    os        => join("\n", map { my ($k, $v) = each %$_; qq("$k": $v) } @{$stats->{os} || []}),

    pluginLabels => join(',', map { sprintf('"%s"', keys %$_) } @{$stats->{plugins} || []}),
    pluginCounts => join(',', map { (values %$_)[0] } @{$stats->{plugins} || []}),

    histDates   => join(',', map { sprintf('"%s"', $_->{d}) } @$history),
    # get the total number of installations from the versions counts
    histInstallations => join(',', map { $c = 0; map { my ($k, $v) = each %$_; $c+=$v } @{from_json($_->{v})}; $c } @$history),
    histPlayers => join(',', map { $_->{p} } @$history),
);

YAML::DumpFile(STATS_YAML, \%stats);

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
    $ua->ssl_opts(verify_hostname => 0);
    my $resp = $ua->get(STATS_SUMMARY);
    $stats   = from_json($resp->content);

    $resp    = $ua->get(STATS_HISTORY);
    $history = from_json($resp->content);
} || die "$@";

sub prepareData {
    my ($data, $cutoff) = @_;
    $cutoff ||= 0;

    my $others = 0;

    $data = [
        grep {
            my $keep = 1;
            if (/": (\d+)/) {
                if ($1 < $cutoff) {
                    $others += $1;
                    $keep = 0;
                }
            }

            $keep;
        } map {
            my ($k, $v) = each %$_;
            qq("$k ($v)": $v);
        } @{$data || []}
    ];
    push @$data, qq("Others ($others)": $others) if $others;

    return join("\n", @$data);
}

my (@pluginLabels, @pluginCounts);
foreach (@{$stats->{plugins} || []}) {
    my ($k, $v) = each %$_;
    if ($v > 10) {
        push @pluginCounts, $v;
        push @pluginLabels, qq("$k");
    }
}

my $c;
my %stats = (
    versions  => prepareData($stats->{versions}),
    countries => prepareData($stats->{countries}, 10),
    os        => prepareData($stats->{os}, 6),

    pluginLabels => join(',', @pluginLabels),
    pluginCounts => join(',', @pluginCounts),

    histDates   => join(',', map { sprintf('"%s"', $_->{d}) } @$history),
    # get the total number of installations from the versions counts
    histInstallations => join(',', map { $c = 0; map { my ($k, $v) = each %$_; $c+=$v } @{from_json($_->{v})}; $c } @$history),
    histPlayers => join(',', map { $_->{p} || 0 } @$history),
);

YAML::DumpFile(STATS_YAML, \%stats);

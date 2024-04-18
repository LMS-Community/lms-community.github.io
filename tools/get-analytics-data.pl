#!/usr/bin/perl

use strict;

use Data::Dump;
use JSON;
use LWP::UserAgent;

use constant STATS_SUMMARY => 'https://stats.lms-community.org/api/stats';
use constant STATS_HISTORY => 'https://stats.lms-community.org/api/stats/history';
use constant PLAYERNAME_MAP => 'docs/analytics/players-displayname.json';

my ($stats, $history);

eval {
    my $ua = LWP::UserAgent->new();
    # $ua->ssl_opts(verify_hostname => 0);
    my $resp = $ua->get(STATS_SUMMARY);
    $stats   = from_json($resp->content);

    $resp    = $ua->get(STATS_HISTORY);
    $history = from_json($resp->content);
} || die "$@";

sub prepareData {
    my ($data, $cutoff, $valueLabel, $countLabel) = @_;
    $cutoff ||= 0;
    $countLabel ||= 'c';

    my $others = 0;

    $data = [
        grep {
            my $keep = 1;

            if ($cutoff && (my $c = $_->{$countLabel})) {
                if ($c < $cutoff) {
                    $others += $c;
                    $keep = 0;
                }
            }

            $keep;
        } map {
            my ($k, $v) = each %$_;
            my $r = {
                $valueLabel => $k,
                $countLabel => $v
            };
        } @{$data || []}
    ];

    push @$data, {
        $valueLabel => 'Others',
        $countLabel => $others
    } if $others;

    return $data;
}

my (@players, @versions);

foreach my $historical (@$history) {
    push @players, {
        d => $historical->{d},
        p => $historical->{p}
    };

    my $total = 0;
    push @versions, map {
        my ($k, $v) = each %$_;
        $total += $v;
        {
            d => $historical->{d},
            v => $k,
            c => $v,
        };
    } @{from_json($historical->{v}) || []};

    push @versions, {
        d => $historical->{d},
        v => "All",
        c => $total
    };
}

# Update the player name mapping: add new values, or we'll end up with "null" values

my $fh;
my $json = do {
    local $/ = undef;
    open $fh, "<", PLAYERNAME_MAP
        or die "could not open: $!";
    <$fh>;
};
close $fh;

my $playerTypes = from_json($json);
my $dirty;
foreach (grep { $_ } @{$stats->{playerTypes}}) {
    my ($playerType) = each %$_;

    if ($playerType && !grep { $_->{name} eq $playerType } @$playerTypes) {
        $dirty++;
        push @$playerTypes, {
            name => $playerType,
            displayname => ucfirst($playerType)
        };
    }
}

if ($dirty) {
    open my $fh, ">", PLAYERNAME_MAP || die "could not open: $!";
    print $fh to_json($playerTypes);
}


my $c;
my %stats = (
    versions  => \@versions,
    players   => \@players,
    playerTypes => prepareData($stats->{playerTypes}, 0, 'p'),
    connectedPlayers => prepareData($stats->{connectedPlayers}, 0, 'p'),
    countries => prepareData($stats->{countries}, 0, 'c', 'i'),
    os        => prepareData($stats->{os}, 6, 'o'),
    plugins   => prepareData($stats->{plugins}, 10, 'p'),
);

print to_json(\%stats);

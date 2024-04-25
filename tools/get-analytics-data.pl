#!/usr/bin/perl

use strict;

# use Data::Dump;
use JSON;
use LWP::UserAgent;

use constant STATS_SUMMARY => 'https://stats.lms-community.org/api/stats';
use constant STATS_HISTORY => 'https://stats.lms-community.org/api/stats/history';
use constant PLAYERNAME_MAP => 'docs/analytics/players-displayname.json';

my $playerTypes = {
    baby => 'Squeezebox Radio',
    boom => 'Squeezebox Boom',
    controller => 'Squeezebox Controller',
    daphile => 'Daphile',
    Euphony => 'Euphony',
    fab4 => 'Squeezebox Touch',
    http => 'HTTP',
    iPengiPad => 'iPeng iPad',
    iPengiPod => 'iPeng iPod',
    m6encore => 'M6 Encore',
    receiver => 'Squeezebox Receiver',
    slimp3 => 'SliMP3',
    softsqueeze => 'Softsqueeze',
    'Squeeze connect' => 'Squeeze Connect',
    squeezebox => 'Squeezebox 1',
    squeezebox2 => 'Squeezebox 2/3/Classic',
    squeezebox3 => 'Squeezebox 3',
    squeezeesp32 => 'SqueezeESP32',
    squeezelite => 'Squeezelite',
    squeezeplay => 'SqueezePlay',
    squeezeplayer => 'SqueezePlayer',
    squeezeslave => 'Squeezeslave',
    transporter => 'Transporter'
};

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

my $c;
my %stats = (
    versions  => \@versions,
    players   => \@players,
    playerTypes => [ map {
        $_->{p} = $playerTypes->{$_->{p}} || ucfirst($_->{p});
        $_;
    } @{prepareData($stats->{playerTypes}, 0, 'p') || []} ],
    connectedPlayers => prepareData($stats->{connectedPlayers}, 0, 'p'),
    countries => prepareData($stats->{countries}, 0, 'c', 'i'),
    os        => prepareData($stats->{os}, 6, 'o'),
    tracks    => prepareData($stats->{tracks}, 0, 't'),
);

print to_json(\%stats);

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
    euphony => 'Euphony',
    fab4 => 'Squeezebox Touch',
    http => 'HTTP',
    'ipeng ipad' => 'iPeng iPad',
    'ipeng ipod' => 'iPeng iPhone',
    'ipeng iphone' => 'iPeng iPhone',
    ipengipad => 'iPeng iPad',
    ipengipod => 'iPeng iPhone',
    m6encore => 'M6 Encore',
    receiver => 'Squeezebox Receiver',
    'ropieee [ropieeexl]' => 'Ropieee',
    slimlibrary => 'SlimLibrary',
    slimp3 => 'SliMP3',
    softsqueeze => 'Softsqueeze',
    'squeeze connect' => 'Squeeze Connect',
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
    my $ua = LWP::UserAgent->new(
        agent => 'Lyrion/0.1 - analytics aggregator'
    );
    # $ua->ssl_opts(verify_hostname => 0);
    my $resp = $ua->get(STATS_SUMMARY);
    $stats   = from_json($resp->content);

    $resp    = $ua->get(STATS_HISTORY);
    $history = from_json($resp->content);
} || die "$@";

sub prepareData {
    my ($data, $valueLabel, $countLabel) = @_;
    $countLabel ||= 'c';

    my $others = 0;

    $data = [
        map {
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
        $_->{p} = $playerTypes->{lc($_->{p})} || ucfirst($_->{p});
        $_;
    } @{prepareData($stats->{playerTypes}, 'p') || []} ],
    connectedPlayers => prepareData($stats->{connectedPlayers}, 'p'),
    countries => prepareData($stats->{countries}, 'c', 'i'),
    os        => prepareData($stats->{os}, 'o'),
    tracks    => prepareData($stats->{tracks}, 't'),
);

print to_json(\%stats);

#!/usr/bin/perl

use strict;

# use Data::Dump;
use JSON;
use LWP::UserAgent;
use XML::Simple;

use constant REPO_FILE => 'https://raw.githubusercontent.com/LMS-Community/lms-plugin-repository/master/extensions.xml';
use constant STATS_URL => 'https://stats.lms-community.org/api/stats/plugins';
use constant MAX_TOP_PLUGINS => 20;

my @categories = (
  "musicservices",
  "radio",
  "hardware",
  "skin",
  "information",
  "playlists",
  "scanning",
  "tools",
  "misc",
);

my %categoryTitles = (
	musicservices => 'Music Services',
	radio => 'Internet Radio',
	skin => 'Skins',
	information => 'Information, Metadata',
	misc => 'Miscellaneous',
	top => 'Most popular',
);

my %categoryIcons = (
	musicservices => 'material-music-box-outline',
	radio => 'material-radio',
	hardware => 'material-cast-audio',
	skin => 'material-page-layout-header-footer',
	information => 'material-information-box-outline',
	playlists => 'material-playlist-music',
	tools => 'material-tools',
	scanning => 'material-file-search-outline',
	misc => 'material-toy-brick-outline',
	top => 'material-star-shooting',
);

my ($repo, $stats, %pluginCounts);

print q(---
layout: default
title: Available Plugins
---

<!--
	Do not edit this page! It is automatically generated from the repository files.
	Any change to the file would be overwritten next time changes from the plugin repository are embedded.
	If you'd like to apply a change, update the plugin's repository file
	(https://github.com/LMS-Community/lms-plugin-repository) instead.
-->
);

my $ua = LWP::UserAgent->new();

eval {
	my $repoXML = $ua->get(REPO_FILE);

	$repo = XMLin($repoXML->content,
		SuppressEmpty => undef,
		KeyAttr     => {
			title   => 'lang',
			desc    => 'lang',
			changes => 'lang'
		},
		ContentKey  => '-content',
		GroupTags   => {
			applets => 'applet',
			sounds  => 'sound',
			wallpapers => 'wallpaper',
			plugins => 'plugin',
			patches => 'patch',
		},
		ForceArray => [ 'applet', 'wallpaper', 'sound', 'plugin', 'patch', 'title', 'desc', 'changes' ],
	);

	$stats = from_json($ua->get(STATS_URL)->content) || [];

	foreach (@$stats) {
		my ($k, $v) = each %$_;
		$pluginCounts{$k} = $v;
	}
};

die "$@" if $@;

my $plugins = $repo->{plugins};

my %categories;
my %seen;
my %pluginsRef;

foreach (@$plugins) {
	next if $_->{maxTarget} !~ /^[89*]/;
	$pluginsRef{$_->{name}} = $_;
	push @{$categories{$_->{category}}}, $_;
}

# known categories as listed above first, then those provided by the repo file
foreach (@categories, keys %categories) {
	next if $_ =~ /^(?:misc|top)$/;

	my $category = delete $categories{$_};
	next unless $category;

	printCategory($_, $category);
}

my @topPlugins;
foreach my $plugin (@$stats) {
	my ($name) = keys %$plugin;
	push @topPlugins, $pluginsRef{$name} if $pluginsRef{$name};
	last if scalar @topPlugins >= MAX_TOP_PLUGINS;
}

if (scalar @topPlugins) {
	printCategory('top', \@topPlugins, 'nofilter');
}

# Miscellaneous last but not least
printCategory('misc', $categories{'misc'});

sub printCategory {
	my ($category, $data, $noFilter) = @_;

	$data = [ sort {
		lc($a->{title}->{EN}) cmp lc($b->{title}->{EN})
	} grep {
		!$seen{$_->{name}}++
	} @$data ] unless $noFilter;

	return unless scalar @$data;

	my $title = $categoryTitles{$category} || ucfirst($category);
	my $icon  = $categoryIcons{$category} || $categoryIcons{misc};

	print "## :$icon: $title\n\n";
	print qq(<div class="grid cards" markdown>\n\n);

	foreach (@$data) {
		my $title = $_->{title}->{EN};
		$title =~ s/\s*$//;
		utf8::encode($title);

		my $desc = $_->{desc}->{EN};
		$desc =~ s/(https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*))/[$1]($1)/sg;
		utf8::encode($desc);

		my $author = $_->{creator};
		$author = $author->[0] if ref $author;
		utf8::encode($author);

		printf("-   __:%s: %s__\n\n", $icon, $title);
		print  "    ---\n\n";
		printf("    %s\n\n", $desc);
		printf("    %s", $author) if !$_->{email};
		printf("    [:octicons-mail-24: %s](mailto:%s)", $author, $_->{email}) if $_->{email};
		printf("    - [:octicons-globe-24: Details](%s)", $_->{link}) if $_->{link};
		printf("    - :octicons-download-24: %s", $pluginCounts{$_->{name}}) if $pluginCounts{$_->{name}};
		print  "\n\n";
	}

	print "</div>\n\n";
}

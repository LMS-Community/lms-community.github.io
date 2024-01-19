#!/usr/bin/perl

use strict;

# use Data::Dump;
use JSON;
use LWP::Simple;
use XML::Simple;

use constant TESTING => 0;
use constant REPO_FILE => 'https://raw.githubusercontent.com/LMS-Community/lms-plugin-repository/master/extensions.xml';

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
);

my $repo;

print q(
!!! info
	Do net edit this page! It is automatically generated from the repository files.
	Any change the the file would be overwritten next time changes from the plugin repository are embedded.
	If you'd like to apply a change, update the plugin's repository file instead.
);

eval {
	my $repoXML = TESTING
		? do {
			warn 'TESTING local file!!!';
			local $/ = undef;
			open my $fh, "<", 'extensions.xml'
				or die "could not open: $!";
			<$fh>;
		}
		: get(REPO_FILE);

	$repo = XMLin($repoXML,
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
} || die "$@";

my $plugins = $repo->{plugins};

my %categories;
my %seen;

foreach (@$plugins) {
	push @{$categories{$_->{category}}}, $_;
}

# known categories as listed above first, then those provided by the repo file
foreach (@categories, keys %categories) {
	next if $_ eq 'misc';

	my $category = delete $categories{$_};
	next unless $category;

	printCategory($_, $category);
}

# Miscellaneous last but not least
printCategory('misc', $categories{'misc'});

sub printCategory {
	my ($category, $data) = @_;

	$data = [ sort {
		lc($a->{title}->{EN}) cmp lc($b->{title}->{EN})
	} grep {
		!$seen{$_->{name}}++
	} @$data ];

	return unless scalar @$data;

	my $title = $categoryTitles{$category} || ucfirst($category);
	my $icon  = $categoryIcons{$category} || $categoryIcons{misc};

	print "## :$icon: $title\n\n";
	print qq(<div class="grid cards" markdown>\n\n);

	foreach (@$data) {
		my $title = $_->{title}->{EN};
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
		print  "\n\n";
	}

	print "</div>\n\n";
}
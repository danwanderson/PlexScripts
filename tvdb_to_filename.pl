#!/usr/bin/env perl

# Parse the copy-paste output from thetvdb.com and turn it into something Plex-friendly

use warnings;
use strict;
use File::Basename;

sub usage() {
    print "$0 INPUTFILE title\n";
    exit;
}

if (scalar @ARGV < 2) {
    usage();
    exit;
}

my $INPUTFILE="$ARGV[0]";
my $TITLE="$ARGV[1]";
my $OUTPUTFILE=dirname($INPUTFILE) . "/$TITLE.txt";
my $output="";

open(my $fh, "<", $INPUTFILE) or die "Can't open < $INPUTFILE: $!";

while (my $line = <$fh>) {
    my $episode = "";
    my $episode_title = "";

    if ($line =~ m/(S\d+E\d+)\s+(.*)\s+(January|February|March|April|May|June|July|August|September|October|November|December|\s+\d+).*/) {
        $episode = $1;
        $episode_title = $2;
    } elsif ($line =~ m/(S\d+E\d+)\s(.*)/) {
        $episode = $1;
        $episode_title = $2;
    } else {
        next;
    }

    $episode_title =~ s/(#|“|”|"|\?|\!)//g;
    $episode_title =~ s/:/ -/g;
    $episode_title =~ s/\&/and/g;
    $episode_title =~ s/\//-/g;
    $episode_title =~ s/\t//g;
    $output = $output . "$TITLE - $episode - $episode_title\n";
}

close($fh);

open(my $outfh, ">", $OUTPUTFILE) or die "Can't open > $OUTPUTFILE: $!";
print $outfh $output;
close($outfh);

#!/usr/bin/env perl

# Rename media to the format SxxExx
# In the early days, I did a lot of SxEx. Trying to standardize

use warnings;
use strict;
use File::Basename;
use Cwd;
use File::Copy;

my $path=getcwd();

sub usage() {
    print "$0 PATH\n";
    exit;
}

# If we don't have a path to use, assume the current directory
if (scalar @ARGV == 1) {
    $path="$ARGV[0]";
}

chdir $path or die "Could not chdir to $path: $!";

opendir (DIR, $path) or die $!;

while (my $filename = readdir(DIR)) {
    my $newfilename = $filename;
    if ($filename =~ m/\sS(\d+)E(\d+)\s/) {
        my $season = $1;
        my $episode = $2;

        if ($season =~ /^[1-9]$/) {
            $season = '0' . $season;
        }

        if ($episode =~ /^[1-9]$/) {
            $episode = '0' . $episode;
        }
        my $identifier = " S" . $season . "E" . $episode . " ";
        $newfilename =~ s/\sS(\d+)E(\d+)\s/$identifier/;
        if ($filename !~ $newfilename) {
            print "Updating $filename to $newfilename\n";
            move("$filename","$newfilename");
        }
    }
    # Deal with items that don't have an episode name after the episode number
    # Copying way too much code but I'm too lazy at the moment to fix it
    if ($filename =~ m/\sS(\d+)E(\d+)\.m/) {
        my $season = $1;
        my $episode = $2;

        if ($season =~ /^[1-9]$/) {
            $season = '0' . $season;
        }

        if ($episode =~ /^[1-9]$/) {
            $episode = '0' . $episode;
        }
        my $identifier = " S" . $season . "E" . $episode;
        $newfilename =~ s/\sS(\d+)E(\d+)/$identifier/;
        if ($filename !~ $newfilename) {
            print "Updating $filename to $newfilename\n";
            move("$filename","$newfilename");
        }
    }
}
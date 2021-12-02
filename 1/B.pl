#!/usr/bin/env perl
## Part 2 perl B.pl testdatafilename

use strict;
use warnings;

my $filename = shift;
my $c=0;
my $prev = 0;
open my $handle, '<', $filename;
my @lines = <$handle>;
close $handle;
my @triplets;
my $i = 1;
my $s = 0;

my ($n1, $n2, $n3) = 0;

foreach (@lines) {
    my $v = sprintf("%d", $_);
    $n1 = $n2;
    $n2 = $n3;
    $n3 = $v;
    if ($n1 && $n2 && $n3) {
        $s = $n1 + $n2 + $n3;
#        print "Storing $s\n";
        push(@triplets, $s);
    }

}

# print "\nStarting comparision\n\n";

foreach (@triplets) {
    if ($prev && $_) {
        if ($_ > $prev) {
            $c++;
#            print "G: prev is $prev and new is $_\n"
        } else {
#           print "L: prev is $prev and new is $_\n"
        }
    }
    $prev = $_;
}
print "Number is: $c \n";
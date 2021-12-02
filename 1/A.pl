#!/usr/bin/env perl
# Part 1 cat: testdata1a.txt | perl A.pl

use strict;
use warnings;

my $c=0;
my $prev = 0;
while (<>) {
    my $v = sprintf("%d", $_);
    if ($prev && $v) {
        if ($v > $prev) {
            $c++;
 #           print "G: prev is $prev and new is $v\n"
        } else {
 #           print "L: prev is $prev and new is $v\n"
        }
    }
    $prev = $v;
}
print "Number is: $c \n";


#!/usr/bin/perl
use strict;

while(<>)
{
    my @lines = split(/ /, $_);
    foreach my $val (@lines)
    {
        print "$val\n";
    }
}

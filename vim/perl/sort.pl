#!/usr/bin/perl
use strict;

while(<>)
{
    $_ =~ s/[\n\W ]//g;
    $_ = (join '', sort { $a cmp $b } split(//, $_))."\n";
    print $_;
}

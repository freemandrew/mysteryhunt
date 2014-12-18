#!/usr/bin/perl
use strict;

while(<>)
{
    my $test = $_;
    $test =~ s/ //g;
    print $test;
}

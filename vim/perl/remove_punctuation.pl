#!/usr/bin/perl
use strict;

while(<>)
{
    $_ =~ s/[^\w\n ]//g;
    print $_;
}

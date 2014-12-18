#!/usr/bin/perl
use strict;

while (<>)
{
    chomp($_);
    my @list = split(//, $_);
    @list = reverse(@list);
    print (join '', @list);
}

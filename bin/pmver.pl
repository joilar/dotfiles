#!/bin/perl

use strict;
use warnings;

use 5.010;

for my $module (@ARGV)
{
    my $cmd = 'perl -M' . $module . ' -e "print \$' . $module . '::VERSION"';
    my $version = `$cmd`;
    say $module . ': ' . ($version || 'not present');
}


#!/usr/bin/perl

use strict;
use Debug::StrDump qw ( str_dump );

my $str = "This is a test\nI hope you know that \r\n. BELL\a.\v\v\t.";

str_dump ($str);
print "\n";

Debug::StrDump::use_dec;
print "\n";
str_dump ($str);
print "\n";

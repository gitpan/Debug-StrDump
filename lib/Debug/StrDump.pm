package Debug::StrDump;

use 5.008007;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Debug::StrDump ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.

our @EXPORT_OK = qw(
str_dump
use_hex
use_dec
dump_format
);

our @EXPORT = qw(str_dump);

our $VERSION = '1.00';

my $hex_format_str = "%2x  ";
my $dec_format_str = "%3d   ";
my $hex_filler_str = " " x 4;
my $dec_filler_str = " " x 6;

my $curr_format_str = $hex_format_str;
my $curr_filler_str = $hex_filler_str;

my $using_hex = 1;

sub str_dump {
    print "\n";
    my @chars = split (//, join ('', @_));
    my @charbuffer;
    my $i = 0;
    for (@chars){
        $i++;
        printf ($curr_format_str, ord);
        push @charbuffer, $_;
        if ($i >= 8) {
            for my $char (@charbuffer){
                if (ord ($char) <= 31){
                    print '.';
                }
                else { print ($char) }
            }
            print "\n";
            @charbuffer = ();
            $i = 0;
        }
    }
    if (@charbuffer) {
        print ($curr_filler_str x  (8 - $i));
        for my $char (@charbuffer){
                if (ord ($char) <= 31){
                    print '.';
                }
                else { print ($char) }
        }
    }
}

sub use_hex {
    return if ($using_hex);
    $using_hex = 1;
    $curr_format_str = "%2x  ";
    $curr_filler_str = "xx  ";
    return 1;
}

sub use_dec {
    return if (! $using_hex);
    $using_hex = 0;
    $curr_format_str = "%3d   ";
    $curr_filler_str = "xxx   ";
    return 1;
}

sub dump_format {
    return ($using_hex) ? "hex" : "dec";
}

"0123456789abcdef";
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Debug::StrDump - Provides a byte representation of a string.

=head1 SYNOPSIS

  use Debug::StrDump;
  my $str = "This is a test string to be dumped with StrDump.";
  $str .= "\nHere are some control characters: \a\r\n\0";
  str_dump ($str);
  

=head1 DESCRIPTION

Debug::StrDump dumps a string into an array of bytes, similar to what you see in a stack dump.
The string printed is formatted like this.

 54  68  69  73  20  69  73  This is
 20  61  20  74  65  73  74  a test

(Without monospaced formatting, this may look different)

By default, this function dumps the text as a hex string, but this is changable to decimal format

=head2 FUNCTIONS

=over 4

=item C<str_dump>

The main function used to dump a string. The function dumps to the filehandle currently selected.

=item C<use_hex>

Changes the current dump format to hex. Returns C<undef> if hex is already selected.

=item C<use_dec>

Changes the current dump format to decimal. Returns C<undef> if decimal is already selected.

=item C<dump_format>

Returns either 'hex' or 'dec' depending on what dump format is selected.

=back

=head2 EXPORT

str_dump

=head1 TODO

Add octal, sexagesimal, and floating-point representations of numbers.

=head1 AUTHOR

KScript, <lt>kscript@inbox.com<gt>

=head1 COPYRIGHT AND LICENSE

 Copyright (c) 2007, Noah Rankins
 All rights reserved
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

     1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
     2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in thedocumentation and/or other materials provided with the distribution.
     3. Neither the name of Noah Rankins nor the names of its contributors may be used to endorse or promote products derived from this softwarewithout specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY NOAH RANKINS AND CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL NOAH RANKINS AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 

=cut

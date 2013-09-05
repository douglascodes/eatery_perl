package Steakys::Main;
use 5.013;    # 5.014
use strict;
use warnings;
sub prompt_for;
sub CLomp($);

# Takes a hash and assigns values to the ref-ed scalar
# Keys started with a '*' are considered optional.
sub prompt_for() {
	my $needed;	
	say "Those marked with * are optional.";
	for ( keys $_[0] ) {
		$needed = substr($_, 0, 1) eq '*';
		do {
			say "$_?";
			} while ( !(
				( ${$_[0]{$_}} = CLomp( <> ) ) or # Gets input and continues if filled
				($needed)						# or input is not 'needed'.
					) )
	}
}

sub CLomp($){
	my $temp = shift;
	chomp $temp;
	$temp;
}

1;
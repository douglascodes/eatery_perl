use 5.013;    # 5.014
use strict;
use warnings;
use lib './';
use Steakys::Schema;
sub login_screen();
sub create_user();
sub leave();
sub session();
sub list_choices(\@);

our $dsn = "DBI:mysql:database=" . $ENV{'EATERY_DB'} . ";host=localhost";
my $schema = Steakys::Schema->connect(
    $dsn,
    $ENV{'EATERY_USER'},
    $ENV{'EATERY_PASS'},
    {   'RaiseError' => 1,
        'PrintError' => 0,
        'AutoCommit' => 1,
        'PrintWarn'  => 1
    }
);

# my $res = $schema->resultset('Customer')->find(8);
login_screen();

sub login_screen() {

	my $task_statement = "Perform what Task?\nEx. create user\n";
	my @options = ('Exit', 'Create User', 'Login', 'Print Menu', 'Print Past Orders');

	list_choices(@options);

	print $task_statement;
	
	while ( my $input = <> ) {	
		chomp $input;
		given ( $input ) {
		    leave() 				when /(0|quit|exit|leave|bye)/i;
		    create_user()	 		when /(1|(create|new) user)/i;
		    session()		 		when /(2|(sign|log)[- ]?in)/i;
		    default {
		    	print "Perhaps I stuttered...\n";
		    		list_choices(@options);
		    }
		}
	}
}

sub create_user(){
	print "User created\n";
}

sub leave(){
	print "I am leaving\n";
	exit 0;
}	

sub session(){
	print "Welcome!\n"
}

sub list_choices(\@){
	my $array = shift;
	for (0..$#{$array}) {
		print "$_.\t ${$array}[$_]\n"
	}
}


1;

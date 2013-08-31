use 5.013;    # 5.014
use strict;
use warnings;
use lib './';
use Steakys::Schema;
sub login_screen();
sub create_user();
sub leave();
sub session();
sub show_menu();
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
# show_menu();


sub login_screen() {

	my $task_query = "Perform what Task?\nEx. create user\n";
	my @options = ('Exit', 'Create User', 'Login', 'Show Menu', 'Display Past Orders');

	list_choices(@options);

	print $task_query;
	
	while ( my $input = <> ) {	
		chomp $input;
		given ( $input ) {
		    leave() 				when /(0|quit|exit|leave|bye)/i;
		    create_user()	 		when /(1|(create|new) user)/i;
		    session()		 		when /(2|(sign|log)[- ]?in)/i;
		    show_menu()		 		when /(3|menu)/i;
		    display_past_orders()	when /(4|orders|past)/i;
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

sub display_past_orders(){
	print "Here's what you've been eating.\n"
}

sub show_menu(){
	print "I recommend you eat one of these.\n";
	my $fullmenu = $schema->resultset("Steakys::Schema::Result::Item")->search;
	while ( my $menu_item = $fullmenu->next ){
		print ${menu_item}->item_name ."\t\t". ${menu_item}->price ."\n";
	}
}

sub list_choices(\@){
	my $array = shift;
	for (0..$#{$array}) {
		print "$_.\t ${$array}[$_]\n"
	}
}



1;

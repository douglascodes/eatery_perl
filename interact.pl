use 5.013;    # 5.014
use strict;
use warnings;
use lib './';
use Steakys::Schema;
use Steakys::Options;
sub login_screen();
sub create_user();
sub leave();
sub session();
sub help();
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
my $example = Steakys::Options->new( title => 'Login',
									 fun_direction => \&session );

# my $ex_string = "Currently seeing how these things work";
# $ex_string =~ s/ +/|/g;
# print $ex_string;

# print $$example{title};
print $example->expression;
# $$example{fun_direction}->();

# login_screen();
# show_menu();

sub login_screen() {

	my $task_query = "Perform what Task?\nEx. create user\n";
	my @in_session_options = my @out_session_options = my @main_options = ('Exit', 'Help', 'Show Menu');
	push(@out_session_options, ('Create User', 'Login'));
	push(@in_session_options, ('Display Past Orders', 'Create New Order', 'Cancel Order'));
	list_choices( @out_session_options) ;

	print $task_query;
	
	while ( my $input = <>) {	
		chomp $input;
		given ( $input ) {
		    leave() 				when /(0|quit|exit|leave|bye)/i;
		    create_user()	 		when /(1|(create|new) user)/i;
		    session()		 		when /(2|(sign|log)[- ]?in)/i;
		    show_menu()		 		when /(3|menu)/i;
		    display_past_orders()	when /(4|orders|past)/i;
		 	list_choices( @out_session_options ) ,
		 		print $task_query 	when /(9|help)/i;

		    default {
		    	print "Perhaps I stuttered...\n";
		    		list_choices( @out_session_options ) ;
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
	my $fullmenu = $schema->resultset("Steakys::Schema::Result::Item")->search;
	while ( my $menu_item = $fullmenu->next ){
		print ${menu_item}->item_name ."\t\t". ${menu_item}->price ."\n";
	}
	print "I recommend you eat one of these.\n";
}

sub list_choices(\@){
	my $array = shift;
	for (0..$#{$array}) {
		print "$_.\t ${$array}[$_]\n";
	}
}



1;

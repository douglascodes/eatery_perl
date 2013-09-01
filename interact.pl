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
sub list_choices;

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

login_screen();

# show_menu();

sub login_screen() {

    my $task_query = "Perform what Task?\nEx. create user\n";
    our @main_options = (
        Steakys::Options->new(
            title         => 'Exit',
            fun_direction => \&leave
        ),
        Steakys::Options->new(
            title         => 'Show Menu',
            fun_direction => \&show_menu
        )
    );
    our @out_session_options= (
        Steakys::Options->new(
            title         => 'Create User',
            fun_direction => \&create_user
        ),
        Steakys::Options->new(
            title         => 'Login',
            fun_direction => \&session
        )
    );
    
    our @in_session_options = (
    	Steakys::Options->new(
            title         => 'Create User',
            fun_direction => \&create_user
        ),
        Steakys::Options->new(
            title         => 'Order Food',
            fun_direction => \&order_food
        )
        
    	);
    
    # push( @out_session_options, ( 'Create User', 'Login' ) );
    # push( @in_session_options,
    #     ( 'Display Past Orders', 'Create New Order', 'Cancel Order' ) );
# Tried here to use an array of Option objects. Where structure is:
#  	Option->title = User facing title of the option.
#  	Option->expression = Title formed into a regular expression for combination with numeric option
# 	Option->fun_direction = Code ref to the activated sub routine.
# 	This allows common options to be combined into Larger menus, and numbering of the options is dynamic and
#   relates to the entry that can be made in the regex match.
    list_choices( @main_options, @out_session_options );

    print $task_query;
    while ( my $input = <> ) {
    	my $i = 1; 
        chomp $input;
        given ($input) {
        	for my $opt (@main_options) {
            	$opt->fun_direction->() when /${ \$opt->expression }|$i/i ;
        		print $i++;
        	}
			default { print "Perhaps I stuttered...\n";
	        list_choices(@main_options); }
        }
    }
}

sub create_user() {
    print "User created\n";
}

sub leave() {
    print "I am leaving\n";
    exit 0;
}

sub session() {
    print "Welcome!\n";
}

sub display_past_orders() {
    print "Here's what you've been eating.\n";
}

sub show_menu() {
    my $fullmenu
        = $schema->resultset("Steakys::Schema::Result::Item")->search;
    while ( my $menu_item = $fullmenu->next ) {
        print ${menu_item}->item_name . "\t\t" . ${menu_item}->price . "\n";
    }
    print "I recommend you eat one of these.\n";
}

sub list_choices() {
    my $counter = 1;
    for ( @_ ) { 
        print "$counter.\t $_->{title}\n";
    	$counter++; 
    }
}

sub order_food(){
	print "Yummy. Your order has been placed.\n"
}
1;

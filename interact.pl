use 5.013;    # 5.014
use strict;
use warnings;
use lib './';
use Steakys::Schema;
use Steakys::Options;

package Steakys::Main;
sub create_user();
sub log_in_user(\$);
sub menu_choices_with_subs;
sub leave();
sub display_past_orders(\$);
sub help();
sub show_menu();
sub list_choices;
sub CLomp($);
sub prompt_for;

our $dsn    = "DBI:mysql:database=" . $ENV{'EATERY_DB'} . ";host=localhost";
our $schema = Steakys::Schema->connect(
    $dsn,
    $ENV{'EATERY_USER'},
    $ENV{'EATERY_PASS'},
    {   'RaiseError' => 1,
        'PrintError' => 0,
        'AutoCommit' => 1,
        'PrintWarn'  => 1
    }
);

main();

sub main {
    my $current_user;
    my $task_query
        = "Perform what Task?\nEx. create user OR use option numbers.\n";
    my @main_options = (
        Steakys::Options->new(
            title => 'Exit',
            code  => \&leave
        ),
        Steakys::Options->new(
            title => 'Show Menu',
            code  => \&show_menu
        )
    );

    my @out_session_options = (
        Steakys::Options->new(
            title => 'Create User',
            code  => \&create_user
        ),
        Steakys::Options->new(
            title => 'Log in',
            code  => sub { log_in_user($current_user) }
        )
    );

    my @in_session_options = (

        # Steakys::Options->new(
        #     title => 'Log Out',

# # There is no real reason to do it this way. Just thought I'd give it a try.
# # after all this is a learning exercise. Throws a warning.
#       code => sub { last MENU_ } # Where menu is a pointer to the loop beginning.
#   ),
        Steakys::Options->new(
            title => 'Order Food',
            code  => \&order_food
        ),
        Steakys::Options->new(
            title => 'Review my orders',
            code  => sub { display_past_orders($current_user) }
        ),
        Steakys::Options->new(
            title => 'Log out',
            code  => sub { undef $current_user }
            )

    );

    while (1) {
        while ( !( defined $current_user ) ) {
            menu_choices_with_subs( $task_query, @main_options,
                @out_session_options );
        }

        while ( defined $current_user ) {
            menu_choices_with_subs( $task_query, @main_options,
                @in_session_options );
        }
    }
}

sub menu_choices_with_subs {

# Tried here to use an array of Option objects. Where structure is:
#   Option->title = User facing title of the option.
#   Option->expression = Title formed into a regular expression for combination with numeric option
#   Option->code = Code ref to the activated sub routine.
#   This allows common options to be combined into Larger menus, and numbering of the options is dynamic and
#   relates to the entry that can be made in the regex match.
    $_ = shift;
    print $_;
    list_choices(@_);

    my $i     = 1;
    my $input = <>;
    chomp $input;
    given ($input) {
        for my $opt (@_) {
            $opt->code->() when /${ \$opt->expression }|$i/i;
            $i++;
        }
        default { print "Perhaps I stuttered...\n\n" }
    }

}

sub log_in_user(\$) {
    my $user = shift;
    my $user_check;

    do {
        my $email;
        my $phone;
        my $last;

        prompt_for(
            {   "Email"     => \$email,
                "Phone"     => \$phone,
                "Last Name" => \$last
            }
        );

        $user_check
            = $schema->resultset('Steakys::Schema::Result::Customer')
            ->search(
            {   lastname => $last,
                phone    => $phone,
                email    => $email
            },
            { key => 'uc_CustomerIS' }
            );

        } while ( !( defined $user_check )
        && print "Sign in not valid.\nPlease try again.\n\n" );

    if ( $$user = $user_check->single() ) {
        say "Hello " . $$user->firstname();
    }
    else {
        say "Unrecognized user, please check your information.";
    }
}

sub create_user() {
    print "User created\n";
}

sub leave() {
    print "I am leaving\n";
    exit 0;
}

sub display_past_orders(\$) {
    my $user = shift;
    my $q1 = {cust_id => $$user->id};
    my $past_orders
        = $schema->resultset("Steakys::Schema::Result::Order")->search($q1);
    while ( my $order = $past_orders->next ) {
        my $q2 = { order_id => ${order}->id};
        say "Order from: ". $order->order_date;
        my $single_order =
            $schema->resultset("Steakys::Schema::Result::OrderLine")->search($q2);
        while ( my $order_line = $single_order->next){
            print ${order_line}->item_id . "\t\t" . ${order_line}->qty . "\n";
        }
    
    }

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
    for (@_) {
        print "(" . $counter++ . ")" . "\t $_->{title}\n";
    }
}

sub order_food() {
    print "Yummy. Your order has been placed.\n";
}

sub prompt_for() {
    my $needed;
    say "Those marked with * are optional.";
    for ( keys $_[0] ) {
        $needed = substr( $_, 0, 1 ) eq '*';
        do {
            say "$_?";
            } while (
            !(  ( ${ $_[0]{$_} } = CLomp(<>) )
                or           # Gets input and continues if filled
                ($needed)    # or input is not 'needed'.
            )
            );
    }
}

sub CLomp($) {
    my $temp = shift;
    chomp $temp;
    $temp;
}

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
#       code => sub { last MENU_ }
#   ),
        Steakys::Options->new(
            title => 'Order Food',
            code  => \&order_food
        ),
        Steakys::Options->new(
            title => 'Review my orders',
            code  => \&display_past_orders
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

        while ( ( defined $current_user ) ) {
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
        default { print "Perhaps I stuttered...\n" }
    }

}

sub log_in_user(\$) {
    my $user = shift;
    $$user = "Douglas";
}

sub create_user() {
    print "User created\n";
}

sub leave() {
    print "I am leaving\n";
    exit 0;
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
    for (@_) {
        print $counter++ . "\t $_->{title}\n";
    }
}

sub order_food() {
    print "Yummy. Your order has been placed.\n";
}

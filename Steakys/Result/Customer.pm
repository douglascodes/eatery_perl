package MyApp::Schema::Result::Customer;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('customer');
__PACKAGE__->add_columns(qw/ customerid first_name last_name member_since phone email /);
__PACKAGE__->set_primary_key('customerid');
__PACKAGE__->has_many(orders => 'MyApp::Schema::Result::Order', 'customerid');

1;
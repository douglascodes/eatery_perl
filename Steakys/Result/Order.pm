package MyApp::Schema::Result::Order;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('order');
__PACKAGE__->add_columns(qw/ orderid order_placed_at /);
__PACKAGE__->set_primary_key('orderid');
__PACKAGE__->belongs_to(customer => 'MyApp::Schema::Result::Customer');
1;
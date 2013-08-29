package MyApp::Schema;
use warnings;
use strict;
use Try::Tiny

use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_namespaces();

->connect_info("DBI:mysql:database=". $ENV{'EATERY_DB'} .";host=localhost",
 	 $ENV{'EATERY_USER'}, $ENV{'EATERY_PASS'},
 	 {'RaiseError' => 1}))

1;
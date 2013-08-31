use utf8;
package Steakys::Schema::Result::Customer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Steakys::Schema::Result::Customer

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<Customers>

=cut

__PACKAGE__->table("Customers");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 firstname

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 lastname

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 phone

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 member_since

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "firstname",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "lastname",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "phone",
  { data_type => "char", is_nullable => 0, size => 10 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "member_since",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uc_CustomerIS>

=over 4

=item * L</lastname>

=item * L</email>

=item * L</phone>

=back

=cut

__PACKAGE__->add_unique_constraint("uc_CustomerIS", ["lastname", "email", "phone"]);

=head1 RELATIONS

=head2 orders

Type: has_many

Related object: L<Steakys::Schema::Result::Order>

=cut

__PACKAGE__->has_many(
  "orders",
  "Steakys::Schema::Result::Order",
  { "foreign.cust_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-08-30 18:05:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+GbjPx8Se7P4qnziSnaM3A
# These lines were loaded from './Steakys/Schema/Result/Customer.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package MyApp::Schema::Result::Customer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Customer

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<Customers>

=cut

__PACKAGE__->table("Customers");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 firstname

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 lastname

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 phone

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 member_since

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "firstname",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "lastname",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "phone",
  { data_type => "char", is_nullable => 0, size => 10 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "member_since",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uc_CustomerIS>

=over 4

=item * L</lastname>

=item * L</email>

=item * L</phone>

=back

=cut

__PACKAGE__->add_unique_constraint("uc_CustomerIS", ["lastname", "email", "phone"]);

=head1 RELATIONS

=head2 orders

Type: has_many

Related object: L<MyApp::Schema::Result::Order>

=cut

__PACKAGE__->has_many(
  "orders",
  "MyApp::Schema::Result::Order",
  { "foreign.cust_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-08-30 17:20:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nt8VJp4XIIpqBzpWMMCR0w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './Steakys/Schema/Result/Customer.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

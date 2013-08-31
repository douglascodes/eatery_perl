use utf8;
package Steakys::Schema::Result::Order;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Steakys::Schema::Result::Order

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

=head1 TABLE: C<Orders>

=cut

__PACKAGE__->table("Orders");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 order_date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 cust_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "order_date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "cust_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cust

Type: belongs_to

Related object: L<Steakys::Schema::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "cust",
  "Steakys::Schema::Result::Customer",
  { id => "cust_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 order_lines

Type: has_many

Related object: L<Steakys::Schema::Result::OrderLine>

=cut

__PACKAGE__->has_many(
  "order_lines",
  "Steakys::Schema::Result::OrderLine",
  { "foreign.order_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-08-30 18:05:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:J1iE15NfUOud3+OoCMtgQQ
# These lines were loaded from './Steakys/Schema/Result/Order.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package MyApp::Schema::Result::Order;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Order

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

=head1 TABLE: C<Orders>

=cut

__PACKAGE__->table("Orders");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 order_date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 cust_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "order_date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "cust_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cust

Type: belongs_to

Related object: L<MyApp::Schema::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "cust",
  "MyApp::Schema::Result::Customer",
  { id => "cust_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 order_lines

Type: has_many

Related object: L<MyApp::Schema::Result::OrderLine>

=cut

__PACKAGE__->has_many(
  "order_lines",
  "MyApp::Schema::Result::OrderLine",
  { "foreign.order_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-08-30 17:20:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fGehx/Q00QS024mzW4Rpkg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './Steakys/Schema/Result/Order.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

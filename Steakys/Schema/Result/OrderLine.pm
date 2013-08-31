use utf8;
package Steakys::Schema::Result::OrderLine;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Steakys::Schema::Result::OrderLine

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

=head1 TABLE: C<OrderLines>

=cut

__PACKAGE__->table("OrderLines");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 order_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 item_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 qty

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "order_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "item_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "qty",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uc_OrderLineIS>

=over 4

=item * L</order_id>

=item * L</item_id>

=back

=cut

__PACKAGE__->add_unique_constraint("uc_OrderLineIS", ["order_id", "item_id"]);

=head1 RELATIONS

=head2 item

Type: belongs_to

Related object: L<Steakys::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "item",
  "Steakys::Schema::Result::Item",
  { sku => "item_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 order

Type: belongs_to

Related object: L<Steakys::Schema::Result::Order>

=cut

__PACKAGE__->belongs_to(
  "order",
  "Steakys::Schema::Result::Order",
  { id => "order_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-08-30 18:05:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5G4InlXgNil1ECoouMSJJA
# These lines were loaded from './Steakys/Schema/Result/OrderLine.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package MyApp::Schema::Result::OrderLine;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::OrderLine

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

=head1 TABLE: C<OrderLines>

=cut

__PACKAGE__->table("OrderLines");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 order_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 item_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 qty

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "order_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "item_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "qty",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uc_OrderLineIS>

=over 4

=item * L</order_id>

=item * L</item_id>

=back

=cut

__PACKAGE__->add_unique_constraint("uc_OrderLineIS", ["order_id", "item_id"]);

=head1 RELATIONS

=head2 item

Type: belongs_to

Related object: L<MyApp::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "item",
  "MyApp::Schema::Result::Item",
  { sku => "item_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);

=head2 order

Type: belongs_to

Related object: L<MyApp::Schema::Result::Order>

=cut

__PACKAGE__->belongs_to(
  "order",
  "MyApp::Schema::Result::Order",
  { id => "order_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "RESTRICT",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-08-30 17:20:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7GfZZ7kAP4ywwBGWFIrqYQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './Steakys/Schema/Result/OrderLine.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

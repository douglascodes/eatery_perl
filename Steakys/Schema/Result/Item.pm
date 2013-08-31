use utf8;
package Steakys::Schema::Result::Item;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Steakys::Schema::Result::Item

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

=head1 TABLE: C<Items>

=cut

__PACKAGE__->table("Items");

=head1 ACCESSORS

=head2 sku

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 item_name

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 price

  data_type: 'decimal'
  is_nullable: 1
  size: [4,2]

=head2 gluten_free

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

=head2 needs_temp

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

=head2 prep_locations

  data_type: 'bit'
  is_nullable: 1
  size: 4

=head2 protein

  data_type: 'char'
  is_nullable: 1
  size: 4

=head2 update_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sku",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "item_name",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "price",
  { data_type => "decimal", is_nullable => 1, size => [4, 2] },
  "gluten_free",
  { data_type => "tinyint", default_value => 0, is_nullable => 1 },
  "needs_temp",
  { data_type => "tinyint", default_value => 0, is_nullable => 1 },
  "prep_locations",
  { data_type => "bit", is_nullable => 1, size => 4 },
  "protein",
  { data_type => "char", is_nullable => 1, size => 4 },
  "update_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</sku>

=back

=cut

__PACKAGE__->set_primary_key("sku");

=head1 UNIQUE CONSTRAINTS

=head2 C<uc_ItemIS>

=over 4

=item * L</item_name>

=item * L</price>

=back

=cut

__PACKAGE__->add_unique_constraint("uc_ItemIS", ["item_name", "price"]);

=head1 RELATIONS

=head2 order_lines

Type: has_many

Related object: L<Steakys::Schema::Result::OrderLine>

=cut

__PACKAGE__->has_many(
  "order_lines",
  "Steakys::Schema::Result::OrderLine",
  { "foreign.item_id" => "self.sku" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-08-30 18:05:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1rukc/ve9UpJtW+pV9BOMQ
# These lines were loaded from './Steakys/Schema/Result/Item.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package MyApp::Schema::Result::Item;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Item

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

=head1 TABLE: C<Items>

=cut

__PACKAGE__->table("Items");

=head1 ACCESSORS

=head2 sku

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 item_name

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 price

  data_type: 'decimal'
  is_nullable: 1
  size: [4,2]

=head2 gluten_free

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

=head2 needs_temp

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

=head2 prep_locations

  data_type: 'bit'
  is_nullable: 1
  size: 4

=head2 protein

  data_type: 'char'
  is_nullable: 1
  size: 4

=head2 update_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sku",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "item_name",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "price",
  { data_type => "decimal", is_nullable => 1, size => [4, 2] },
  "gluten_free",
  { data_type => "tinyint", default_value => 0, is_nullable => 1 },
  "needs_temp",
  { data_type => "tinyint", default_value => 0, is_nullable => 1 },
  "prep_locations",
  { data_type => "bit", is_nullable => 1, size => 4 },
  "protein",
  { data_type => "char", is_nullable => 1, size => 4 },
  "update_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</sku>

=back

=cut

__PACKAGE__->set_primary_key("sku");

=head1 UNIQUE CONSTRAINTS

=head2 C<uc_ItemIS>

=over 4

=item * L</item_name>

=item * L</price>

=back

=cut

__PACKAGE__->add_unique_constraint("uc_ItemIS", ["item_name", "price"]);

=head1 RELATIONS

=head2 order_lines

Type: has_many

Related object: L<MyApp::Schema::Result::OrderLine>

=cut

__PACKAGE__->has_many(
  "order_lines",
  "MyApp::Schema::Result::OrderLine",
  { "foreign.item_id" => "self.sku" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-08-30 17:20:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4s2FTTZLvIBfdLUOQ0RrNg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './Steakys/Schema/Result/Item.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

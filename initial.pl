 package Library::Schema;
  use base qw/DBIx::Class::Schema/;

  # load all Result classes in Library/Schema/Result/
  __PACKAGE__->load_namespaces();

  package Library::Schema::Result::CD;
  use base qw/DBIx::Class::Core/;

  __PACKAGE__->load_components(qw/InflateColumn::DateTime/); # for example
  __PACKAGE__->table('cd');

  my $schema1 = Library::Schema->connect(
    "localhost",
    "perltest",
    "yummB4s3",
    { AutoCommit => 1 },
  );

 package My::Schema::Result::Person;

  use parent 'DBIx::Class::Core';

  __PACKAGE__->table('Person');

  __PACKAGE__->add_columns({
    id => {
      data_type => 'int',
      is_auto_increment => 1,
      primary_key => 1,
    },
    firstname => {
      data_type => 'varchar',
      size => 20,
    },
    phone => {
      data_type => 'char',
      size => 10,
    },
    address => {
      data_type => 'text',
      size => 50,
    },
    member_since => {
      data_type => 'timestamp',
      size => 8,
    },
  });

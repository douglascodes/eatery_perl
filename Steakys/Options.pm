package Steakys::Options;
use 5.013;    # 5.014
use strict;
use warnings;
use Moose;
sub _build_expression();

has 'title'         => ( is => 'rw', isa => 'Str' );
has 'fun_direction' => ( is => 'rw', isa => 'CodeRef' );
has 'expression'    => (
    is      => 'rw',
    lazy    => 1,
    builder => '_build_expression',
    isa     => 'Str'
);

# sub BUILD {
# }

sub _build_expression() {
    my $self = shift;
    $self->title() =~ s/ +/[\\s-]*/gir;
}

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    return $class->$orig(@_);
};

1;

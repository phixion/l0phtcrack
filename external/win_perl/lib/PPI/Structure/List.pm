package PPI::Structure::List;

=pod

=head1 NAME

PPI::Structure::List - Explicit list or precedence ordering braces

=head1 SYNOPSIS

  # A list used for params
  function( 'param', 'param' );
  
  # Explicit list
  return ( 'foo', 'bar' );

=head1 INHERITANCE

  PPI::Structure::List
  isa PPI::Structure
      isa PPI::Node
          isa PPI::Element

=head1 DESCRIPTION

C<PPI::Structure::List> is the class used for circular braces that
represent lists, and related.

=head1 METHODS

C<PPI::Structure::List> has no methods beyond those provided by the
standard L<PPI::Structure>, L<PPI::Node> and L<PPI::Element> methods.

=cut

use strict;
use Carp           ();
use PPI::Structure ();

use vars qw{$VERSION @ISA};
BEGIN {
	$VERSION = '1.236';
	@ISA     = 'PPI::Structure';
}

# Highly special custom isa method that will continue to respond
# positively to ->isa('PPI::Structure::ForLoop') but warns.
my $has_warned = 0;
sub isa {
	if ( $_[1] and $_[1] eq 'PPI::Structure::ForLoop' ) {
		if (
			$_[0]->parent->isa('PPI::Statement::Compound')
			and
			$_[0]->parent->type =~ /^for/
		) {
			unless ( $has_warned ) {
				local $Carp::CarpLevel = $Carp::CarpLevel + 1;
				Carp::carp("PPI::Structure::ForLoop has been deprecated");
				$has_warned = 1;
			}
			return 1;
		}
	}
	return shift->SUPER::isa(@_);
}

1;

=pod

=head1 SUPPORT

See the L<support section|PPI/SUPPORT> in the main module.

=head1 AUTHOR

Adam Kennedy E<lt>adamk@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2001 - 2011 Adam Kennedy.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
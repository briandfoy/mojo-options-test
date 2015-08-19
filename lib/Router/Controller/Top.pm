package Router::Controller::Top;
use Mojo::Base 'Mojolicious::Controller';

sub welcome {
	my $self = shift;

	my $hash_ref = { foo => 'This is the welcome bit' };
	$self->render_json( $hash_ref );
	}

sub options {
	my $self = shift;

	my $children = $self->app->routes->children;
	my %children = map { $_->to_string => 1 } @$children;
	
	my $hash = { options => \%children };

	$self->render_json( $hash );
	}

sub _walk {
  my ($route, $depth, $rows, $verbose) = @_;

  # Pattern
  my $prefix = '';
  if (my $i = $depth * 2) { $prefix .= ' ' x $i . '+' }
  push @$rows, my $row = [$prefix . ($route->pattern->unparsed || '/')];

  # Flags
  my @flags;
  push @flags, @{$route->over || []} ? 'C' : '.';
  push @flags, (my $partial = $route->partial) ? 'D' : '.';
  push @flags, $route->inline       ? 'U' : '.';
  push @flags, $route->is_websocket ? 'W' : '.';
  push @$row, join('', @flags) if $verbose;

  # Methods
  my $via = $route->via;
  push @$row, !$via ? '*' : uc join ',', @$via;

  # Name
  my $name = $route->name;
  push @$row, $route->has_custom_name ? qq{"$name"} : $name;

  # Regex (verbose)
  my $pattern = $route->pattern;
  $pattern->match('/', $route->is_endpoint && !$partial);
  my $regex  = (regexp_pattern $pattern->regex)[0];
  my $format = (regexp_pattern($pattern->format_regex))[0];
  push @$row, $regex, $format ? $format : '' if $verbose;

  $depth++;
  _walk($_, $depth, $rows, $verbose) for @{$route->children};
  $depth--;
}
	
sub render_json {
	my( $self, $hash ) = @_;

	$self->render( json => $self->decorate_hash( $hash ) );
	}

sub decorate_hash {
	my( $self, $hash ) = @_;

	return if exists $hash->{meta};

	$hash->{meta} = {
		version   => '0.1',
		responder => ref $self,
		};
		
	$hash;
	}

1;

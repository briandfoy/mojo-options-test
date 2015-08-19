package Router::Controller::One;
use Mojo::Base 'Router::Controller::Top';

sub get_routes {
	my $controller  =  __PACKAGE__ =~ s/.*:://r;
	
	my @paths = map { $_->{controller} = lc $controller; $_ }
		(
			{
			method     => 'get',
			path       => '/one',
			action     => 'show_one',
			},

			{
			method => 'get',
			path   => '/one/:id',
			action => 'show_one_by_id',
			},
		);

	}

sub show_one {
	my $self = shift;

	my $hash = { value => 'one' };
	$self->render_json( $hash );
	}
	
sub show_one_by_id {
	my $self = shift;

	my $hash = { value => 'one', id => 137 };
	$self->render_json( $hash );
	}

__PACKAGE__

__END__

package Router::Controller::Bird;
use Mojo::Base 'Router::Controller::Top';

sub get_routes {
	my $controller  =  __PACKAGE__ =~ s/.*:://r;
	
	my @paths = map { $_->{controller} = lc $controller; $_ }
		(
			{
			method      => 'get',
			path        => '/birds',
			action      => 'show_all_birds',
			description => 'Get all the birds',
			params      => {},
			},

			{
			method      => 'get',
			path        => '/bird/:id',
			action      => 'show_bird_by_id',
			description => 'Get a particular bird',
			params      => {
				id => {
					required    => 1,
					type        => 'integer',
					description => 'The microchip for the bird',
					}
				},
			},
		);

	}

sub show_all_birds {
	my $self = shift;

	my $hash = { value => 'one' };
	$self->render_json( $hash );
	}
	
sub show_bird_by_id {
	my $self = shift;

	my $hash = { value => 'one', id => 137 };
	$self->render_json( $hash );
	}

__PACKAGE__

__END__

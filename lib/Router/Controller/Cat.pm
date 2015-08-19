package Router::Controller::Cat;
use Mojo::Base 'Router::Controller::Top';

sub get_routes {
	my $controller  =  __PACKAGE__ =~ s/.*:://r;
	
	my @paths = map { $_->{controller} = lc $controller; $_ }
		(
			{
			method      => 'get',
			path        => '/cats',
			action      => 'show_all_cats',
			description => 'Get all the cats',
			params      => {},
			},

			{
			method      => 'get',
			path        => '/cat/:id',
			action      => 'show_cat_by_id',
			description => 'Get a particular cat',
			params      => {
				id => {
					required    => 1,
					type        => 'integer',
					description => 'The microchip for the cat',
					}
				},
			},
		);
	}

sub show_all_cats {
	my $self = shift;
	
	my $hash = { value => 'three' };
	$self->render_json( $hash );
	}
	
sub show_cat_by_id {
	my $self = shift;

	my $hash = { value => 'three', id => 41 };
	$self->render_json( $hash );
	}

__PACKAGE__

__END__

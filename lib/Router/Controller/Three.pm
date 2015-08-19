package Router::Controller::Three;
use Mojo::Base 'Router::Controller::Top';

sub get_routes {
	my $controller  =  __PACKAGE__ =~ s/.*:://r;
	
	my @paths = map { $_->{controller} = lc $controller; $_ }
		(
			{
			method     => 'get',
			path       => '/three',
			action     => 'show_three',
			},

			{
			method => 'get',
			path   => '/three/:id',
			action => 'show_three_by_id',
			},
		);
	}

sub show_three {
	my $self = shift;
	
	my $hash = { value => 'three' };
	$self->render_json( $hash );
	}
	
sub show_three_by_id {
	my $self = shift;

	my $hash = { value => 'three', id => 41 };
	$self->render_json( $hash );
	}

__PACKAGE__

__END__

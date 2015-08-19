package Router::Controller::Two;
use Mojo::Base 'Router::Controller::Top';

sub get_routes {
	my $controller  =  __PACKAGE__ =~ s/.*:://r;
	
	my @paths = map { $_->{controller} = lc $controller; $_ }
		(
			{
			method     => 'get',
			path       => '/two',
			action     => 'show_two',
			},

			{
			method => 'get',
			path   => '/two/:id',
			action => 'show_two_by_id',
			},
		);
	}

sub show_two {
	my $self = shift;

	my $hash = { value => 'two', id => 37 };
	$self->render_json( $hash );
	}
	
sub show_two_by_id {
	my $self = shift;

	my $hash = { value => 'two', id => 37 };
	$self->render_json( $hash );
	}

__PACKAGE__

__END__

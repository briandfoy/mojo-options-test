package Router::Controller::Dog;
use Mojo::Base 'Router::Controller::Top';

sub get_routes {
	my $controller  =  __PACKAGE__ =~ s/.*:://r;
	
	my @paths = map { $_->{controller} = lc $controller; $_ }
		(
			{
			method      => 'get',
			path        => '/dogs',
			action      => 'show_all_dogs',
			description => 'Get all the dogs',
			params      => {},
			},

			{
			method      => 'get',
			path        => '/dog/:id',
			action      => 'show_dog_by_id',
			description => 'Get a particular dog',
			params      => {
				id => {
					required    => 1,
					type        => 'integer',
					description => 'The microchip for the dog',
					}
				},
			},
		);
	}

sub dogs {
	my $self = shift;
	
	{
	7  => { name => 'Nikki' },
	13 => { name => 'Rin Tin Tin' },
	17 => { name => 'Lassie' },
	}

	}

sub show_all_dogs {
	my $self = shift;

	my $dogs = $self->dogs;
	my @results;
	foreach my $id ( %$dogs ) {
		my $hash = $dogs->{$id};
		$hash->{id} = $id;
		push @results, $hash;	
		}

	my $hash = { results => \@results };
	$self->render_json( $hash );
	}
	
sub show_dog_by_id {
	my $self = shift;

	my $want_id = $self->param('id');

	my $dogs = $self->dogs;
	my @results;
	foreach my $id ( %$dogs ) {
		next unless $id == $want_id;
		my $hash = $dogs->{$id};
		$hash->{id} = $id;
		push @results, $hash;	
		}

	return $self->reply->not_found unless @results;

	my $hash = { results => \@results };
	$self->render_json( $hash );
	}

__PACKAGE__

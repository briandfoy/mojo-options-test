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

sub cats {
	my $self = shift;

	{
	137  => { name => 'Buster' },
	39   => { name => 'Mimi' },
	37   => { name => 'Roscoe' },
	}

	}

sub show_all_cats {
	my $self = shift;

	my $cats = $self->cats;
	my @results;
	foreach my $id ( %$cats ) {
		my $hash = $cats->{$id};
		$hash->{id} = $id;
		push @results, $hash;
		}

	my $hash = { results => \@results };
	$self->render_json( $hash );
	}

sub show_cat_by_id {
	my $self = shift;

	my $want_id = $self->param('id');

	my $cats = $self->cats;
	my @results;
	foreach my $id ( %$cats ) {
		next unless $id == $want_id;
		my $hash = $cats->{$id};
		$hash->{id} = $id;
		push @results, $hash;
		}

	return $self->reply->not_found unless @results;

	my $hash = { results => \@results };
	$self->render_json( $hash );
	}

__PACKAGE__

__END__

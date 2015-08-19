package Router::Routes::One;

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

__PACKAGE__

__END__

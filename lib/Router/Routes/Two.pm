package Router::Routes::Two;

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

__PACKAGE__

__END__

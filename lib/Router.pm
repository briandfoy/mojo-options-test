package Router;
use Mojo::Base 'Mojolicious';

use Mojo::Loader qw(data_section find_modules load_class);
use Mojo::Util qw(dumper);

sub startup {
	my $self = shift;

	my $config = $self->app->plugin('Config');
	my $log    = $self->app->log;

	$self->routes->get('/')->to(
		controller => 'top',
		action     => 'welcome',
		);

	$self->routes->get('/buster')->to(
		controller => 'top',
		action     => 'welcome',
		);

	$self->routes->options('/')->to(
		controller => 'top',
		action     => 'options',
		);

	my @routing_modules = find_modules( 'Router::Routes' );
	$self->app->log->info( "Routing modules are @routing_modules" );
	
	foreach my $module ( @routing_modules ) {
		$self->app->log->debug( "Trying $module" );
		next unless exists
			$self->app->config->{enabled_routes};

		$self->app->log->debug( "Still trying $module" );

		my $e = load_class( $module );
		$self->app->log->info( "Exception: " . dumper( $e ) )
			if defined $e;
		
		next unless $module->can( 'get_routes' );

		foreach my $route ( $module->get_routes ) {
			my $method = $route->{method};

			$self->app->log->debug( "$module $method" );
			$self->app->log->debug( "\tController is $route->{controller}" );
			$self->app->log->debug( "\tAction is $route->{action}" );

			$self->routes->$method( $route->{path} )->to(
				controller => $route->{controller},
				action     => $route->{action},
				);
			}
		}
	}


1;

use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Router');
$t->options_ok('/')->status_is(200);

done_testing();

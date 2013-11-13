#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Test::Puppet::Compile' ) || print "Bail out!
";
}

diag( "Testing Test::Puppet::Compile $Test::Puppet::Compile::VERSION, Perl $], $^X" );

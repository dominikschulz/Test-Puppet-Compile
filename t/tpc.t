#!perl -w

use strict;
use warnings;

use Cwd;
use Test::More;
use Test::Puppet::Compile;

my $PTC = Test::Puppet::Compile::->new({
  'name'       => 'mock-test',
  'manifests'  => [('manifests/site.pp')],
  'basedir'    => getcwd(),
  'reqenvs'    => [qw(prod)],
  'moduledirs' => [qw(modules services)],
  'warnings'   => 0,
  'cleanup'    => 1,
  'domainpattern' => [
    {
      'match'   => qr/^foo-/,
      'domain'  => 'bar.com',
    },
  ],
  'defaultdomain' => 'foo-bar.net',
});

my $tempdir = $PTC->tempdir(); # remember for later
ok(-d $tempdir,'Tempdir exists');

ok($PTC->_create_skeleton(),'Skeleton created');
foreach my $d (qw(out log run ssl var var/yaml var/yaml/facts var/yaml/node)) {
  ok(-d $tempdir.'/'.$d,'Got dir '.$d);
  my $perms = (stat($tempdir.'/'.$d))[2] & 0777;
  $perms = sprintf "%04o", $perms;
  is($perms,'0777','Dir '.$d.' has mode 777');
}

$PTC = undef;

done_testing();
# TODO more tests ...

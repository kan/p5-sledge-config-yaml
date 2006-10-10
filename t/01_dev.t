use strict;
use Test::More tests => 12;

BEGIN { 
    use_ok 'Sledge::Config::YAML';
    use_ok 'YAML';
}

my $config = Sledge::Config::YAML->new('develop_user', 't/example.yaml');
my $yaml   = YAML::LoadFile('t/example.yaml');

is(($config->datasource)[0],        (@{$yaml->{develop}->{datasource}})[0],          'db schema');
is(($config->datasource)[1],        (@{$yaml->{develop}->{datasource}})[1],          'db user');
is(($config->datasource)[2],        (@{$yaml->{develop}->{datasource}})[2],          'db password');
is(($config->session_servers)[0],   (@{$yaml->{develop}->{session_servers}})[0],     'session_servers');
is(($config->cache_servers)[0],     (@{$yaml->{develop}->{cache_servers}})[0],       'cache_servers');
is($config->tmpl_path,              $yaml->{develop_user}->{tmpl_path},              'tmpl_path');
is($config->host,                   $yaml->{develop_user}->{host},                   'host');
is($config->validator_message_file, $yaml->{develop_user}->{validator_message_file}, 'validator_message_file');
is($config->info_addr,              $yaml->{develop_user}->{info_addr},              'info_addr');
is($config->favorite,               $yaml->{common}->{favorite},                     'common data');


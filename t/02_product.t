use strict;
use Test::Base;

use Sledge::Config::YAML;
use Data::Visitor::Callback;
use YAML;

my $yaml   = YAML::LoadFile('t/example.yaml');

sub config {
    my $method = $_[0];
    my @val = Sledge::Config::YAML->new('product', 't/example.yaml')->$method;
    return scalar(@val) > 1 ? \@val : $val[0];
}

sub yaml_use_home {
    my $val = eval $_;
    my $v = Data::Visitor::Callback->new(
        plain_value => sub {
            return unless defined $_;
            s{__ENV:(.+)__}{ $ENV{$1} }e;
        }
    );
    $v->visit( $val );

    return ref($val) eq 'ARRAY' ? (scalar(@$val)==1 ? $val->[0] : $val ) : $val;
}

filters {
    input    => [ 'chomp', 'config' ],
    expected => [ 'chomp', 'yaml_use_home' ],
};

run_is_deeply 'input' => 'expected';

__END__

=== datasource 
--- input
datasource
--- expected
$yaml->{product}->{datasource}

=== session_servers
--- input
session_servers
--- expected
$yaml->{product}->{session_servers}

=== cache_servers
--- input
cache_servers
--- expected
$yaml->{product}->{cache_servers}

=== host
--- input
host
--- expected
$yaml->{product}->{host}

=== info_addr
--- input
info_addr
--- expected
$yaml->{product}->{info_addr}

=== common data
--- input
favorite
--- expected
$yaml->{common}->{favorite}

=== tmpl_path
--- input
tmpl_path
--- expected
$yaml->{product}->{tmpl_path}

=== validator_message_file
--- input
validator_message_file
--- expected
$yaml->{product}->{validator_message_file}


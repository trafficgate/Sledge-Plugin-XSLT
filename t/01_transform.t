use strict;
use Test::More tests => 3;

package Test::Pages;
use Sledge::Plugin::XSLT;
use Test::More;

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self;
}

sub add_filter {
    my($self, $code) = @_;
my $xml =<<'XML';
<?xml version="1.0" encoding="euc-jp" ?>
<frameworks>
<software>
<name>Sledge</name>
<version>1.10</version>
<url>http://sl.edge.jp/</url>
</software>
<software>
<name>Struts</name>
<version>1.02</version>
<url>http://jakarta.apache.org/struts/</url>
</software>
<software>
<name>Turbine</name>
<version>2.2.0</version>
<url>http://jakarta.apache.org/turbine/</url>
</software>
</frameworks>
XML
    my $out = $code->($self, $xml);
    like($out, qr@Sledge,1.10,http://sl.edge.jp/@);
    like($out, qr@Struts,1.02,http://jakarta.apache.org/struts/@);
    unlike($out, qr/<frameworks>/);
}

sub guess_filename {
    my($self, $file) = @_;
    return $file;
}

package main;

my $page = Test::Pages->new;
$page->load_stylesheet('./t/test.xsl')


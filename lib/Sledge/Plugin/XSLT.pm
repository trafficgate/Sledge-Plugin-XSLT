package Sledge::Plugin::XSLT;

use strict;
use XML::LibXML;
use XML::LibXSLT;
use vars qw($VERSION);
$VERSION = '0.01';

sub import {
    my($class, %opt) = @_;
    my $pkg = caller;
    no strict 'refs';
    *{"$pkg\::stylesheet"} = sub {
	my($self, $stylesheet) = @_;
	$self->{__stylesheet} = $stylesheet if $stylesheet;
	return $self->{__stylesheet};
    };
    *{"$pkg\::load_stylesheet"} = sub {
	my($self, $xslt) = @_;
	$self->stylesheet($self->guess_filename($xslt));
	$self->add_filter(\&_xslt_filter);
    };
}

sub _xslt_filter {
    my($page, $content) = @_;
    return $content unless $page->stylesheet;
    my $parser = XML::LibXML->new;
    my $xslt = XML::LibXSLT->new;
    my $source = $parser->parse_string($content);
    my $style_doc = $parser->parse_file($page->stylesheet);
    my $ss = $xslt->parse_stylesheet($style_doc);
    my $result = $ss->transform($source);
    return $ss->output_string($result);
}

1;
__END__

=head1 NAME

Sledge::Plugin::XSLT - XSLT plugin for Sledge.

=head1 SYNOPSIS

  package My::Pages;
  use Sledge::Plugin::XSLT;
  use base qw(Sledge::Pages::Compat);

  sub dispatch_foo {
      $self->load_stylesheet('foo.xml');
  }

=head1 DESCRIPTION

This plugin intercepts XML(XHTML) output and return the transformed document.

=head1 AUTHOR

IKEBE Tomohiro E<lt>ikebe@edge.co.jpE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Sledge>

=cut

package CGI::Application::Dispatch::BuildURI;

use strict;
use warnings;

use CGI::Application::Plugin::Redirect;

require Exporter;

our @EXPORT = qw(
	build_uri
	move_uri
);

our $VERSION = '0.02';

sub import { goto &Exporter::import }

sub build_uri
{
	my $self = shift;
	my %args = @_;

	my $location = $self->query->url;

	my $module = $args{'module'} || $self->param('CGIAPP_DISPATCH_PATH');
	my $rm = $args{'rm'} || $self->get_current_runmode;
	my $query_string = $args{'query_string'} || $ENV{'QUERY_STRING'};

	# module name must be lower characters
	$location .= '/' . lc($module) . '/' . $rm;
	$location .= '?' . $query_string if $query_string;
	return $location;
}

sub move_uri
{
	my $self = shift;

	return if $self->query->path_info =~ m{^/.+/.+$};

	my $location = $self->build_uri();
	CGI::Application::Plugin::Redirect::redirect($self, $location);
}

1;

__END__

    
=head1 NAME

CGI::Application::Dispatch::BuildURI - Build URI including full path_info in CGI::Application::Dispatch

    
=head1 SYNOPSIS

  # in your CGI::Application module
  use CGI::Application::Dispatch::BuildURI;
  sub some_rm
  {
      my $self = shift;
      my $location = $self->build_uri(
          module => 'some_module',
          rm => 'some_rm',
          query_string => 'key=value',
      );
      # $location is http://www.example.com/example.cgi/some_module/some_rm?key=value
  }
  
  sub cgiapp_prerun
  {
      my $self = shift;
      $self->move_uri();
  }  


=head1 DESCRIPTION

This module provides a easier way to treat relative path in template files when using CGI::Application::Dispatch.

When we use CGI::Application::Dispatch, we get follow URIs and URIs return same page.

    1. http://www.example.com/example.cgi
    2. http://www.example.com/example.cgi/some_module
    3. http://www.example.com/example.cgi/some_module/some_rm

If we write relative path in template files, we are confused to treat relative path.
For example, this link is work on URI 1 but don't work on URI 2 and 3.

    <a href="./example.cgi/another_module/another_rm">another page</a>

This module provides build_uri() method. This method is create URI that including full path_info, like URI 3.


=head1 METHODS

    
=head2 build_uri

build_uri() method receive three arguments and generate URI that including full path_info.
Three arguments are 'module', 'rm', 'query_string'.
'module' is your package name. 'module' is used lower characters all of the time. 'rm' is your run_mode. 'query_string' is $ENV{QUERY_STRING}.
If these arguments does not set, build_uri() automatically fill empty argument by default setting value.

=head2 move_uri

move_uri() method work two things, generate URI by build_uri and redirect to that URI.
Redirection is provided by L<CGI::Application::Plugin::Redirect>.
move_uri() is for laziness. This is useful in cgiapp_prerun() method.

    cgiapp_prerun {
      my $self = shift;
      $self->move_uri();
    }

You get full-path_info-including URI anytime. If you use this method in your cgiapp's base class, you only call move_uri one time on your base class's cgiapp_prerun() method.

    
=head1 SEE ALSO

L<CGI::Application>, L<CGI::Application::Dispatch>, L<CGI::Application::Plugin::Redirect>

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

    
=head1 AUTHOR

Kensuke Kaneko <kyanny@gmail.com>

    
=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by Kensuke Kaneko. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.


=cut

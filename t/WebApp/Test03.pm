package WebApp::Test03;
use strict;
use warnings;
use vars qw(@ISA);

use CGI::Application;
use CGI::Application::Dispatch::BuildURI;

@ISA = ('CGI::Application');

sub setup
{
	my $self = shift;
	$self->start_mode('test_mode');
	$self->run_modes(test_mode => 'test_mode');
}

sub test_mode
{
	my $self = shift;
	$self->move_uri();
}

1;

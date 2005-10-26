package WebApp::Test02;
use strict;
use warnings;
use vars qw(@ISA);

use CGI::Application;
use CGI::Application::Dispatch::BuildURI;

@ISA = ('CGI::Application');

sub setup
{
	my $self = shift;
	$self->header_type('none');
	$self->start_mode('test_mode');
	$self->run_modes(test_mode => 'test_mode');
}

sub test_mode
{
	my $self = shift;
	my $location = $self->build_uri(
		module => 'Test02',
		rm => 'test_mode',
		query_string => 'key=value',
	);
	return $location;
}

1;

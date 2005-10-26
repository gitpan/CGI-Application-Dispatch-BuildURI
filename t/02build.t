#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 1;
use blib;
use lib qw(t/);
use CGI::Application::Dispatch;

$ENV{CGI_APP_RETURN_ONLY} = 1;
$ENV{HTTP_HOST} = 'www.example.com';
$ENV{REQUEST_URI} = '/example.cgi';

my $output = CGI::Application::Dispatch->dispatch(
	PREFIX => 'WebApp',
	DEFAULT => 'Test02',
);

is($output, 'http://www.example.com/example.cgi/test02/test_mode?key=value', 'Build URI ok');

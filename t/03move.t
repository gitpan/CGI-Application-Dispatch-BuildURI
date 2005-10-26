#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 3;
use blib;
use lib qw(t/);
use CGI::Application::Dispatch;

$ENV{CGI_APP_RETURN_ONLY} = 1;
$ENV{HTTP_HOST} = 'www.example.com';
$ENV{REQUEST_URI} = '/example.cgi';

my $output = CGI::Application::Dispatch->dispatch(
	PREFIX => 'WebApp',
	DEFAULT => 'Test03',
);

# move_uri() require CGI::Application::Redirect module and redirect() method
BEGIN{use_ok('CGI::Application::Plugin::Redirect')}
like($output, qr/.*Status:\s*302\s*Moved\s*/, 'Moved ok');
like($output, qr/.*Location:\s*http:\/\/www\.example\.com\/example\.cgi\/test03\/test_mode.*/, 'Location ok');

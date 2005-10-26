#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 2;
use blib;
BEGIN { use_ok('CGI::Application::Dispatch::BuildURI') };
can_ok('CGI::Application::Dispatch::BuildURI', qw(build_uri move_uri));

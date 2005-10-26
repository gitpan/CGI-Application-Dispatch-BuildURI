use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'CGI::Application::Dispatch::BuildURI',
    VERSION_FROM      => 'lib/CGI/Application/Dispatch/BuildURI.pm', # finds $VERSION
    PREREQ_PM         => {
		'CGI::Application::Plugin::Redirect' => 0,
	}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/CGI/Application/Dispatch/BuildURI.pm', # retrieve abstract from module
       AUTHOR         => 'Kensuke Kaneko <kyanny@gmail.com)>') : ()),
);

use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Sledge::Plugin::XSLT',
    'VERSION_FROM' => 'lib/Sledge/Plugin/XSLT.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
	XML::LibXML => 1.53,
	XML::LibXSLT => 1.52
    },
);

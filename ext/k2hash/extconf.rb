require 'mkmf'
$libs += "-lk2hash";
$libs = append_library($libs, 'k2hash');
create_makefile('k2hash/k2hash')

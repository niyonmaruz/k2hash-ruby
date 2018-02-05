require 'mkmf'
if have_header('k2hash/k2hash.h')
else
  abort "-----\nk2hash/k2hash.h is missing. Check your installation of k2hash.\n-----"
end
$libs += "-lk2hash";
$libs = append_library($libs, 'k2hash');
create_makefile('k2hash/k2hash')

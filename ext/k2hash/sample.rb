#!/usr/bin/env ruby

require "./k2hash"

puts "start"
k2h_tsdb_handle = K2hash::k2h_open_rw("/tmp/sample.k2h", true, 8, 4, 1024, 512)
key = "testkey"
val = "testval"
K2hash::k2h_set_str_value(k2h_tsdb_handle, key, val)
K2hash::k2h_close(k2h_tsdb_handle);
puts 'end'

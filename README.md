# K2hash

## Installation

1. Install prerequisites before compiling

- Debian / Ubuntu
```
$ sudo aptitude update
$ sudo aptitude install git autoconf autotools-dev gcc g++ make gdb dh-make fakeroot dpkg-dev devscripts libtool pkg-config libssl-dev
```

- Fedora / CentOS
```
$ sudo yum install git autoconf automake gcc libstdc++-devel gcc-c++ make libtool openssl-devel
```

2. Clone source codes from Github

```
$ git clone git@github.com:yahoojapan/k2hash.git
$ cd k2hash
$ git clone --recursive git://github.com/yahoojapan/fullock
$ git submodule update --init --recursive
```

3. Building and installing FULLOCK

There may be confusion between /usr/lib and /usr/lib64 directories, which could cause compiling errors.
Should this situation occur, define the appropriate installation paths with the --libdir=/usr/lib or --libdir=/usr/lib64.

```
$ cd fullock
$ ./autogen.sh
$ ./configure --prefix=/usr
$ make
$ sudo make install
```

4. Building and installing K2HASH

```
$ ./autogen.sh
$ ./configure --prefix=/usr
$ make
$ sudo make install
```

5. Installing k2hash gem package

Add this line to your application's Gemfile:

```
gem 'k2hash'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install k2hash
```

## Usage

```ruby
#! /usr/bin/env ruby

require "k2hash"

file = "/tmp/example.k2h"

K2hash.open(file, "w") do |db|
  db.set_str_value("mykey", "myval")
end

K2hash.open(file, "r") do |db|
  value = db.get_str_direct_value("mykey")
  p value
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

```
$ C_INCLUDE_PATH=/path/to/header_files
$ export C_INCLUDE_PATH
$ LD_LIBRARY_PATH=/path/to/libraries
$ export LD_LIBRARY_PATH
$ LIBRARY_PATH=/path/to/libraries
$ export LIBRARY_PATH
$ cd ext/k2hash/
$ swig -ruby k2hash.i
$ ruby extconf.rb
$ make
$ ruby sample.rb
$ cd ..
$ bundle install --path vendor/bundle
$ bundle exec rspec
$ bundle exec rake build
$ sudo C_INCLUDE_PATH=/path/to/header_files LD_LIBRARY_PATH=/path/to/libraries LIBRARY_PATH=/path/to/libraries gem install pkg/k2hash-0.1.0.gem
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/k2hash. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the K2hash project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/k2hash/blob/master/CODE_OF_CONDUCT.md).

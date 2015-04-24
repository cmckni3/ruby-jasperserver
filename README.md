# JasperserverRails
[![Gem Version](https://badge.fury.io/rb/jasperserver-rails.png)](http://badge.fury.io/rb/jasperserver-rails)
[![Build Status](https://travis-ci.org/cmckni3/rails-jasperserver.svg?branch=master)](https://travis-ci.org/cmckni3/rails-jasperserver)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/cmckni3/jasperserver-rails)

Download reports in various formats from jasperserver

Formats supported:

  * HTML
  * PDF
  * XLS
  * RTF
  * CSV
  * XML
  * jrprint

## Installation

### Install the gem

Add this line to your application's Gemfile:

    gem 'jasperserver-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jasperserver-rails

### Install the generator

  * Install the initializer and config file

        $ rails g jasperserver_rails:install

* Edit `config/jasperserver.yml`

## Usage

1. Add jasperserver configuration to config/jasperserver.yml

````
development:
  url: 'http://server:port/jasperserver/'
  username: 'username'
  password: 'password'

test:
  url: 'http://server:port/jasperserver/'
  username: 'username'
  password: 'password'

production:
  url: 'http://server:port/jasperserver/'
  username: 'username'
  password: 'password'
````

2. Run a report using the DSL

````ruby
JasperserverRails::Jasperserver.new.run_report 'test.pdf' do
  format 'pdf'
  report 'test_report'
  params({ :Value1 => 'Value1' })
end
````

## TODO

1. Documentation
2. Background processing
3. Add more tests

## Copyright and License

JasperserverRails &copy; 2013 by [Chris McKnight](http://github.com/cmckni3).

JasperserverRails is licensed under the MIT license. Please see the MIT-LICENSE document for more information.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

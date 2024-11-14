# JasperserverRails

[![Gem Version](https://img.shields.io/gem/v/jasperserver-rails.svg)](https://rubygems.org/gems/jasperserver-rails)
[![CI](https://img.shields.io/github/actions/workflow/status/cmckni3/ruby-jasperserver/ci.yml)](https://github.com/cmckni3/ruby-jasperserver/actions/workflows/ci.yml)
[![Code Climate](https://api.codeclimate.com/v1/badges/9dfe8fd29537fc32faeb/maintainability)](https://codeclimate.com/github/cmckni3/ruby-jasperserver/maintainability)
[![License](https://img.shields.io/github/license/cmckni3/ruby-jasperserver.svg)](https://github.com/cmckni3/ruby-jasperserver/blob/master/MIT-LICENSE)

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

```yaml
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
```

2. Run a report

```ruby
pdf = JasperserverRails::Jasperserver.new.generate_report do
        format 'pdf'
        report '/reports/TestReport'
        params(Value1: 'Value1')
      end
send_data pdf, filename: 'Test.pdf', type: :pdf
```

3. Download a report using the DSL

```ruby
file_path = Rails.root.join('tmp', 'reports', 'test.pdf')
JasperserverRails::Jasperserver.new.run_report file_path do
  format 'pdf'
  report '/reports/TestReport'
  params(Value1: 'Value1')
end
```

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

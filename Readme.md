# Trooly Ruby SDK

[![Code Climate](https://codeclimate.com/github/ac21/trooly-ruby-sdk/badges/gpa.svg)](https://codeclimate.com/github/ac21/trooly-ruby-sdk)
[![Test Coverage](https://codeclimate.com/github/ac21/trooly-ruby-sdk/badges/coverage.svg)](https://codeclimate.com/github/ac21/trooly-ruby-sdk/coverage)
[![Build Status](https://travis-ci.org/ac21/trooly-ruby-sdk.svg?branch=master)](https://travis-ci.org/ac21/trooly-ruby-sdk)

A basic ruby client to access the Trooly service

## Installation

Add this line to your  Gemfile:

```ruby
gem 'trooly-ruby-sdk', git: 'https://github.com/ac21/trooly-ruby-sdk'
```

And then execute:

    $ bundle install

## Usage

### Authentication / Basic Usage
```ruby
require "trooly"

Trooly.configure do |config|
  config.clientid = 'clientid'
  config.api_key = 'api_key'
end

client = Trooly.client


client.verify
=> true # if clientid and api_key are valid
```

### Submit a user for screening

```ruby
client.user.submit(
  :user => {
    :userid => 'troolytest01',
    :names => ['John Smith'],
    :emails => ['jsmith@example.org', 'john@example.org'],
    :phones => ['888-555-1212'],
    :dobs => ['1972-01-01'],
    :ip_addresses => ['1.1.1.1'],
    :facebook_tokens => ['token'],
    :addresses => [
      {
        :street => '123 N Main St',
        :city => 'Palo Alto',
        :state => 'CA',
        :zipcode => '98000',
        :country =< 'US'
      }
    ],
    :address_strings => ['123 N Main St, Palo Alto, CA 98000']
  },
  :callback => nil,
  :callback_token => nil,
)
# => true
```

### Retrieve a submitted user

```ruby
client.user.find(userid)
# => <Struct User...>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ac21/trooly-ruby-sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


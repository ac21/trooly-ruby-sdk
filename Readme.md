# Trooly Ruby SDK

[![Code Climate](https://codeclimate.com/github/ac21/basic-ruby-sdk/badges/gpa.svg)](https://codeclimate.com/github/ac21/basic-ruby-sdk)
[![Test Coverage](https://codeclimate.com/github/ac21/basic-ruby-sdk/badges/coverage.svg)](https://codeclimate.com/github/ac21/basic-ruby-sdk/coverage)

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
require "trooly/client"

client = Trooly::Client.new("clientid", "api_key")


client.verify
=> true # if clientid and api_key are valid
```

### Submit a user for screening

```ruby
user_submission = Trooly::Client::Entity::UserSubmission.new(
  :userid => 'troolytest01',
  :names => ['John Smith'],
  :emails => ['jsmith@example.org', 'john@example.org']
)

client.user.submit user_submission

# => true

### Retrieve a screened user

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

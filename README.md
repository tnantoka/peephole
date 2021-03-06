# Peephole

[![Gem Version](https://badge.fury.io/rb/peephole.svg)](http://badge.fury.io/rb/peephole)
[![Circle CI](https://circleci.com/gh/tnantoka/peephole.svg?style=svg)](https://circleci.com/gh/tnantoka/peephole)
[![Code Climate](https://codeclimate.com/github/tnantoka/peephole/badges/gpa.svg)](https://codeclimate.com/github/tnantoka/peephole)
[![Test Coverage](https://codeclimate.com/github/tnantoka/peephole/badges/coverage.svg)](https://codeclimate.com/github/tnantoka/peephole/coverage)

A log viewer engine for Rails.

![](screenshot.png)

## Requirement

- Ruby 2.2
- Rails 4.2
- `Rails.application.config.log_tags = [:uuid]`

## Installation

```
# Gemfile
gem 'peephole'

$ bundle

$ rails g peephole:install
       route  mount Peephole::Engine => "/peephole"
      create  config/initializers/log_tags.rb
      create  config/initializers/peephole.rb
```

## Configuration

```
# config/initializers/peephole.rb
Peephole.configure do |config|
  config.lines_per = 200
  config.bytes_per = 5000
  config.peeper? do
    # !Rails.env.production?

    # current_user.role.admin?

    # admin_user_signed_in?

    # authenticate_or_request_with_http_basic do |user, pass|
    #   user == ENV['PEEPHOLE_USER'] && pass == ENV['PEEPHOLE_PASS']
    # end
  end
end
```

## Example

```
$ git clone git@github.com:tnantoka/peephole.git
$ cd peephole/spec/dummy
$ rails s
$ open http://localhost:3000/peephole
```

## License

MIT

## Author

[@tnantoka](https://twitter.com/tnantoka)


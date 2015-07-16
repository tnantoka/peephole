# Peephole

A log viewer engine for Rails.


## Installation

```
# Gemfile
gem 'peephole'

$ bundle

$ rails g peephole:install
      create  config/initializers/log_tags.rb
      create  config/initializers/peephole.rb
```

## Configuration

```
# config/initializers/peephole.rb
Peephole.configure do |config|
  config.paginates_per = 200
  config.peeper? do
    # current_user.role.admin?
    # admin_user_signed_in?
    # basic auth
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

[@tnantoka][https://twitter.com/tnantoka]


# Gitignore

This gem is used to copy the corresponding gitignore file from the github/gitignore repo to your current working directory.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git_ignore'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git_ignore

## Usage

#### list all sorts of gitignore files from `github/gitignore` repo
```
git_ignore list
```

#### copy corresponding gitignore file to your current working directory
```
git_ignore objc # copy Objective-C.gitignore to $(pwd)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gitignore. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# Gitegnore

This gem is used to copy the corresponding gitignore file from the **github/gitignore** repo to your current working directory.

## Installation

install it yourself as:

    $ gem install gitegnore

## Usage

#### list all sorts of gitignore files from `github/gitignore` repo

**NOTE**: currently gitignore files in Global sub-directory are not supported
```
gitegnore list
```

#### copy corresponding gitignore file to your current working directory
```
gitegnore fetch Ojective-C # copy Objective-C.gitignore to $(pwd)
```

#### more
```
gitegnore help
```

## TODO 
- [ ] gitignore file alias
- [ ] test case

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gitignore. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

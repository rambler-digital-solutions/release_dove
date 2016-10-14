# Release Dove
[![Build Status](https://travis-ci.org/gafrom/release_dove.svg)](https://travis-ci.org/gafrom/release_dove)

Dead-simple widget allowing you to receive notifications about new releases of your application in a form of nice pop-up bar.

## Installation

Add this line to your application's `Gemfile`:
```ruby
gem 'release_dove'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install release_dove

Then drop a line to `routes.rb` to specify where you want your colleciton of releases:
```ruby
mount ReleaseDove::Application => '/releases'
```

Finally, include the front-end part:
```javascript
TODO: include npm package 'release_dove'
```

## Usage

When running without from-end part, _https://you_app.com/releases_ will return a collection of releases in `JSON` format from your `CHANGELOG.md` file, providing the latter is maintained in a [conventional way](http://keepachangelog.com/en/0.3.0/).

## Release attributes

Releases have the following attributes:

| Attribute   | Description                             | Example                                                   |
|-----------  |---------------------------------------- |---------------------------------------------------------  |
| `id`        | number, starting from earliest release  | 5                                                         |
| `version`   | version of release, if specified        | 1.2.3                                                     |
| `date`      | release date                            | 2016-10-15                                                |
| `header`    | content of release header tag           | [1.2.3] - 2016-10-15                                      |
| `content`   | full content of release                 | ## [1.2.3] - 2016-10-15 ### Added - Basic functionality   |

TODO: Write usage instructions here with npm package included

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gafrom/release_dove.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


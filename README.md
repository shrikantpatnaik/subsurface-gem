# Subsurface
Simple Gem to read Subsurface dive logs file

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'subsurface'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install subsurface

## Usage

`dives = Subsurface::Reader.read(file)`

where file is an instance of `Nokogiri::XML`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shrikantpatnaik/subsurface. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Subsurface project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/subsurface/blob/master/CODE_OF_CONDUCT.md).

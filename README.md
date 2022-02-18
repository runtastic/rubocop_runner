# RubocopRunner

[![Gem Version](https://badge.fury.io/rb/rubocop_runner.svg)][rubygems]

This gem provides you with a rake task to install rubocop as a git pre-commit hook.
If rubocop finds any issues it will abort the commit. It will try to auto-correct
all issues in the files that are being commited, but will abort the commit even
if all issues can be auto-corrected so that you can verify the changes before
actually commiting them.

_Although this gem has no tests it's battle tested and is in use at runtastic
since years._

## Installation

Add these lines to your application's Gemfile:

```ruby
gem 'rubocop_runner', '~> 2.1', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubocop_runner

## Usage

To create a rubocop runner pre-commit hook once just run

```sh
ruby -rubocop_runner -e "RubocopRunner.install"
```

To make it easy for every developer on the project you can also add this to your
`Rakefile`:

```ruby
require 'rubocop_runner/rake_task'
RubocopRunner::RakeTask.new
```

Afterwards, just run the `rake rubocop:install` task to install the pre-commit
hook.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/runtastic/rubocop_runner.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [code of conduct][cc].

Check out our [career page](https://www.runtastic.com/career/) if you'd like to work with us.

## License

The gem is available as open source under [the terms of the MIT License][mit].

[rubygems]: https://rubygems.org/gems/rubocop_runner
[mit]: https://choosealicense.com/licenses/mit/
[cc]: ../CODE_OF_CONDUCT.md

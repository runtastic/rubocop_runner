# RubocopRunner

This gem provides means of running rubocop including auto-correct on all files which are currently staged
in git. This can be easily used as pre-commit hook with the included template.

If rubocop can fix all detected issues itself via autocorrect it will add all new changes
(to files already staged) automatically to the new commit. Otherwise it will let the commit fail.

_Although this gem has no tests it's pretty battle tested and is in use internally since years._

## Installation

Add these lines to your application's Gemfile:

```ruby
group :development do
  gem 'rubocop_runner', '~> 2.0', require: false
end
```

And then execute:

    $ bundle

## Usage

Here is how to easily run rubocop through a pre-commit hook:

Create a rake task (or Copy the included pre-commit hook in the correct folder (.git/hooks/) ).

``` ruby
begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  namespace :rubocop do
    desc 'Install Rubocop as pre-commit hook'
    task :install do
      require 'rubocop_runner'
      RubocopRunner.install
    end
  end
rescue LoadError
  p 'rubocop not installed'
end
```

## ToDo

- add the install rake task itself to the gem
- add tests
- improve gem structure

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/runtastic/rubocop_runner.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


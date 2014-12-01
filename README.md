# RubocopRunner

collection of helper methods to easily run rubocop as pre-commit hook

## Installation

Add these lines to your application's Gemfile:

```ruby
gem 'rubocop_runner'
gem 'rubocop', '0.27.1'
```

(I suggest you pin the version of rubocop to something you tested)

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubocop_runner

## Usage

Copy the included pre-commit hook in the correct folder (.git/hooks/) or use a
rake task similar to this one to setup your project.

``` ruby
require 'bundler/setup'

desc "initialize project"
task :init do
  require 'rubocop_runner'
  RubocopRunner.install
end
```

You can use `lib/template/rubocop.yml` as inital rubocop config by copying it
as `.rubocop.yml` into your project.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

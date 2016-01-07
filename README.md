# RubocopRunner

## Installation

Add these lines to your application's Gemfile:

```ruby

group :development do
  gem 'rubocop-defaults', require: false
  gem 'rubocop_runner', '~> 1.3', require: false
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

Create `.rubocop.yml` in the root folder of your project and add these lines

```ruby
require:
  - rubocop-defaults
```

## Hint
If you want to commit files and skip the rubocopy hook, use the n flag:
`commit -n'

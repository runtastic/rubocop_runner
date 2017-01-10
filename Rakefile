require 'bundler/gem_tasks'

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

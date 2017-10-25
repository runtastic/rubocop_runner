# frozen_string_literal: true

require 'rake'
require 'rake/tasklib'

module RubocopRunner
  # Provides a custom rake task.
  #
  # require "rubocop_runner/rake_task"
  # RubocopRunner::RakeTask.new
  class RakeTask < Rake::TaskLib
    def initialize(name = 'rubocop:install')
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new

      desc 'Install Rubocop as pre-commit hook'
      task(name) do
        require 'rubocop_runner'
        RubocopRunner.install
      end
    rescue LoadError
      warn 'rubocop_runner install task disabled due to rubocop not being '\
           'installed'
    end
  end
end

# frozen_string_literal: true

require 'rubocop_runner/version'
require 'rubocop'

module RubocopRunner
  module_function

  # from https://github.com/djberg96/ptools/blob/master/lib/ptools.rb#L90
  def binary?(file)
    return true if File.ftype(file) != 'file'

    s = (File.read(file, File.stat(file).blksize) || '').split(//)
    ((s.size - s.grep(' '..'~').size) / s.size.to_f) > 0.30
  end

  def staged_files
    files = `git diff --cached --name-only --diff-filter=ACM`.split
    files.reject do |f|
      if File.ftype(f) != 'file'
        true
      else
        size = File.size(f)
        size > 1_000_000 || (size > 20 && binary?(f))
      end
    end
  end

  def merge?
    File.exist?('.git/MERGE_MSG') && File.exist?('.git/MERGE_HEAD')
  end

  def conflict_files
    IO.read('.git/MERGE_MSG')
      .each_line
      .select { |e| e.start_with?("\t") }
      .map(&:strip)
  end

  def files
    if merge?
      conflict_files
    else
      staged_files
    end
  end

  RUBY_PATTERN = /\.(rb|gemspec|rake)$/.freeze
  RUBY_NAMES = %w[Guardfile Gemfile Rakefile config.ru].freeze

  def ruby_file?(filename)
    RUBY_NAMES.include?(filename) || !(filename =~ RUBY_PATTERN).nil?
  end

  def staged_ruby_files
    @ruby_files ||= files.select do |file|
      !File.directory?(file) && File.exist?(file) && ruby_file?(file)
    end
  end

  DEFAULT_ARGS = %w[--autocorrect
                    --format fuubar
                    --force-exclusion
                    --fail-level autocorrect].freeze
  def run
    return 0 if staged_ruby_files.empty?

    ::RuboCop::CLI.new.run(DEFAULT_ARGS + staged_ruby_files)
  end

  RUBOCOP_RUNNER_HOME =
    Pathname.new(File.join(File.dirname(__FILE__), '..')).realpath

  def root
    RUBOCOP_RUNNER_HOME
  end

  def create_backup(pre_commit_path)
    return unless File.exist?(pre_commit_path)

    FileUtils.mv(pre_commit_path,
                 pre_commit_path.join('.bkp'),
                 force: true)
  end

  def install(root = '.')
    require 'fileutils'
    git_root = Pathname.new "#{root}/.git"
    return false unless File.exist?(git_root)

    pre_commit_path = git_root.join('hooks', 'pre-commit')
    create_backup(pre_commit_path)

    pre_commit_template_path = RubocopRunner.root.join('lib',
                                                       'template',
                                                       'pre-commit')
    FileUtils.cp(pre_commit_template_path, pre_commit_path)
    FileUtils.chmod('+x', pre_commit_path)
    puts 'RubocopRunner installed!'
  end
end

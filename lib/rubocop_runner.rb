require 'rubocop_runner/version'
require 'rubocop'

module RubocopRunner
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

  RUBY_PATTERN = /\.(rb|gemspec)$/
  RUBY_NAMES = %w(Guardfile Gemfile Rakefile config.ru)

  def ruby_file?(filename)
    RUBY_NAMES.include?(filename) || !!(filename =~ RUBY_PATTERN)
  end

  def staged_ruby_files
    @ruby_files ||= staged_files
                    .reject { |e| File.directory?(e) }
                    .select { |e| ruby_file?(e) }
  end

  DEFAULT_ARGS = %w(--auto-correct --format fuubar)
  def run
    return 0 if staged_ruby_files.empty?
    ::RuboCop::CLI.new.run(DEFAULT_ARGS + staged_ruby_files)
  end
  module_function :run
end

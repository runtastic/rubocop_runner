require "rubocop_runner/version"
require "rubocop"

module RubocopRunner
  # from https://github.com/djberg96/ptools/blob/master/lib/ptools.rb#L90
  def binary?(file)
    return true if File.ftype(file) != 'file'
    s = (File.read(file, File.stat(file).blksize) || '').split(//)
    ((s.size - s.grep(' '..'~').size) / s.size.to_f) > 0.30
  end

  def staged_files
    @staged_files ||= begin
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
  end

  def staged_ruby_files
    staged_files
      .reject{ |e| File.directory?(e)}
      .select{ |e| RUBY_NAMES.include?(e) || !!(e =~ RUBY_PATTERN) }
      .uniq
  end

  RUBY_PATTERN = /\.(rb|gemspec)$/
  RUBY_NAMES = %w(Guardfile Gemfile Rakefile config.ru)
  DEFAULT_ARGS = %w(--auto-correct --format fuubar)

  def run
    ::RuboCop::CLI.new.run(DEFAULT_ARGS + staged_ruby_files) 
  end
end

# frozen_string_literal: true

require 'rubocop_runner/version'
require 'rubocop'

module RubocopRunner
  module_function

  def create_backup(pre_commit_path)
    return unless File.exist?(pre_commit_path)

    FileUtils.mv(pre_commit_path,
                 "#{pre_commit_path}.bak",
                 force: true)
  end
  
  def root
    Pathname.new(File.join(File.dirname(__FILE__), '..')).realpath
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

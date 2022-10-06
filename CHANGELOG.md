# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.3.0] - 2022-10-06
### Changed
- Installed pre-commit hook does not need to load whole bundle anymore, which makes it faster to load
- Pre-commit hook does not unexpectedly change your Gemfile.lock if you commit using another ruby platform on your shell then the one that was used to build the Gemfile.lock

## [2.2.0] - ???
### Changed
- also inspect `.rake` files
- readme format changes

## [2.1.0] - ???
### Changed
- package rake task within gem [#2](https://github.com/runtastic/rubocop_runner/pull/2)

## [2.0.1] - ???
### Changed
- initial open source release

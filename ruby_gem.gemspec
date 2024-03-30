# frozen_string_literal: true

require_relative "lib/file_type_detector/version"

Gem::Specification.new do |spec|
  spec.name = "file_type_detector_sfedu"
  spec.version = FileTypeDetector::VERSION
  spec.authors = ["Garik", "watermelon0guy", "synthematikj", "kamchatnaya"]
  spec.email = ["garfild_2003@mail.ru"]

  spec.summary = "A gem for detecting file types based on their extensions or content."
  spec.description = "FileTypeDetector is a Ruby gem that provides functionality for determining the type of a file based on its extension or content."
  spec.homepage = "https://github.com/synthematik/file_type_detector_gem"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/synthematik/file_type_detector_gem"
  spec.metadata["changelog_uri"] = "https://github.com/synthematik/file_type_detector_gem/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

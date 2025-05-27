# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name     = "power-emitter"
  s.version  = "0.0.1"
  s.authors  = ["Max Power"]
  s.email    = ["kevin.melchert@gmail.com"]
  s.summary  = "TODO: Write a short summary, because RubyGems requires one."
  s.homepage = "TODO: Put your gem's website or public repo URL here."
  s.license  = "MIT"
  s.required_ruby_version = ">= 3.4.0"
  s.require_paths = ["lib"]
#  s.files = 
  
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  s.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
end

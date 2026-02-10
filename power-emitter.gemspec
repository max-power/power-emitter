# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name     = "power-emitter"
  s.version  = "0.0.2"
  s.authors  = ["Max Power"]
  s.email    = ["kevin.melchert@gmail.com"]
  s.summary  = "A lightweight Ruby event emitter that allows you to bind, emit, and stop custom events using blocks."
  s.homepage = "https://github.com/max-power/power-emitter/"
  s.license  = "MIT"

  s.required_ruby_version = ">= 3.4.0"
  s.require_paths = ["lib"]


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  s.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.end_with?(".gem") ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
end

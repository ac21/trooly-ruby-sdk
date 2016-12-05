# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trooly/version'

Gem::Specification.new do |spec|
  spec.name          = "trooly-ruby-sdk"
  spec.version       = Trooly::VERSION
  spec.authors       = ["Andrew Conrad"]
  spec.email         = ["aconrad@sittercity.com"]

  spec.summary       = %q{Access Trooly API via ruby}
  spec.description   = %q{Access Trooly API via a nifty ruby client}
  spec.homepage      = "https://github.com/ac21/trooly-ruby-sdk"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.10.0"
  spec.add_dependency "json", ">= 1.8.3"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.6.0"
end

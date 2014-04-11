# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ebisu_connection/version'

Gem::Specification.new do |spec|
  spec.name          = "ebisu_connection"
  spec.version       = EbisuConnection::VERSION
  spec.authors       = ["tsukasaoishi"]
  spec.email         = ["tsukasa.oishi@gmail.com"]
  spec.description   = %q{EbisuConnection supports to connect with Mysql slave servers. It doesn't need Load Balancer.}
  spec.summary       = %q{EbisuConnection supports to connect with Mysql slave servers.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'fresh_connection', '~> 0.2.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", '>= 10.0.0'
  spec.add_development_dependency "rspec", '>= 2.14.1'
  spec.add_development_dependency 'mysql2', '>= 0.3.15'
  spec.add_development_dependency 'appraisal', '>= 1.0.0'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ebisu_connection/version'

Gem::Specification.new do |spec|
  spec.name          = "ebisu_connection"
  spec.version       = EbisuConnection::VERSION
  spec.authors       = ["tsukasaoishi"]
  spec.email         = ["tsukasa.oishi@gmail.com"]

  spec.summary       = %q{EbisuConnection supports to connect with Mysql slave servers.}
  spec.description   = %q{EbisuConnection supports to connect with Mysql slave servers. It doesn't need Load Balancer.}
  spec.homepage      = "https://github.com/tsukasaoishi/ebisu_connection"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0'
  spec.add_dependency 'fresh_connection', '~> 0.4.0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", '~> 10.0'
  spec.add_development_dependency "rspec", '~> 3.0'
  spec.add_development_dependency 'appraisal', '~> 2.0'
end

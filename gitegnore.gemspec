# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitegnore/version'

Gem::Specification.new do |spec|
  spec.name          = "gitegnore"
  spec.version       = Gitegnore::VERSION
  spec.authors       = ["0oneo"]
  spec.email         = ["neoman.v@gmail.com"]

  spec.summary       = %q{fetch gitgnore file from the github/gitignore repo}
  spec.description   = <<-EOM
      first it will pull lastest update from github/gitignore repo, then copy.
      then copy corresponding .gitignore file to current diretory
  EOM
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "thor", "~> 0.19.4"
  spec.add_runtime_dependency 'json', '~> 1.8', '>= 1.8.3'
end

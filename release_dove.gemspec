# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'release_dove/version'

Gem::Specification.new do |spec|
  spec.name          = 'release_dove'
  spec.version       = ReleaseDove::VERSION
  spec.authors       = ['Oleg']
  spec.email         = ['gafrom@gmail.com']

  spec.summary       = 'Simple widget to notify about new releases of your applicaiton.'
  spec.description   = "This is a backend part of easy-to-embed widget with pop-up \
                        notifications about your application's new releases."
  spec.homepage      = 'https://github.com/gafrom/release_dove'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = 'https://mygemserver.com'
  # else
  #   raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  # end

  spec.files         = `git ls-files -z`.split("\x0")
                                        .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'json', '~> 2.0.2'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.44'
end

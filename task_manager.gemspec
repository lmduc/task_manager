# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'task_manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'task_manager2'
  spec.version       = TaskManager::VERSION
  spec.authors       = ['Duc Le']
  spec.email         = ['leminhducktvn@gmail.com']

  spec.summary       = %q{A simple task manager in console}
  spec.description   = %q{A simple task manager in console, stored using XML}
  spec.homepage      = "https://github.com/lmduc/task_manager"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['task']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_dependency             'nokogiri', '~> 1.6'
  spec.add_dependency             'colorize', '~> 0.7.7'
  spec.add_dependency             'thor', '~> 0.19.1'
end

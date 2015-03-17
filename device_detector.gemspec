# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'device_detector/version'

Gem::Specification.new do |spec|
  spec.name          = 'device_detector'
  spec.version       = DeviceDetector::VERSION
  spec.authors       = ['Mati Sójka', 'Ben Zimmer']
  spec.email         = ['yagooar@gmail.com']
  spec.summary       = %q{Precise and fast user agent parser and device detector}
  spec.description   = %q{Precise and fast user agent parser and device detector, backed by the largest and most up-to-date agent and device database}
  spec.homepage      = 'https://github.com/podigee/device_detector'
  spec.license       = 'LGPLv3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec' ,'~> 3.1', '>= 3.1.0'
  spec.add_development_dependency 'pry', '~> 0.10'
end

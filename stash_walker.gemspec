# Copyright 2016 PayByPhone Technologies, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stash_walker/version'

Gem::Specification.new do |spec|
  spec.name = 'stash_walker'
  spec.version = StashWalker::VERSION
  spec.authors = ['Chris Marchesi']
  spec.email = %w(cmarchesi@paybyphone.com)
  spec.description = 'Gather projects from a BitBucket server'
  spec.summary = spec.description
  spec.homepage = 'https://github.com/paybyphone/stash_walker'
  spec.license = 'Apache 2.0'

  spec.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.bindir = 'exe'
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.required_ruby_version = ['>= 2.1']

  spec.add_dependency 'highline', '~> 1.7.8'
  spec.add_dependency 'trollop', '~> 2.1'
  spec.add_dependency 'httparty', '~> 0.13.7'

  spec.add_development_dependency 'rake', '~> 10.4'
end

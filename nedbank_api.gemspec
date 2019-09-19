# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nedbank_api/version'

Gem::Specification.new do |s|
  s.name = %q{nedbank_api}
  s.version = NedbankApi::VERSION
  s.date = %q{2019-09-11}
  s.summary = %q{Nedbank API gem makes communicating with the Nedbank API quick and easy}
  s.licenses = ['MIT']
  s.authors = ['Jono Booth']
  s.email = 'jonobth@gmail.com'
  s.metadata = { 'source_code_uri' => 'https://github.com/jono-booth/nedbank_api' }

  s.files = `git ls-files -z`.split("\x0")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^spec/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 1.5'
  s.add_development_dependency 'rake', '~> 12.3'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'rspec-nc', '~> 0.3'
  s.add_development_dependency 'webmock', '~> 3.7'
  s.add_development_dependency 'factory_bot', '~> 5.0'
  s.add_development_dependency 'guard', '~> 2.15'
  s.add_development_dependency 'guard-rspec', '~> 4.7'
  s.add_development_dependency 'pry', '~> 0.12'
  s.add_development_dependency 'pry-remote', '~> 0.1'
  s.add_development_dependency 'pry-nav', '~> 0.3'
  s.add_development_dependency 'httplog', '~> 1.3'

end

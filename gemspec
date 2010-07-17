lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'detabulator/version'

Gem::Specification.new do |s|
  s.name        = "detabulator"
  s.version     = Detabulator::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Battley"]
  s.email       = ["pbattley@gmail.com"]
  s.homepage    = "http://github.com/threedaymonk/detabulator"
  s.summary     = "Extract columnar data from tabulated fixed-width text"
  s.description = "Extract columnar data from tabulated fixed-width text"

  s.files        = Dir["{bin,lib}/**/*"] + %w[README.md]
  s.require_path = 'lib'
end


Gem::Specification.new do |spec|
  spec.name          = 'r_spec'
  spec.version       = File.read('VERSION.semver').chomp
  spec.authors       = ['Cyril Wack']
  spec.email         = ['contact@cyril.email']

  spec.summary       = 'Rspec clone with Fix.'
  spec.description   = 'A small Rspec clone based on Fix specing framework.'
  spec.homepage      = 'https://github.com/cyril/r_spec'
  spec.license       = 'MIT'

  spec.files         =
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'fix-expect',             '~> 0.2'
  spec.add_dependency 'fix-its',                '~> 0.3'
  spec.add_dependency 'matchi-rspec',           '~> 0.0'

  spec.add_development_dependency 'bundler',    '~> 1.10'
  spec.add_development_dependency 'rake',       '~> 10.4'
  spec.add_development_dependency 'yard',       '~> 0.8'
  spec.add_development_dependency 'simplecov',  '~> 0.10'
  spec.add_development_dependency 'rubocop',    '~> 0.34'
  spec.add_development_dependency 'spectus',    '~> 2.10'

  spec.cert_chain   = ['certs/gem-cyril-public_cert.pem']
  private_key       = File.expand_path('~/.ssh/gem-cyril-private_key.pem')
  spec.signing_key  = private_key if File.exist?(private_key)
end

Gem::Specification.new do |spec|
  spec.name          = 'r_spec'
  spec.version       = File.read('VERSION.semver').chomp
  spec.authors       = ['Cyril Kato']
  spec.email         = ['contact@cyril.email']

  spec.summary       = 'Rspec clone with Fix.'
  spec.description   = 'A small Rspec clone based on Fix specing framework.'
  spec.homepage      = 'https://github.com/cyril/r_spec'
  spec.license       = 'MIT'

  spec.files         =
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'fix-expect',             '~> 0.3.2'
  spec.add_dependency 'fix-its',                '~> 0.5.1'
  spec.add_dependency 'fix-let',                '~> 0.1.1'
  spec.add_dependency 'matchi-rspec',           '~> 0.1.1'

  spec.add_development_dependency 'bundler',    '~> 1.14'
  spec.add_development_dependency 'rake',       '~> 12.0'
  spec.add_development_dependency 'yard',       '~> 0.9'
  spec.add_development_dependency 'simplecov',  '~> 0.14'
  spec.add_development_dependency 'rubocop',    '~> 0.48'
  spec.add_development_dependency 'spectus',    '~> 3.0'

  spec.cert_chain   = ['certs/gem-cyril-public_cert.pem']
  private_key       = File.expand_path('~/.ssh/gem-cyril-private_key.pem')
  spec.signing_key  = private_key if File.exist?(private_key)
end

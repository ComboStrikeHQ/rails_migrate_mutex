# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name = 'rails_migrate_mutex'
  s.version = '1.2.0'
  s.summary = 'Runs Rails migrations in a Redis-backed mutex.'
  s.description = s.summary
  s.authors = ['ad2games GmbH']
  s.email = 'developers@ad2games.com'
  s.homepage = 'https://github.com/ad2games/rails_migrate_mutex'
  s.license = 'MIT'

  s.files = Dir['lib/**/*']

  s.add_dependency 'railties'
  s.add_dependency 'redis-mutex'

  s.add_development_dependency 'rspec'
end

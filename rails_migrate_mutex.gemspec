$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'rails_migrate_mutex'
  s.version     = '1.0.1'
  s.date        = '2015-04-14'
  s.summary     = 'Runs Rails migrations in a Redis-backed mutex.'
  s.description = ''
  s.authors     = ['ad2games GmbH']
  s.email       = 'developers@ad2games.com'
  s.files       = Dir['lib/**/*']
  s.homepage    = 'http://www.ad2games.com'
  s.license     = ''

  s.add_dependency 'rake'
  s.add_dependency 'redis-mutex'

  s.add_development_dependency 'rspec'
end

# frozen_string_literal: true
# Instead of using a whole rails app fixture, let's just assume this is how Railties work.
module Rails
  class Railtie
    def self.rake_tasks
      raise 'Rake should not be loaded until this point' if defined?(Rake)

      require 'rake'
      yield
    end
  end
end

require 'rails_migrate_mutex'

namespace :db do
  task :migrate do
    Redis.current.incrby('db-migrate-call-count', 1)
    sleep 0.2
  end
end

RSpec.describe 'rails-migrate-mutex' do
  let(:redis) { Redis.current }

  before { redis.flushdb }

  it 'runs db:migrate in a redis mutex' do
    Array.new(2) do
      Thread.new { Rake::Task['db:migrate:mutex'].invoke }
    end.map(&:join)

    expect(redis.get('db-migrate-call-count')).to eq('1')
  end
end

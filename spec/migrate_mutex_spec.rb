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

task :environment do
  Redis.current = Redis.new
end

namespace :db do
  task :migrate do
    Redis.current.incrby('db-migrate-call-count', 1)
    sleep 0.2
  end
end

RSpec.describe 'rails-migrate-mutex' do
  let(:redis) { Redis.current }

  before do
    redis.flushdb

    # Stub redis instance, so we can test that it will be set in the environment task,
    # which needs to run before we use redis again.
    Redis.current = :stub
  end

  it 'runs db:migrate in a redis mutex' do
    Array.new(2) do
      Thread.new { Rake::Task['db:migrate:mutex'].invoke }
    end.map(&:join)

    expect(redis.get('db-migrate-call-count')).to eq('1')
  end
end

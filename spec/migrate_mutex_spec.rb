require 'rails_migrate_mutex'

namespace :db do
  task :migrate do
    Redis.current.incrby('db-migrate-call-count', 1)
    sleep 0.2
  end
end

RSpec.describe 'rails-migrate-mutex' do
  let(:redis) { Redis.current }

  it 'runs db:migrate in a redis mutex' do
    redis.flushdb

    2.times.map do
      Thread.new { Rake::Task['db:migrate:mutex'].invoke }
    end.map(&:join)

    expect(redis.get('db-migrate-call-count')).to eq('1')
  end
end

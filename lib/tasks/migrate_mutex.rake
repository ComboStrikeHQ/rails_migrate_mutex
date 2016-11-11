# frozen_string_literal: true
namespace :db do
  namespace :migrate do
    desc 'Runs db:migrate in a redis-backed mutex'
    task :mutex do
      TIMEOUT = 5 * 60 * 60

      # We want to set the redis instance to a sensible default, but only if it has not been set.
      # If it has not been set, it will raise an error. It's a bit messy, but works fine.
      begin
        RedisClassy.redis
      rescue RedisClassy::Error
        RedisClassy.redis = Redis.current
      end

      RedisMutex.with_lock('db-migrate-mutex', block: TIMEOUT, expire: TIMEOUT) do
        Rake::Task['db:migrate'].invoke
      end
    end
  end
end

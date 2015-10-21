namespace :db do
  namespace :migrate do
    desc 'Runs db:migrate in a redis-backed mutex'
    task :mutex do
      TIMEOUT = 5 * 60 * 60

      RedisClassy.redis ||= Redis.current

      RedisMutex.with_lock('db-migrate-mutex', block: TIMEOUT, expire: TIMEOUT) do
        Rake::Task['db:migrate'].invoke
      end
    end
  end
end

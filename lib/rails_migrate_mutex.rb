# frozen_string_literal: true
if defined?(Rails)
  class RailsMigrateMutexRailtie < Rails::Railtie
    rake_tasks do
      require 'redis-mutex'
      load 'tasks/migrate_mutex.rake'
    end
  end
end

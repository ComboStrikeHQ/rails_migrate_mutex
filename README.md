# Rails db:migrate:mutex

Runs Rails migrations in a Redis-backed mutex.

If you deploy your application to multiple servers and do not use a deployment tool
like Capistrano, this gems makes sure that only one of your servers run the database migrations.

Running Rails migrations on multiple instance at the same time should not cause any real trouble,
because they are run inside transactions, but can cause excessive DB load and Ruby exceptions.

## Usage

Run `rake db:migrate:mutex` instead of `rake db:migrate` to ensure that the migrations
are only run on one server at the same time.

## Installation

Add the gem to your Gemfile:

```ruby
gem 'rails_migrate_mutex'
```

If `Redis.current` does not contain a valid Redis connection, you might need to set it manually:

```ruby
# config/initializers/redis_classy.rb
RedisClassy.redis = Redis.new(...)
```

## Contributing

Feel free to fork and submit pull requests!

## License
MIT, see `LICENSE.txt`.

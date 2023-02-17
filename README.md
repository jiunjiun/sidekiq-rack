# sinatra-sidekiq

Sidekiq web server with sidekiq-scheduler of sinatra

## Configure

1. Setup environment variables

        $ cp .env.sample .env

2. Edit environment variables

        REDIS_URL=redis://127.0.0.1
        USERNAME=admin
        PASSWORD=12345566

## Getting Started

1. Install gems at the command prompt if you haven't yet:

        $ bundle install

3. start the sidekiq web server:

        $ rackup config.ru

   Run with `--help` or `-h` for options.

4. Go to `http://localhost:9292` and you'll see the Rails bootscreen with your Rails and Ruby versions.

   Default username and password

        username: admin
        password: 12345566

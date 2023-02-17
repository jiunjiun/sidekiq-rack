# sidekiq-rack

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

3. Start the sidekiq web server:

        $ rackup

   Run with `--help` or `-h` for options.

4. In background running sidekiq web server

        $ rackup --host 0.0.0.0 -p 9292 -D

5. Go to `http://localhost:9292` and you'll see the Sidekiq bootscreen.

   Default username and password

        username: admin
        password: 12345566

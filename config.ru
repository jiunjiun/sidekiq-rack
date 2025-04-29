# frozen_string_literal: true

# inspiration from
# https://github.com/mperham/sidekiq/wiki/Monitoring#standalone-with-basic-auth

require 'sidekiq'
require 'sidekiq/web'
# require 'sidekiq-scheduler/web'
require 'rack/session'

require 'securerandom'
require 'dotenv/load'

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch('REDIS_URL', 'redis://127.0.0.1:6379'),
    size: 1
  }
end

File.open('.session.key', 'w') { |f| f.write(SecureRandom.hex(32)) }

map '/' do
  env_username = ENV.fetch('USERNAME', 'admin')
  env_password = ENV.fetch('PASSWORD', '12345566')

  use Rack::Auth::Basic, 'Protected Area' do |username, password|
    # Protect against timing attacks: (https://codahale.com/a-lesson-in-timing-attacks/)
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking
    # Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(env_username)) &
    #   Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(env_username))
    username == env_username && password == env_password
  end

  use Rack::Session::Cookie, secret: File.read('.session.key'), same_site: true, max_age: 86_400

  run Sidekiq::Web
end

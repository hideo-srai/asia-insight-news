set :branch, 'master'
set :rails_env, 'staging'
set :unicorn_env, 'staging'

server 'phoenix', user: 'demo', roles: %w[app web db]
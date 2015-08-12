# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'mni_asia_insight'
set :rails_env, :staging
set :repo_url, 'git@gitlab.risearrow.com:root/mni-asia-insight.git'

set :deploy_to, "/home/demo/apps/#{fetch(:application)}/#{fetch(:rails_env)}"

set :linked_files, %w{config/boot.rb config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids public/assets tmp/cache tmp/sockets vendor/bundle public/system }

set :unicorn_config_path, "#{release_path}/config/unicorn.rb"

set :keep_releases, 5
set :ssh_options, { forward_agent: true }

set :rbenv_ruby, '2.1.5'

after 'deploy:publishing', 'app:restart'

task :seed_data do
  on roles :all do
    within release_path do
      with rails_env: fetch(:rails_env) do
        execute :rake, "seed:migrate"
      end
    end
  end
end

after 'deploy:finished', 'seed_data'

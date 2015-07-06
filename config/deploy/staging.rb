set :rails_env, "staging"

# Primary domain name of your application. Used in the Apache configs
set :domain, "unepwcmc-012.vm.brightbox.net"

# List of servers
server "unepwcmc-012.vm.brightbox.net", :app, :web, :db, :primary => true

set :application, "ppe-reader"
set :server_name, "ppe-reader.unepwcmc-012.vm.brightbox.net"
set :sudo_user, "rails"
set :app_port, "80"

desc "Configure VHost"
task :config_vhost do
  vhost_config =<<-EOF
    server {
      listen 80;
      client_max_body_size 4G;
      server_name #{application}.unepwcmc-012.vm.brightbox.net;
      keepalive_timeout 5;
      root #{deploy_to}/current/public;
      passenger_enabled on;
      rails_env staging;

      add_header 'Access-Control-Allow-Origin' *;
      add_header 'Access-Control-Allow-Methods' "GET, POST, PUT, DELETE, OPTIONS";
      add_header 'Access-Control-Allow-Headers' "X-Requested-With, X-Prototype-Version";
      add_header 'Access-Control-Max-Age' 1728000;

      gzip on;
      location ^~ /assets/ {
        expires max;
        add_header Cache-Control public;
      }

      if (-f $document_root/system/maintenance.html) {
        return 503;
      }

      error_page 500 502 504 /500.html;
      location = /500.html {
        root #{deploy_to}/public;
      }

      error_page 503 @maintenance;
      location @maintenance {
        rewrite  ^(.*)$  /system/maintenance.html break;
      }
    }
  EOF

  put vhost_config, "/tmp/vhost_config"

  sudo "mv /tmp/vhost_config /etc/nginx/sites-available/#{application}"
  sudo "ln -s /etc/nginx/sites-available/#{application} /etc/nginx/sites-enabled/#{application}"
end

after "deploy:setup", :config_vhost
after "deploy:finalize_update", "deploy:assets:precompile"

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run "cd #{latest_release} && bundle exec #{rake} RAILS_ENV=#{rails_env} assets:precompile"
    end
  end
end

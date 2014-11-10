namespace :librarian_puppet do
  task :check do
    on release_roles :all do
      execute :mkdir, '-p', shared_path.join('librarian/modules')
    end
  end
  after 'deploy:check', 'librarian_puppet:check'

  task :install do
    on release_roles :all do
      execute :mkdir, '-p', release_path.join('vendor')
      execute :ln, '-sf', shared_path.join('librarian/modules'), release_path.join('vendor/modules')
      execute "cd #{release_path}; LIBRARIAN_PUPPET_TMP=#{shared_path} bundle exec librarian-puppet install"
    end
  end
  after 'bundler:install', 'librarian_puppet:install'
end

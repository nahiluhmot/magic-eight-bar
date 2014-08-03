# This file has logic to build the javascript and create the frontend.

namespace :js do
  directory 'js/public' do
    `cd #{Rails.root}/js/ && grunt`
    raise "Could not compile the javascript" unless $?.success?
  end

  directory 'public' => 'js/public' do
    `mv #{Rails.root}/js/public #{Rails.root}/public`
    raise 'Could not compile the javascript' unless $?.success?
  end

  task :build => 'public'

  task :clean do
    `rm -rf public/`
  end

  task :rebuild => [:clean, :build]
end

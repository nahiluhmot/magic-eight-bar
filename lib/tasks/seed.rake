namespace :seed do
  task :bars => :environment do
    GooglePlacesService.save_bars
  end
end

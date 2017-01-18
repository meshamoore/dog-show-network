require_relative '../scraper/onofrio.rb'

namespace :scrape do
  desc "Scrape dog show sites for events"

  task onofrio: :environment do
    scraper = Scraper::Onofrio.new
    shows = scraper.scrape
    shows.each do |show|
      Show.create(show)
    end
  end

  task baray: :environment do
    scraper = Scraper::Baray.new
    shows = scraper.scrape
  end
end

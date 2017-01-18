namespace :scrape do
  desc "Scrape dog show sites for events"

  task onofrio: :environment do
    scraper = Scraper::Onofrio.new
    scraper.scrape
  end

  task baray: :environment do
    scraper = Scraper::Baray.new
    scraper.scrape
  end
end

require 'open-uri'
require 'nokogiri'
require 'date'

module Scraper
    class Onofrio
        def scrape
            doc = Nokogiri::HTML(open('http://www.onofrio.com/execpgm/fndindex'))
            shows = []
            doc.css('.infinitescroll').each do |parent|
                parent.children.css('h5').each do |child|

                    closing_date = DateTime.strptime(child.text, 'Closing %m/%d/%Y @ %l:%M %P')

                    child.next_element.css('ul li').each do |line|

                        next if line.children[1].nil?

                        name = line.children.first.children.first.text
                        info = line.children[1].text

                        parts = info.gsub("\n", '').slice(2..info.length).split(', ')
                        location_parts = parts[0].split(' ')
                        state = location_parts.last
                        location_parts.delete(state)
                        city = location_parts.join(' ')
                        year = parts[-1]
                        month_and_day = parts[-2]

                        shows.push({
                            name: name,
                            city: city,
                            state: state,
                            closing_date: closing_date,
                            show_date: DateTime.strptime(month_and_day + ' ' + year, '%B %e %Y'),
                            superintendent: 'Onofrio'
                        })
                    end
                end
            end
            shows
        end
    end
end

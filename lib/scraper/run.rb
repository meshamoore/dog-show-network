require_relative 'baray.rb'
require_relative 'onofrio.rb'
require 'open-uri'
require 'nokogiri'

scraper = Scraper::Onofrio.new

scraper.scrape

doc = Nokogiri::HTML(open('http://www.onofrio.com/execpgm/fndindex'))
shows = []

doc.css('.infinitescroll').each do |parent|
  parent.children.css('h5').each do |child|

    # Consider parsing the date string into an actual DateTime object, especially for storing in DB
    closing_date = child.text

    child.next_element.css('ul li').each do |line|

        if line.children[1].nil?
            next
        end

        name = line.children.first.children.first.text
        info = line.children[1].text

        parts = info.gsub("\n", '').slice(2..info.length).split(', ')
        location_parts = parts[0].split(' ')
        state = location_parts.last
        location_parts.delete(state)
        city = location_parts.join(' ')
        year = parts[-1]
        month_day = parts[-2]

        # Could use Time.parse instead of split
        month = month_day.split(' ')[0]
        day = month_day.split(' ')[1]
        # puts parts.inspect

        shows.push({
            closing_date: closing_date,
            name: name,
            city: city,
            state: state,
            year: year,
            month: month,
            day: day
        })
    end

    # links = child.next_element.css('a')
    # links.each do |link|
    #   href = link.attributes['href'].value
    #   show_name = link.text
    #   is_link_to_show = href.include?('show=')
    #   shows.push({name: show_name, closing_date: closing_date}) if is_link_to_show
    # end
  end
end

shows.each do |show|
  puts show.inspect
# Date::MONTHNAMES.index("June")
# Time.new(year, month, day, hours, minutes, seconds)
end

# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'

class Prototype::Crawlers::One
  DEFAULT_URL = 'https://www.co-berlin.org/en/calender'

  def self.call
    # Fetch and parse HTML document
    doc = Nokogiri::HTML(open(url))

    doc.css('.seite-c-single').each do |link|
      process_event link
    end
  end

  def self.process_event(section)
    id = section.css(' > a')[0]&.attribute('href').content
    event = Event.find_by(source_id: id)
    unless event
      event = Event.create! dates(section).merge(title: section.css('.article-title')[0]&.content,
        description: section.css('.article-text')[0]&.content,
        source_id: id,
        link: section.css('a')[0]&.attribute('href').content
      )
    end
    event
  rescue StandardError => e
    Rails.logger.warn m: 'Crawlers::One: Problem with import of event', id: id, error: e.message,
      backtrace: e.backtrace
  end

  def self.url
    ENV['source_one_url'] || DEFAULT_URL
  end

  def self.dates(section)
    date = section.css('.date-display-start')[0]&.attribute('content')&.content
    end_date = section.css('.date-display-end')[0]&.attribute('content')&.content
    unless date
      date = end_date = section.css('.date-display-single')[0]&.attribute('content')&.content
    end

    {
      date: date,
      end_date: end_date
    }
  end

end

# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'

class Prototype::Crawlers::Two < Prototype::Crawlers::Base
  DEFAULT_URL = 'https://gorki.de/en/programme/%{year}/%{month}/all'
  TYPE = 'two'

  def self.call
    # Fetch and parse HTML document
    doc = Nokogiri::HTML(open(url))

    doc.css('.schedule-item-list').each do |section|
      next if section.css('.no-tickets').any?
      section.css('.item-list--row-item-content').each do |link|
        process_event link, section
      end
    end
  end

  def self.process_event(section, parent)
    id = section.css('.h3 > a')[0]&.attribute('href').content

    event = Event.find_by(source_id: id, source_type: TYPE)
    unless event
      event = Event.create! dates(section, parent).merge(title: section.css('.h3 > a')[0]&.attribute('title').content,
        description: section.css('.cast')[0]&.content,
        source_id: id,
        link: section.css('.h3 > a')[0]&.attribute('href').content,
        source_type: TYPE
      )
    end
    event
  rescue StandardError => e
    Rails.logger.warn m: 'Crawlers::One: Problem with import of event', id: id, error: e.message,
      backtrace: e.backtrace
  end

  def self.url
    (ENV['source_two_url'] || DEFAULT_URL) % { year: Date.new.year, month: Date.new.month }
  end

  def self.dates(section, parent)
    day = parent.css('.schedule-item-list--date--day')[0]&.content
    date = section.css('.is-headline-sub')[0]&.content

    data = date.match(/(\d\d\:\d\d\s*(pm|am))(\s*-\s*(\d\d:\d\d\s*(pm|am)))?/)

    now = Date.new
    date = DateTime.parse("#{day}/#{now.month}#{now.year} #{data[1]}")
    end_date = DateTime.parse("#{day}/#{now.month}#{now.year} #{data[4] || data[1]}")

    {
      date: date,
      end_date: end_date
    }
  end

end

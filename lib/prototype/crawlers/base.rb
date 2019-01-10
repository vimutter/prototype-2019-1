# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'

class Prototype::Crawlers::Base

  # This is entry point of crawler. It will do HTTP interactions and create new Events
  # Currently there is not much shared across different crawlers, but already seen future places
  # for generalization: dates parsing, links/id extraction and so on.
  def self.call
    # Fetch and parse HTML document
    doc = Nokogiri::HTML(open(url))

    doc.css(row_selector).each do |link|
      process_event link
    end
  end
end

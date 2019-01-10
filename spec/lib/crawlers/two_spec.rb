require 'rails_helper'

RSpec.describe Prototype::Crawlers::Two do
  describe '.call', vcr: true do
    it 'runs crawling and saves Event with new version' do
      expect { described_class.call }.to change { Event.count }.by(26)
    end
  end
end

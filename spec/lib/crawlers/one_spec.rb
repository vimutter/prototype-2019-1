require 'rails_helper'

RSpec.describe Prototype::Crawlers::One do
  describe '.call', vcr: true do
    it 'runs crawling and saves Event with new version' do
      expect { described_class.call }.to change { Event.count }.by(5)
    end
  end
end

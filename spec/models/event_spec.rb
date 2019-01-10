require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :link }
  it { is_expected.to validate_presence_of :source_id }
end

module Prototype::Crawlers
end

require_relative 'crawlers/one'

module Prototype::Crawlers
  CRAWLERS = [One]

  def self.run
    CRAWLERS.each(&:call)
    true
  end
end

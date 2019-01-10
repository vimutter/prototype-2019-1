module Prototype::Crawlers
end

require_relative 'crawlers/base'
require_relative 'crawlers/one'
require_relative 'crawlers/two'

module Prototype::Crawlers
  CRAWLERS = [One, Two]

  def self.run
    CRAWLERS.each(&:call)
    true
  end
end

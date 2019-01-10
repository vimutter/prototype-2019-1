class UpdateEventsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Prototype::Crawlers.run
  end
end

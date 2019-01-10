class EventsController < ApplicationController
  def index
    @q = Event.ransack(params[:q])
    @events = @q.result
  end
end

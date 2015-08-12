class EventsController < FrontController
  def index
    @events = Event.upcoming
  end
end
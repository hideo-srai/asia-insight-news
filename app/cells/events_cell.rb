class EventsCell < FrontendCell
  def sidebar
    @events = Event.includes(:country).upcoming.limit(3)
    if @events.any?
      render
    else
      render nothing: true
    end
  end
end

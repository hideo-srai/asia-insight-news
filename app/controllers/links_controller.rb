class LinksController < FrontController
  def index
    @links = Link.latest
  end
end
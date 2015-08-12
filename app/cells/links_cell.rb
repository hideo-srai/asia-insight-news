class LinksCell < FrontendCell
  def sidebar
    @links = Link.latest.limit(5)

    if @links.any?
      render
    else
      render nothing: true
    end
  end
end

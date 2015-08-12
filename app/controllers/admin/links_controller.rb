class Admin::LinksController < AdminController
  def index
    @links = Link.latest.paginate(paginate_params)
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    link_parser = LinkParser.new

    begin
      title, description = link_parser.parse_link(link_params[:url])
      @link.title = title if @link.title.empty?
      @link.description = description if @link.description.empty?
    rescue ArgumentError, OpenSSL::SSL::SSLError => e
    end

    if @link.save
      flash[:success] = 'Link was successfully created'

      redirect_to admin_links_path
    else
      flash[:error] = "Can't create a link. Checkout the errors below"
      render 'new'
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])

    if @link.update_attributes(link_params)
      flash[:success] = 'Link was successfully updated'

      redirect_to admin_links_path
    else
      flash[:error] = 'Please checkout the link updating errors'
      render 'edit'
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy if @link.present?

    redirect_to admin_links_path, flash: { success: 'Link was successfully destroyed' }
  end


  protected

  def link_params
    params.require(:link).permit(:url, :title, :description, :in_ticker, :published_at)
  end
end
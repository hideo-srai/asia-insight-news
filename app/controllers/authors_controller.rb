class AuthorsController < FrontController
  def show
    @author = Author.friendly.find(params[:id])
    @posts = @author.posts.ranked
  end
end
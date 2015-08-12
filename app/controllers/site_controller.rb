class SiteController < FrontController
  def sitemap
    @posts = apply_posts_scope(Post.latest)
    respond_to do |format|
      format.xml { render }
    end
  end
end
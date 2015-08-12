class BlogPostsController < FrontController
  PER_PAGE = 5
  def index
    @blog_posts = BlogPost.latest.paginate(page: params[:page], per_page: PER_PAGE)
    @next_page_path = blog_posts_path page: @blog_posts.next_page

    respond_to do |format|
      format.html
      format.js
    end
  end
  def show
    @blog_post = BlogPost.friendly.find(params[:id])
  end
end
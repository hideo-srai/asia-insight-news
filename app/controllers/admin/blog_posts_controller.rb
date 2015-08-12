class Admin::BlogPostsController < AdminController
  before_action :find_blog_post, only: [:edit, :update, :show, :destroy]

  def index
    posts = BlogPost

    @q = posts.search(params[:q])
    @blog_posts = @q.result.paginate(paginate_params)
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    if @blog_post.save
      redirect_to edit_admin_blog_post_path @blog_post
    else
      flash[:error] = "Can't create a blog post. Checkout the errors below"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @blog_post.update_attributes(blog_post_params)

      redirect_to edit_admin_blog_post_path @blog_post
    else
      flash[:error] = 'Please checkout the blog post updating errors'
      render 'edit'
    end
  end

  def destroy
    @blog_post.destroy if @blog_post.present?

    redirect_to admin_blog_posts_path, flash: { success: 'Blog Post was successfully removed.' }
  end



  def find_blog_post
    @blog_post = BlogPost.friendly.find(params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(:cover, :remove_cover, :cover_remove, :headline, :content, :readout,
                                     :published_at)
  end
end

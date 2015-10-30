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
      process_blog_post_on_success_update(@blog_post)
    else
      flash[:error] = "Can't create a blog post. Checkout the errors below"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)

      process_blog_post_on_success_update(@blog_post)
    else
      flash[:error] = 'Please checkout the blog post updating errors'
      render 'edit'
    end
  end

  def destroy
    @blog_post.destroy if @blog_post.present?

    redirect_to admin_blog_posts_path, flash: { success: 'Blog Post was successfully removed.' }
  end

  private

  def process_blog_post_on_success_update(blog_post)
    redirect_path = admin_blog_posts_path
    case params[:commit]
    when 'Save'
      flash[:success] = 'Blog post was successfully updated'
    when 'Preview'
      session[:blog_post_preview_id] = blog_post.id
      redirect_path = blog_post_path(blog_post.id)
    when 'Publish'
      blog_post.published = true
      blog_post.published_at ||= Time.zone.now
      blog_post.save

      flash[:success] = 'Blog post was successfully published'
    end

    redirect_to redirect_path
  end

  def find_blog_post
    @blog_post = BlogPost.friendly.find(params[:id])
  end

  def blog_post_params
    params.require(:blog_post).permit(
      :cover, :remove_cover, :cover_remove, :headline, :content,
      :readout, :published_at, :published, country_ids: [])
  end
end

class PostsController < FrontController
  PER_PAGE = 5

  before_action :fetch_posts, only: [:index, :show]

  def index
    @is_home_page = params[:is_home_page]

    respond_to do |format|
      format.html { render '_index' }
      format.js
    end
  end

  def show
    scope = session[:post_preview_id] ? Post : apply_posts_scope(Post.all)
    @post = scope.friendly.find(params[:id])
    impressionist(@post)

    @posts = @posts.where.not(id: @post.id)
  end

  def mark_read
    @post = Post.friendly.find(params[:id])
    impressionist(@post)

    render nothing: true
  end


  protected

  def fetch_posts
    @posts = apply_posts_scope(Post.ranked)
    if params[:section_slug].present?
      if (@section = PostSection.friendly.find(params[:section_slug]))
        section_ids = [@section.id] + @section.subsections.pluck(:id)

        @posts = @posts.joins(:post_sections_posts).where('post_sections_posts.post_section_id' => section_ids)
      end
    end

    if params[:country_slug].present?
      if (@country = Country.friendly.find(params[:country_slug]))
        @posts = @posts.joins("INNER JOIN post_countries ON (post_countries.post_id=posts.id AND post_countries.country_id=#{@country.id})")
      end
    end

    @posts = @posts.includes(:authors, :countries, :post_sections).paginate(page: params[:page], per_page: PER_PAGE)

    @next_page_path = if @section
                        section_posts_path section_slug: @section.slug, page: @posts.next_page
                      elsif @country.present?
                        country_posts_path country_slug: @country.slug, page: @posts.next_page
                      else
                        posts_path page: @posts.next_page
                      end
  end
end
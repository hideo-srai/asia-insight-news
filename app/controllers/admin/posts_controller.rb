class Admin::PostsController < AdminController
  before_action :find_post, only: [:edit, :update, :show, :destroy]

  def select_type
  end

  def index
    posts = Post.ranked

    @q = posts.search(params[:q])
    @posts = @q.result.includes(:tags, :countries).paginate(paginate_params)
  end

  def new
    @post = Post.new
    @post.published_at = Time.zone.now
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      @post.update_attribute :rank_position, params[:post][:rank_position].to_i
      process_post_on_success_update(@post)
    else
      flash[:error] = "Can't create a post. Checkout the errors below"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      if params[:post][:rank_position].present?
        @post.update_attribute :rank_position, params[:post][:rank_position].to_i
      end

      process_post_on_success_update(@post)
    else
      flash[:error] = 'Please checkout the post updating errors'
      render 'edit'
    end
  end

  def destroy
    @post.destroy if @post.present?

    redirect_to admin_posts_path, flash: { success: 'Post was successfully removed.' }
  end

  def new_twitter_alert
    @post = Post.friendly.find(params[:post_id])
    @twitter_alert_form = Admin::TwitterAlertForm.new
    render 'twitter_alerts'
  end

  def alert_via_twitter
    @post = Post.friendly.find(params[:post_id])
    @twitter_alert_form = Admin::TwitterAlertForm.new(twitter_alert_form_params)

    if @twitter_alert_form.valid? && TwitterAccount.has_twitter_account?
      begin
        TwitterPoster.new(twitter_alert_form_params[:twitter_account_id]).tweet_post(@post, @twitter_alert_form.twitter_text)

        redirect_to edit_admin_post_path(@post), flash: { success: 'Post was successfully tweeted' }

        return
      rescue StandardError => e
        flash[:error] = "Twitter: #{e.message}"
      end
    else
      flash[:error] = "Can't tweet. You have no twitter account connected or tweet text is empty"
    end

    render 'twitter_alerts'
  end

  protected


  def process_post_on_success_update(post)
    redirect_path = admin_posts_path
    case params[:commit]
      when 'Save'
        flash[:success] = 'Post was successfully updated'
      when 'Preview'
        session[:post_preview_id] = @post.id
        redirect_path = post_path(post.id)
      when 'Publish'
        post.published = true
        post.published_at ||= Time.zone.now
        post.save

        flash[:success] = 'Post was successfully published'
    end

    redirect_to redirect_path
  end



  def find_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    p = params.require(:post).permit(:place, :cover, :remove_cover, :cover_remove, :headline, :byline, :content,
                                 :featured_level, :in_digest, :published, :published_at, :is_breaking_news, :authors_pick,
                                 :cover_description, :cover_credits, :video_mp4, :video_webm, :seo_title, :seo_keywords, :seo_description,
                                 :tag_list, :author_ids_ordered, :in_ticker, :in_carousel, :visibility,
                                 author_ids: [], post_section_ids: [], country_ids: [] )

    if p['author_ids_ordered'].present?
      p['author_ids'] = p['author_ids_ordered'].split(',')
    end
    p.delete 'author_ids_ordered'

    p
  end

  def twitter_alert_form_params
    params.require(:admin_twitter_alert_form).permit(:twitter_text, :twitter_account_id)
  end

  def Post
    Post
  end
end

class TopStoriesCell < FrontendCell
  def main
    scoped_posts = apply_posts_scope(Post.with_image)
    @top_posts = scoped_posts.in_carousel.limit(5)
    @breaking_news_post = apply_posts_scope(Post.ranked).breaking_news.first

    if @top_posts.any?
      render
    else
      render nothing: true
    end
  end

  def sidebar
    @top_posts = apply_posts_scope(Post.last_week).by_views.ranked.limit(10)
    render
  end
end
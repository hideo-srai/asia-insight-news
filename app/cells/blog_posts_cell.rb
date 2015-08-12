class BlogPostsCell < FrontendCell
  def sidebar
    @posts = BlogPost.latest.limit(3)
    @user = current_user
    if @posts.any?
      render
    else
      render nothing: true
    end
  end
end

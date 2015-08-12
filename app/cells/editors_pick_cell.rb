class EditorsPickCell < FrontendCell
  POSTS_COUNT = 10
  def show
    @posts = apply_posts_scope(Post.authors_pick.ranked).limit(POSTS_COUNT)
    render
  end
end

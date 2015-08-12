class SectionsCell < FrontendCell
  def sidebar
    @section = PostSection.find_by_code(:chart_of_the_day)
    @post = apply_posts_scope(@section.posts.latest).first

    render
  end
end

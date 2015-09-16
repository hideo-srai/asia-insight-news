xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Posts"
    xml.description "Lots of posts"
    xml.link posts_url(format: :rss)

    @posts.each do |post|
      xml.item do
        xml.title post.headline
        xml.description post.content
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link post_url(post,format: :rss)
        xml.guid post_url(post,format: :rss)
      end
    end
  end
end

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Asia Insight"
    xml.description "Insights Into the economies of Asia."
    xml.link blog_posts_url(format: :rss)

    @blog_posts.each do |blog_post|
      xml.item do
        xml.title blog_post.headline
        xml.description blog_post.readout
        xml.pubDate blog_post.published_at.to_s(:rfc822)
        xml.link blog_post_url(blog_post,format: :rss)
        xml.guid blog_post_url(blog_post,format: :rss)
      end
    end
  end
end

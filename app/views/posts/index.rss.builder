xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Asia Insight"
    xml.description "Insights Into the economies of Asia."
    xml.link posts_url(format: :rss)

    @posts.each do |post|
      xml.item do
        xml.title post.headline
        xml.description post.byline
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link post_url(post,format: :rss)
        xml.guid post_url(post,format: :rss)
      end
    end
  end
end

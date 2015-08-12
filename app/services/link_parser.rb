require 'mechanize'

class LinkParser < Mechanize
  def parse_link(link_url)
    story_page = self.get(link_url)

    if story_page.is_a? Mechanize::Page
      if (title_object = story_page.at('title')).present?
        title = title_object.text
      end

      if (description_object = story_page.at('meta[name=description]')).present?
        description = description_object.attributes['content'].try(:value)
      end
    end

    return title, description
  end
end
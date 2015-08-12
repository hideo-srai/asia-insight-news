class MenuCell < FrontendCell
  include Devise::Controllers::Helpers

  def sidebar
    @root_sections = PostSection.root.in_menu.latest
    @countries = Country.all
    render
  end
end

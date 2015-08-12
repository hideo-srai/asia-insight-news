class AddDefaultSections < ActiveRecord::Migration
  def up
    ['Economy', 'Policy', 'Politics', 'Emerging Markets', 'Interview'].each do |section_name|
      PostSection.create(name: section_name)
    end
  end
end

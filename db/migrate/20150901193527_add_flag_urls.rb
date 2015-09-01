class AddFlagUrls < ActiveRecord::Migration
  def up
    Country.find_each do |country|
      flag = country.name.downcase.gsub(' ', '_')
      country.update(flag_url: "/flags/#{flag}.jpg")
    end
  end
end

class AddDefaultCountries < ActiveRecord::Migration
  def up
    ['Australia', 'China', 'Japan', 'Hong Kong', 'India', 'Indonesia', 'Malaysia', 'New Zealand', 'Singapore',
     'South Korea', 'Philippines', 'Taiwan', 'Thailand', 'Vietnam'].each do |country_name|
      Country.create(name: country_name)
    end
  end
end

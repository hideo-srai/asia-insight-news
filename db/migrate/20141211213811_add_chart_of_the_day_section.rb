class AddChartOfTheDaySection < ActiveRecord::Migration
  def up
    PostSection.create(name: 'Chart of the day', code: 'chart_of_the_day', in_menu: false)
  end
end

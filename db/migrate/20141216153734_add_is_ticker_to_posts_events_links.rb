class AddIsTickerToPostsEventsLinks < ActiveRecord::Migration
  def change
    add_column :posts, :in_ticker, :boolean, default: false
    add_column :events, :in_ticker, :boolean, default: false
    add_column :links, :in_ticker, :boolean, default: false
    add_column :central_banks, :in_ticker, :boolean, default: false
  end
end

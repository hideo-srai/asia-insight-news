class AddParentIdToPostSection < ActiveRecord::Migration
  def change
    add_column :post_sections, :parent_id, :integer
    add_column :post_sections, :in_menu, :boolean, default: true

    add_index :post_sections, :parent_id
  end
end

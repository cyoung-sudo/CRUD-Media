class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.integer :post_id
      t.string :content

      t.timestamps
    end
  end
end

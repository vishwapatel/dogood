class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.string :pledge_title
      t.string :pledge_description
      t.belongs_to :user

      t.timestamps
    end
    add_index :pledges, :user_id
  end
end

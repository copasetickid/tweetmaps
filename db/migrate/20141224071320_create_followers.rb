class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.string :name
      t.string :username
      t.string :location
      t.float :latitude
      t.float :longitude
      t.integer :user_id

      t.timestamps
    end
  end
end

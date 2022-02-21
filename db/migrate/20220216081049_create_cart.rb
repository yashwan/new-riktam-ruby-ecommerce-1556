class CreateCart < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.string :film_id
      t.string :user_id
      t.string :title
      t.string :cost
      t.timestamps
    end
  end
end

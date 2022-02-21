class CreateBuy < ActiveRecord::Migration[7.0]
  def change
    create_table :buys do |t|
      t.string :film_id
      t.string :user_id
      t.string :title
      t.string :cost
      t.timestamps
    end
  end
end

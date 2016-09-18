class CreateUserArrival < ActiveRecord::Migration
  def change
    create_table :user_arrivals do |t|
      t.datetime :arrived_at
      t.integer :user_id
      t.timestamps null: false
    end
  end
end

class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :nation
      t.string :state
      t.string :city
      t.string :address
      t.string :neighborhood
      t.text :report
      t.integer :user_id

      t.timestamps
    end
  end
end

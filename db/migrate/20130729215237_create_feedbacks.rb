class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :title
      t.string :email
      t.string :name
      t.text :message

      t.timestamps
    end
  end
end

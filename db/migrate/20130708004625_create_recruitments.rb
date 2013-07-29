class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.timestamps
    end
  end
end

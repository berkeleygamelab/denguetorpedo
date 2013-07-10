class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
    	t.references 
      t.timestamps
    end
  end
end

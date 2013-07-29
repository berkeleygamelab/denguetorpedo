class AddRecruiterIdAndRecruiteeIdToRecruitments < ActiveRecord::Migration
  def change
    add_column :recruitments, :recruiter_id, :integer
    add_column :recruitments, :recruitee_id, :integer
  end
end

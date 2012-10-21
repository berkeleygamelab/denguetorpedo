# == Schema Information
#
# Table name: prize_codes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  prize_id   :integer
#  expire_by  :datetime
#  code       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PrizeCode < ActiveRecord::Base
  attr_accessible :code, :expire_by, :prize_id, :user_id
  belongs_to :user
  belongs_to :prize
end

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
#  redeemed   :boolean          default(FALSE), not null
#  expired    :boolean          default(FALSE), not null
#

require 'spec_helper'

describe PrizeCode do
  pending "add some examples to (or delete) #{__FILE__}"
end

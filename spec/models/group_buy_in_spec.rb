# == Schema Information
#
# Table name: group_buy_ins
#
#  id         :integer          not null, primary key
#  prize_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_size :integer
#  expired    :boolean          default(FALSE), not null
#

require 'spec_helper'

describe GroupBuyIn do
  pending "add some examples to (or delete) #{__FILE__}"
end

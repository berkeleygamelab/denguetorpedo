# == Schema Information
#
# Table name: buy_ins
#
#  id              :integer          not null, primary key
#  group_buy_in_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  accepted        :boolean
#

require 'spec_helper'

describe BuyIn do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: prizes
#
#  id                       :integer          not null, primary key
#  prize_name               :string(255)
#  cost                     :integer
#  stock                    :integer
#  user_id                  :integer
#  description              :text
#  redemption_directions    :text
#  expire_on                :datetime
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  max_group_size           :integer
#  prize_photo_file_name    :string(255)
#  prize_photo_content_type :string(255)
#  prize_photo_file_size    :integer
#  prize_photo_updated_at   :datetime
#  community_prize          :boolean          default(FALSE), not null
#  self_prize               :boolean          default(FALSE), not null
#

require 'spec_helper'

describe Prize do
  pending "add some examples to (or delete) #{__FILE__}"
end

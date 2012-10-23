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
#

class Prize < ActiveRecord::Base
  attr_accessible :cost, :description, :expire_on, :prize_name, :redemption_directions, :stock, :user_id
  belongs_to :user
  has_many :group_buy_ins
  has_many :prize_codes
  has_attached_file :prize_photo, :styles => { :small => "60x60>", :large => "150x150>" }, :default_url => 'default_images/prize_default_image.png', :storage => STORAGE, :s3_credentials => S3_CREDENTIALS

  def generate_prize_code(user_id)
    @user = User.find(user_id)
    code = self.generate_activation_code
    PrizeCode.create({:user_id => user_id, :prize_id => self.id, :code => code})
    self.sms_prize_code(code, user_id)
  end

  def sms_prize_code(code, user_id)
    @account_sid = 'AC696e86d23ebba91cbf65f1383cf63e7d'
    @auth_token = 'a49ee186176ead11c760fd77aeaeb26c'
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    @user = User.find(user_id)
    body = "Your redemption code for " + self.prize_name + " is " + code
    @account.sms.messages.create(:from => '+15109854798', :to => @user.phone_number , :body  => body)
  end

  def generate_activation_code(size = 12)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end
end

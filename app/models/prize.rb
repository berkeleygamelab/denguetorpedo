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
#  is_badge                 :boolean          default(FALSE), not null
#

class Prize < ActiveRecord::Base
  attr_accessible :cost, :description, :expire_on, :prize_name, :redemption_directions, :stock, :user_id, :prize_photo, :community_prize, :self_prize, :is_badge
  belongs_to :user
  has_many :group_buy_ins
  has_many :prize_codes
  has_many :badges
  has_attached_file :prize_photo, :default_url => 'default_images/prize_default_image.jpg', :styles => { :small => "60x60>", :large => "150x150>" }#, :storage => STORAGE, :s3_credentials => S3_CREDENTIALS
  validates :cost, :presence => true
  validates :description, :presence => true
  validates :prize_name, :presence => true
  validates :redemption_directions, :presence => true
  validates :stock, :presence => true
  validates :user, :presence => true

  def give_badge(user_id)
    @user = User.find(user_id)
    Badge.create({:user_id => user_id, :prize_id => self.id})
  end

  def generate_prize_code(user_id)
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

    body = "Parabéns! Você resgatou " + self.prize_name + ". O seu código de resgate do prêmio é " + code + ". Imprima o cupom no site Dengue Torpedo e apresente com um documento válido com foto (ex. RG) no estabelecimento do patrocinador para resgatar o seu prêmio."
    @account.sms.messages.create(:from => '+15109854798', :to => @user.phone_number , :body  => body)      
  end

  def generate_activation_code(size = 12)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def in_stock
    return true if self.stock < 0 or self.stock > 0
    return false
  end

  def decrease_stock(n = 1)
    if stock > 0
      temp = self.stock
      self.stock = stock - n
      if self.stock < 0
        self.stock = temp
        return false
      end
    end
    return true
  end

end

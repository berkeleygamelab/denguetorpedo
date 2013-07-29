class Contact < ActiveRecord::Base
  attr_accessible :email, :message, :name, :title
end

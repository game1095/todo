class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :lists

  def name_email
    if self.name != nil && self.name != ""
      return "#{self.name}"
    else
      return  "#{self.email}"
    end
  end


end

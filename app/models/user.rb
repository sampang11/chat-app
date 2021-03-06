class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participants, :foreign_key => :sender_id

  validates_presence_of :first_name, :last_name, :email

  def generate_jwt
    JWT.encode({ id: id,
      exp: 60.days.from_now.to_i },
      Rails.application.secrets.secret_key_base)
  end
end

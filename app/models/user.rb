
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  enum role: [:admin, :agent, :client]
 

  def generate_jwt
    JWT.encode({ user_id: id, exp: 1.hour.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end


  attribute :role, :string, default: 'client'
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :middle_name, presence: false
  validates :citizenship_number, presence: true
  validates :permanent_address, presence: false
  validates :temporary_address, presence: true

  
  validates :contact_number, presence: true
  validates :email, presence: true, uniqueness: { message: "has already been taken" }
  validate :unique_email

  private

  def unique_email
    if User.exists?(email: email)
      errors.add(:email, "has already been taken")
    end
  end

end 


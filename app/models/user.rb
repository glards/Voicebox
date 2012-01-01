class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  attr_accessible :email, :password, :password_confirmation, :phone

  field :email, :type => String
  field :password_digest, :type => String
  field :phone, :type => String

  has_many :messages

  has_secure_password

  index :phone, unique: true
  index :email, unique: true

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  phone_regex = /\A\+\d{9,12}\z/

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: email_regex }

  validates :password,
    presence: true,
    length: { minimum: 6 },
    on: :create

  validates :password_confirmation,
    presence: true,
    length: { minimum: 6 },
    on: :create

  validates :phone,
    presence: true,
    length: { minimum: 10 },
    uniqueness: { case_sensitive: false },
    format: { with: phone_regex }

  def salt
    BCrypt::Password.new(@password_digest).salt
  end
end

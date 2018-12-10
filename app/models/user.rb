class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates_length_of :password, minimum: 6

  def self.authenticate_with_credentials(email, password)
    email.strip!
    email.downcase!
    user = User.find_by_email(email)
    user && user.authenticate(password) ? user : nil
  end

end

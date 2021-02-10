class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }

  # def match?(p, cp)
  #   p == cp
  # end

  def self.authenticate_with_credentials(email, p)
    user = User.find_by_email(email.strip.downcase)

    if user && user.authenticate(p)
      return user
    else 
      return nil
    end
  end

end

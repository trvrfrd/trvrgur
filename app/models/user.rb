require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :email, :username, :password
  attr_reader :password

  validates :username, :email, :session_token, :presence => true
  validates :password_digest, :presence => { :message => "Password can't be blank"}
  validates :password, :length => { :minimum => 6, :allow_nil => true }

  after_initialize :reset_session_token!

  def self.check_credentials(identity, password)
    if identity.include?("@")
      user = User.find_by_email(identity)
    else
      user = User.find_by_username(identity)
    end

    return nil if user.nil?

    user.verify_password(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def verify_password(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  private
  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(32)
  end
end

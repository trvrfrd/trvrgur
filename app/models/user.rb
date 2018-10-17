require 'bcrypt'

class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :email, :session_token, :presence => true
  validates :username, :email, :uniqueness => true
  validates :password_digest, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }

  after_initialize :ensure_session_token!

  has_many :images,
           :foreign_key => :uploader_id,
           :dependent => :destroy

  has_many :albums,
           :foreign_key => :creator_id,
           :dependent => :destroy

  has_many :comments,
           :foreign_key => :author_id,
           :dependent => :destroy

  has_many :user_album_upvotes, :dependent => :destroy
  has_many :upvoted_albums,
           :through => :user_album_upvotes,
           :source => :album

  has_many :user_album_downvotes, :dependent => :destroy
  has_many :downvoted_albums,
           :through => :user_album_downvotes,
           :source => :album

  has_many :user_comment_upvotes, :dependent => :destroy
  has_many :upvoted_comments,
           :through => :user_comment_upvotes,
           :source => :comments

  has_many :user_comment_downvotes, :dependent => :destroy
  has_many :downvoted_commments,
           :through => :user_comment_downvotes,
           :source => :comments

  has_many :user_album_favorites, :dependent => :destroy
  has_many :favorite_albums, :through => :user_album_favorites, :source => :user

  def self.check_credentials(identity, password)
    if identity.include?("@")
      user = User.find_by_email(identity)
    else
      user = User.find_by_username(identity)
    end

    return nil if user.nil?

    user.verify_password(password) ? user : nil
  end

  def self.digest_password(password)
    BCrypt::Password.create(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  def album_reputation
    return 0 if albums.empty?
    albums.to_a.map(&:points).inject(&:+)
  end

  def comment_reputation
    return 0 if comments.empty?
    comments.to_a.map(&:points).inject(&:+)
  end

  def total_reputation
    album_reputation + comment_reputation
  end

  def password=(password)
    @password = password # we don't want infinite recursion LOL
    self.password_digest = User.digest_password(password)
  end

  def verify_password(password)
    BCrypt::Password.new(password_digest) == password
  end

  def ensure_session_token!
    session_token || reset_session_token!
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
  end
end

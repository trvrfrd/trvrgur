class Album < ActiveRecord::Base
  attr_accessible :description, :title, :user_id
  validates :images, :presence => true

  belongs_to :user
  has_many :images, :dependent => :destroy
end

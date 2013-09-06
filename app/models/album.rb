class Album < ActiveRecord::Base
  attr_accessible :description, :title, :user_id
  validates :images, :presence => true

  belongs_to :creator,
             :class_name => "User",
             :foreign_key => :creator_id
             
  has_many :images, :dependent => :destroy
  has_many :comments, :dependent => :destroy
end

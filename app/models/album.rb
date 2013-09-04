class Album < ActiveRecord::Base
  attr_accessible :description, :title, :user_id

  belongs_to :user
  has_many :images, :dependent => :destroy
end

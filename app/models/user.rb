class User < ApplicationRecord
  before_create :set_default_role
  has_many :posts
  has_many :comments
  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "50x50#" }, 
                             :default_url => "/images/:style/missing.png"
  
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # or 
  # before_validation :set_default_role 

  def liked(comment_type)
    self.voted_for? comment_type 
  end

  private
  def set_default_role
    self.role ||= 'user'
  end
end

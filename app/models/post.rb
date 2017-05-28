class Post < ApplicationRecord
  paginates_per 15
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_votable

  def editable?
    self.created_at > (Time.now - 1.hour)
  end

	def self.search(search, user)
	  where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
	  where("user_id =?", user)
	end
end

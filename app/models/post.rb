class Post < ApplicationRecord
  paginates_per 40
  belongs_to :user
  has_many :comments
  acts_as_votable

  def editable?
    self.created_at > (Time.now - 1.hour)
  end
end

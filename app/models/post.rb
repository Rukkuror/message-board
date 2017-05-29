class Post < ApplicationRecord
  paginates_per 15
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_votable

  scope :search_all, ->(params) { where("(lower(title) LIKE ? or lower(description) LIKE ?) AND (user_id = ?)", "%#{params[:search]}%", "%#{params[:search]}%", params[:user_id])}
  scope :search_post, ->(params) { where("lower(title) LIKE ? or lower(description) LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")}
  scope :search_user, ->(params) { where("user_id = ?", params[:user_id])}
  
  def editable?
    self.created_at > (Time.now - 1.hour)
  end
end

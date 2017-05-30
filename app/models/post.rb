class Post < ApplicationRecord
  paginates_per 15
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_votable
  after_save :update_screenshot

  scope :search_all, ->(params) { where("(title ILIKE ? or description ILIKE ?) AND (user_id = ?)", "%#{params[:search]}%", "%#{params[:search]}%", params[:user_id])}
  scope :search_post, ->(params) { where("title ILIKE ? or description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")}
  scope :search_user, ->(params) { where("user_id = ?", params[:user_id])}
  
  def editable?
    self.created_at > (Time.now - 1.hour)
  end

  def update_screenshot
    Gastly.capture(self.website_url, "app/assets/images/#{self.title.parameterize.underscore}.png") rescue nil
  end
end

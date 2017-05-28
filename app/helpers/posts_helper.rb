module PostsHelper
  def fetch_all_users
    @users = User.all
  end
end

module PostsHelper

  def comments_of(post)
  	post.comments.order(:created_at)
  end
end

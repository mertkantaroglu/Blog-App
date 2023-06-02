class Comment < ApplicationRecord
  belongs_to :author, class_name: :User
  belongs_to :post

  after_create :increase_comment_counter
  after_destroy :decrease_comment_counter

  def increase_comment_counter
    post.increment!(:comments_counter)
  end

  def decrease_comment_counter
    post.decrement!(:comments_counter)
  end
end

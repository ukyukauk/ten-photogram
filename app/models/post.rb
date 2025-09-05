# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
  has_many_attached :images

  validates :images, presence: true

  validates :content, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def display_like_count
    first_liker = likes.includes(:user).order(:created_at).first&.user&.account

    if likes.count == 0
      ""
    elsif likes.count == 1
      "#{first_liker} liked this post"
    else
      other_likes_count = likes.count - 1
      unit = other_likes_count == 1 ? 'other' : 'others'
      "#{first_liker} and #{other_likes_count} #{unit} liked this post"
    end
  end
end

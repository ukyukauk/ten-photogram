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

  def time_ago_display
    diff_seconds = (Time.current - created_at).to_i

    case diff_seconds
    when 0...60
      "just now"
    when 0...1.hour
      minutes = diff_seconds / 60
      unit = minutes == 1 ? "minute" : "minutes"
      "#{minutes} #{unit} ago"
    when 1.hour...1.day
      hours = diff_seconds / 3600
      unit = hours == 1 ? "hour" : "hours"
      "#{hours} #{unit} ago"
    when 1.day...7.days
      days = diff_seconds / (3600 * 24)
      unit = days == 1 ? "day" : "days"
      "#{days} #{unit} ago"
    else
      created_at.strftime("%B %-d")
    end
  end
end

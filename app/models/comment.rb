# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
class Comment < ApplicationRecord

  validates :content, presence: true

  belongs_to :user
  belongs_to :post

  after_commit :notify_mentions, on: :create

  # @XXXXX
  MENTION_REGEX = /(?:^|\s)@([A-Za-z0-9_]+)\b/

  # 本文から @xxx を一意に取り出す
  def mentioned_accounts
    return [] if content.blank?
    content.scan(MENTION_REGEX).flatten.map(&:downcase).uniq
  end

  # 実在ユーザーに絞る + 自分宛てを除外
  def mentioned_users
    return User.none if mentioned_accounts.empty?
    User
      .where('LOWER(account) IN (?)', mentioned_accounts)
      .where.not(id: user_id)
  end

  private
  def notify_mentions
    mentioned_users.find_each do |mentioned|
      MentionMailer.new_mention(mentioned, user, self).deliver_now
    end
  end
end

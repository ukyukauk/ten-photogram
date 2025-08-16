class MentionMailer < ApplicationMailer
  def new_mention(mentioned, mentioner, comment)
    @mentioned = mentioned
    @mentioner = mentioner
    @comment = comment
    @post = comment.post
    mail to: mentioned.email, subject: '【お知らせ】あなた宛てのメンションがあります'
  end
end

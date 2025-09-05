# frozen_string_literal: true

module UserDecorator

  def avatar_image
    if avatar&.attached?
      avatar
    else
      'default-avatar.png'
    end
  end
end

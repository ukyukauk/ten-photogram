class UserSerializer < ActiveModel::Serializer
  attributes :id, :account, :avatar_image

  def avatar_image
    if object.avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true)
    else
      ActionController::Base.helpers.asset_path('default-avatar.png')
    end
  end
end

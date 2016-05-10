class SessionsSerializer < ActiveModel::Serializer
  attributes :email, :token_type, :user_id, :auth_token

  def token_type
   	'Bearer'
  end

  def user_id
    object.id
  end
end

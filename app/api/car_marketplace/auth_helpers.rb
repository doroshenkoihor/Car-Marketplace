module CarMarketplace
  module AuthHelpers
    def current_user
      return nil if headers['Authorization'].nil?

      decoder = Warden::JWTAuth::UserDecoder.new
      decoder.call(token, :user, nil)
    end
  
    def token
      auth = headers['Authorization'].to_s
      auth.split.last
    end

    def authenticate!
      error!('Unauthorized', 401) unless current_user
    end

    def authorize_admin!
      error!('Unauthorized', 401) unless current_user&.admin?
    end
  end
end
class UserRegistrationWithEmailService
  attr_reader :email, :password, :token

  def initialize(email, password)
    @email = email
    @password = password
  end

  def register
    user = User.find_by_email(email) || User.new(email: email, password: password)

    if user.save && user.valid_password?(password)
      @token, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
      user.on_jwt_dispatch(@token, payload)
      # TODO: UserRegistrationJob.perform_later(user.id)
    end

    user
  end
end
class Resolvers::SignInUser < GraphQL::Function
  argument :email, !Types::AuthProviderEmailInput

  type do
    name 'SigninPayload'

    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, ctx)

    return unless (input = args[:email]) &&
                  (user = User.find_by(email: input[:email])) &&
                   user.authenticate(input[:password])

    key = Rails.application.credentials.secret_key_base.byteslice(0..31)
    crypt = ActiveSupport::MessageEncryptor.new(key)
    token = crypt.encrypt_and_sign("user-id:#{ user.id }")
    
    ctx[:session][:token] = token

    OpenStruct.new({
      user: user,
      token: token
    })
  end
end
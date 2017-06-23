class Resolvers::SignInUser < GraphQL::Function
  argument :email, Types::AuthProviderEmailInput

  type do
    name 'SigninPayload'

    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, _ctx)
    return unless args[:email]

    email = args[:email][:email]

    user = User.find_by email: email

    return unless user

    {
      user: user,
      token: SecureRandom.uuid
    }
  end
end

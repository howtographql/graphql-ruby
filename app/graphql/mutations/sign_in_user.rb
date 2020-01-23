module Mutations
  class SignInUser < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      return unless credentials

      user = User.find_by email: credentials[:email]

      return unless user
      return unless user.authenticate(credentials[:password])

      token = AuthToken.token_for_user(user)

      context[:session][:token] = token

      { user: user, token: token }
    end
  end
end

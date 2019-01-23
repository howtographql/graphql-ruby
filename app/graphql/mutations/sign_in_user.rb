module Mutations
  class SignInUser < BaseMutation
    null true

    argument :email, Types::AuthProviderEmailInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email: nil)
      return unless email

      user = User.find_by email: email[:email]

      return unless user
      return unless user.authenticate(email[:password])

      token = AuthToken.token_for_user(user)

      context[:session][:token] = token

      { user: user, token: token }
    end
  end
end

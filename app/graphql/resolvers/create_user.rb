class Resolvers::CreateUser < GraphQL::Function
  AuthProviderInput = GraphQL::InputObjectType.define do
    name 'AuthProviderSignupData'

    argument :email, Types::AuthProviderEmailInput
  end

  argument :name, !types.String
  argument :authProvider, AuthProviderInput

  type Types::UserType

  def call(_obj, args, _ctx)
    User.create!(
      name: args[:name],
      email: args[:authProvider]&.[](:email)&.[](:email),
      password: args[:authProvider]&.[](:email)&.[](:password)
    )
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end

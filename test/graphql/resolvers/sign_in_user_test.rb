require 'test_helper'

class Resolvers::SignInUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::SignInUser.new.call(nil, args, session: {})
  end

  test 'success' do
    user = create :user

    result = perform(
      email: {
        email: user.email,
        password: user.password
      }
    )

    assert result.present?
    assert result.token.present?
    assert_equal result.user, user
  end

  test 'failure because no credentials' do
    assert_nil perform
  end

  test 'failure because wrong email' do
    create :user
    assert_nil perform(email: { email: 'wrong' })
  end

  test 'failure because wrong password' do
    user = create :user
    assert_nil perform(email: { email: user.email, password: 'wrong' })
  end
end

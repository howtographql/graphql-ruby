require 'test_helper'

class Mutations::SignInUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::SignInUser.new(object: nil, context: { session: {} }).resolve(args)
  end

  test 'success' do
    user = create :user

    result = perform(
      email: {
        email: user.email,
        password: user.password
      }
    )

    assert result[:token].present?
    assert_equal result[:user], user
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

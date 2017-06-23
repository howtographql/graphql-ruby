require 'test_helper'

class Resolvers::SignInUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::SignInUser.new.call(nil, args, nil)
  end

  test 'success' do
    user = create :user

    result = perform(
      email: {
        email: user.email,
        password: '[omitted]'
      }
    )

    assert result.present?
    assert result[:token].present?
    assert_equal result[:user], user
  end

  test 'failure' do
    assert_nil perform
  end
end

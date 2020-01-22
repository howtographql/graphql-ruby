require 'test_helper'

class Mutations::CreateLinkTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    Mutations::CreateLink.new(object: nil, field: nil, context: { current_user: user }).resolve(args)
  end

  test 'success' do
    user = create :user

    link = perform(
      url: 'http://example.com',
      description: 'description',
      user: user
    )

    assert link.persisted?
    assert_equal link.description, 'description'
    assert_equal link.url, 'http://example.com'
    assert_equal link.user, user
  end

  test 'failure' do
    assert perform.is_a? GraphQL::ExecutionError
  end
end

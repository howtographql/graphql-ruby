require 'test_helper'

class Resolvers::CreateLinkTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateLink.new.call(nil, args, nil)
  end

  def record_id(record)
    GraphqlSchema.id_from_object(record, nil, nil)
  end

  test 'success' do
    user = create :user

    link = perform(
      url: 'http://example.com',
      description: 'description',
      postedById: record_id(user)
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

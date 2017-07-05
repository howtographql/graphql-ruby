require 'test_helper'

class Resolvers::CreateVoteTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    Resolvers::CreateVote.new.call(nil, args, current_user: user)
  end

  def record_id(record)
    GraphqlTutorialSchema.id_from_object(record, nil, nil)
  end

  test 'success' do
    user = create :user
    link = create :link

    vote = perform(
      user: user,
      linkId: record_id(link)
    )

    assert vote.persisted?
    assert_equal vote.user, user
    assert_equal vote.link, link
  end

  test 'failure' do
    assert perform.is_a? GraphQL::ExecutionError
  end
end

require 'test_helper'

class Mutations::CreateVoteTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    Mutations::CreateVote.new(object: nil, field: nil, context: { current_user: user }).resolve(args)
  end

  def record_id(record)
    GraphqlTutorialSchema.id_from_object(record, nil, nil)
  end

  test 'success' do
    user = create :user
    link = create :link

    vote = perform(
      user: user,
      link_id: record_id(link)
    )

    assert vote.persisted?
    assert_equal vote.user, user
    assert_equal vote.link, link
  end

  test 'failure' do
    assert perform.is_a? GraphQL::ExecutionError
  end
end

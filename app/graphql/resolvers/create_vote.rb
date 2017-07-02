class Resolvers::CreateVote < GraphQL::Function
  argument :linkId, types.ID

  type Types::VoteType

  def call(_obj, args, ctx)
    Vote.create!(
      link: GraphqlSchema.object_from_id(args[:linkId], ctx),
      user: ctx[:current_user]
    )
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end

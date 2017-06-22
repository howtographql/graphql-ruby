class Resolvers::CreateLink < GraphQL::Function
  argument :description, !types.String
  argument :url, !types.String
  argument :postedById, types.ID

  type Types::LinkType

  def call(_obj, args, ctx)
    Link.create!(
      description: args[:description],
      url: args[:url],
      user: GraphqlSchema.object_from_id(args[:postedById], ctx)
    )
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end

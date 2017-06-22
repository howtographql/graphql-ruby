Types::LinkType = GraphQL::ObjectType.define do
  name 'Link'

  interfaces [GraphQL::Relay::Node.interface]

  global_id_field :id

  field :createdAt, !Types::DateTimeType, property: :created_at
  field :url, !types.String
  field :description, !types.String
  field :postedBy, -> { Types::UserType }, property: :user
  field :votes, -> { !types[Types::VoteType] }
end

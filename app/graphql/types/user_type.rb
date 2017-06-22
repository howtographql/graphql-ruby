Types::UserType = GraphQL::ObjectType.define do
  name 'User'

  interfaces [GraphQL::Relay::Node.interface]

  global_id_field :id

  field :createdAt, !Types::DateTimeType, property: :created_at
  field :name, !types.String
  field :email, !types.String
  field :votes, -> { !types[Types::VoteType] }
  field :links, -> { !types[Types::LinkType] }
end

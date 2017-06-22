Types::VoteType = GraphQL::ObjectType.define do
  name 'Vote'

  interfaces [GraphQL::Relay::Node.interface]

  global_id_field :id

  field :createdAt, !Types::DateTimeType, property: :created_at
  field :user, -> { Types::UserType }
  field :link, -> { Types::LinkType }
end

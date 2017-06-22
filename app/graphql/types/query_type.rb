Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :node, GraphQL::Relay::Node.field

  field :allLinks, function: Resolvers::LinksSearch
  field :_allLinksMeta, Types::QueryMetaType do
    resolve ->(_obj, _args, _ctx) { Link.count }
  end
end

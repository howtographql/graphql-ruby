module Types
  class QueryType < BaseObject
    field :node, field: GraphQL::Relay::Node.field
    field :nodes, field: GraphQL::Relay::Node.plural_field

    field :all_links, function: Resolvers::LinksSearch
    field :_all_links_meta, QueryMetaType, null: false

    def _all_links_meta
      Link.count
    end
  end
end

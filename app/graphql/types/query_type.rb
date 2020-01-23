module Types
  class QueryType < BaseObject
    add_field GraphQL::Types::Relay::NodeField
    add_field GraphQL::Types::Relay::NodesField

    field :all_links, function: Resolvers::LinksSearch
    field :_all_links_meta, QueryMetaType, null: false

    def _all_links_meta
      Link.count
    end
  end
end

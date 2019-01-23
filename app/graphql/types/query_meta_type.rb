module Types
  class QueryMetaType < BaseObject
    graphql_name '_QueryMeta'

    field :count, Int, null: false

    def count
      object
    end
  end
end

Types::QueryMetaType = GraphQL::ObjectType.define do
  name '_QueryMeta'

  field :count, !types.Int do
    resolve ->(obj, _args, _ctx) { obj }
  end
end

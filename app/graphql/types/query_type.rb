Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :testField, types.String do
    description 'An example field added by the generator'
    resolve ->(_obj, _args, _ctx) { 'Hello World!' }
  end
end

require 'search_object/plugin/graphql'

class Resolvers::LinksSearch
  include SearchObject.module(:graphql)

  scope { Link.all }

  type !types[Types::LinkType]

  OrderEnum = GraphQL::EnumType.define do
    name 'LinkOrderBy'

    value 'createdAt_ASC'
    value 'createdAt_DESC'
  end

  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip
  option :orderBy, type: OrderEnum, default: 'createdAt_DESC'

  def apply_first(scope, value)
    scope.limit(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end

  def apply_orderBy_with_created_at_asc(scope) # rubocop:disable Style/MethodName
    scope.order('created_at ASC')
  end

  def apply_orderBy_with_created_at_desc(scope) # rubocop:disable Style/MethodName
    scope.order('created_at DESC')
  end
end

require 'search_object/plugin/graphql'
require 'graphql/query_resolver'

class Resolvers::LinksSearch
  include SearchObject.module(:graphql)

  scope { Link.all }

  type !types[Types::LinkType]

  LinkFilter = GraphQL::InputObjectType.define do
    name 'LinkFilter'

    argument :OR, -> { types[LinkFilter] }
    argument :description_contains, types.String
    argument :url_contains, types.String
  end

  OrderEnum = GraphQL::EnumType.define do
    name 'LinkOrderBy'

    value 'createdAt_ASC'
    value 'createdAt_DESC'
  end

  option :filter, type: LinkFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip
  option :orderBy, type: OrderEnum, default: 'createdAt_DESC'

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    scope = Link.all
    scope = scope.like(:description, value['description_contains']) if value['description_contains']
    scope = scope.like(:url, value['url_contains']) if value['url_contains']

    branches << scope

    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end

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

  def fetch_results
    # NOTE: Don't run QueryResolver during tests
    return super unless context.present?

    GraphQL::QueryResolver.run(Link, context, Types::LinkType) do
      super
    end
  end
end

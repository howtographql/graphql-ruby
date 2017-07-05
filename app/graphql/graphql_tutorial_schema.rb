GraphqlTutorialSchema = GraphQL::Schema.define do
  query Types::QueryType
  mutation Types::MutationType

  id_from_object lambda { |object, _definition, _ctx|
    GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
  }

  object_from_id lambda { |id, _ctx|
    return unless id.present?
    record_class_name, record_id = GraphQL::Schema::UniqueWithinType.decode(id)
    record_class = record_class_name.safe_constantize
    record_class&.find_by id: record_id
  }

  resolve_type lambda { |obj, _ctx|
    type = "::Types::#{obj.class}Type".safe_constantize
    return type if type.present?

    raise ArgumentError, "Cannot resolve type for class #{obj.class.name}"
  }
end

module Types
  class BaseNode < BaseObject
    implements GraphQL::Relay::Node.interface

    global_id_field :id
  end
end

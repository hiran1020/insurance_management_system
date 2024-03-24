
module Types
  class RoleEnumType < GraphQL::Schema::Enum
    value "admin"
    value "agent"
    value "client"
  end
end

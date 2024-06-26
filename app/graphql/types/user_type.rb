# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :role, RoleEnumType, null:false
    field :first_name, String, null: false
    field :middle_name, String, null: false
    field :last_name, String, null: false
    field :citizenship_number, String, null: false
    field :permanent_address, String, null: false
    field :temporary_address, String, null: false
    field :contact_number, String, null: false
    field :encrypted_password, String, null: false
    field :reset_password_token, String
    field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime
    field :remember_created_at, GraphQL::Types::ISO8601DateTime
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

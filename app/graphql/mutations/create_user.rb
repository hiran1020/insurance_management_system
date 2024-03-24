# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation

    argument :email, String, required: true
    argument :password, String, required: true
    argument :role, Types::RoleEnumType, required: true
    argument :first_name, String, required: true
    argument :middle_name, String, required: false
    argument :last_name, String, required: true
    argument :citizenship_number, String, required: true
    argument :permanent_address, String, required: false
    argument :temporary_address, String, required: false
    argument :contact_number, String, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false
    field :message, String, null: false
    
    def resolve(email:, password:, role:, first_name:, middle_name:, last_name:, citizenship_number:, permanent_address:, temporary_address:, contact_number:)
      user = User.new(
        email: email,
        password: password,
        role: role,
        first_name: first_name,
        middle_name: middle_name,
        last_name: last_name,
        citizenship_number: citizenship_number,
        permanent_address: permanent_address,
        temporary_address: temporary_address,
        contact_number: contact_number
      )

      if user.save
        { user: user, errors: [], message: 'User created successfully'}
      else
        # Return an error response
        { user: nil,  errors: format_errors(user.errors)}
        
      end
    end
     
    
    
  private

    def format_errors(errors)
      errors.map do |attribute, message|
        "#{attribute.to_s.capitalize} #{message}"
      end
    end
  end
end

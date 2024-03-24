# app/graphql/mutations/login_user.rb
module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true
    field :message, String, null: true
    field :errors, [String], null: true

    def resolve(email:, password:)
      user = User.find_for_database_authentication(email: email)
     if user && user.valid_password?(password)
        token = user.generate_jwt
        {
          user: user,
          token: token,
          message: 'Login successful',
          errors: []
        }
      else
        {
          user: nil,
          token: nil,
          message: 'Invalid email or password',
          errors: ['Invalid email or password']
        }
      end
    end
  end
end

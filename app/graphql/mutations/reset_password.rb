# app/graphql/mutations/reset_password.rb
module Mutations
  class ResetPassword < BaseMutation
    argument :email, String, required: true
    argument :newPassword, String, required: true
    argument :passwordConfirmation, String, required: true

    field :message, String, null: true
    field :errors, [String], null: true

    def resolve(email:, newPassword:, passwordConfirmation:)
      user = User.find_by(email: email)
      if user
        if newPassword == passwordConfirmation
          user.update(password: newPassword, password_confirmation: passwordConfirmation)

          { message: 'Reset password Successfully', errors: [] }
        else
          { message: nil, errors: ['Password confirmation does not match'] }
        end
      else
        { message: nil, errors: ['User not found'] }
      end
    end
  end
end

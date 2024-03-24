# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def create
    super do |resource|
      # Add custom logic here
      Rails.logger.info "#{resource.email} signed in at #{Time.zone.now}"
    end
  end
end

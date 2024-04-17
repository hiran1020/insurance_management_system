require 'csv'

module Mutations
  class ImportUsers < BaseMutation
    argument :file, GraphQL::Types::String, required: true

    field :success, Boolean, null: false
    field :error, String, null: true
    field :imported_users, [Types::UserType], null: true
    field :failed_users, [Types::FailedType], null: true

    DEFAULT_PASSWORD = 'password'.freeze

    def resolve(file:)
      begin
        csv = CSV.parse(file, headers: true)
      


        imported_users = []
        failed_users = []

        ActiveRecord::Base.transaction do
          csv.each_with_index do |row, index|
            empty_fields = []

            # Check each field for emptiness
            row.each_with_index do |field_value, field_index|
              empty_fields << field_index if field_value.blank?
            end

            if empty_fields.empty?
              user = create_user(row)

              if user.save
                imported_users << user
               
              else
                failed_users << { name: "#{row[2]} #{row[4]}", email: row[0], error: user.errors.full_messages.join(', ') }
                
              end
            else
              failed_users << { row_index: index, error: "Fields #{empty_fields.join(', ')} are empty" }
            end
          end
        end

        { success: true, imported_users: imported_users, failed_users: failed_users }
      rescue CSV::MalformedCSVError
        { success: false, error: 'CSV Format Error', error_message: 'The CSV file is malformed.' }
      rescue StandardError => e
        { success: false, error: e.class.name, error_message: e.message }
      end
    end

    private

    def create_user(row)
      User.new(
        email: row_column_data(row, :email),
        password: DEFAULT_PASSWORD,
        role: row_column_data(row, :role),
        first_name: row_column_data(row, :first_name),
        middle_name: row_column_data(row, :middle_name),
        last_name: row_column_data(row, :last_name),
        citizenship_number: row_column_data(row, :citizenship_number),
        permanent_address: row_column_data(row, :permanent_address),
        temporary_address: row_column_data(row, :temporary_address),
        contact_number: row_column_data(row, :contact_number)
      )
    end

    def row_column_data(row, column)
      row[headers[column]]
    end

    def headers
      {
        email: 0,
        role: 1,
        first_name: 2,
        middle_name: 3,
        last_name: 4,
        citizenship_number: 5,
        permanent_address: 6,
        temporary_address: 7,
        contact_number: 8
      }
    end
  end
end

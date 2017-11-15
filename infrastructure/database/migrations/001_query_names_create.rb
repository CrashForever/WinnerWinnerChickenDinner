# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:queryNames) do
      primary_key :id
      String      :query_name, unique: false, null: false
      foreign_key :queryResults_id, :queryResults

      DateTime :created_at
      DateTime :updated_at
    end
  end
end

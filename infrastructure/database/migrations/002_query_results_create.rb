# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:queryResults) do
      primary_key :id
      String      :video_id, unique: true, null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end

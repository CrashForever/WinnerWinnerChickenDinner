# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:query_Name_Results) do
      foreign_key :queryNames_id, :queryNames
      foreign_key :queryResults_id, :queryResults
      primary_key [:queryNames_id, :queryResults_id]
      index [:queryNames_id, :queryResults_id]
    end
  end
end

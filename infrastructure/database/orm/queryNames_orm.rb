# frozen_string_literal: true

module VideosPraise
  module Database
    # Object Relational Mapper for Repo Entities
    class QueryNamesOrm < Sequel::Model(:queryNames)
      one_to_one :queryResults,
                  class: :'VideosPraise::Database::QueryResultsOrm'
      plugin :timestamps, update_on_create: true
    end
  end
end

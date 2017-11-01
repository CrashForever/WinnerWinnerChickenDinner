# frozen_string_literal: true

module VideosPraise
  module Database
    # Object-Relational Mapper for Collaborators
    class QueryResultsOrm < Sequel::Model(:queryResults)
      one_to_one :queryNames,
                  class: :'CodePraise::Database::QueryNamesOrm'
      plugin :timestamps, update_on_create: true
    end
  end
end

# frozen_string_literal: true

module VideosPraise
  module Repository
    For = {
      Entity::QueryName => QueryNames,
      Entity::QueryResult => QueryResults,
      Entity::QueryNumber => QueryNumbers,
      Entity::VideoContent => QueryResults
    }.freeze
  end
end

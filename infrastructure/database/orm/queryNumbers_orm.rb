# frozen_string_literal: true

module VideosPraise
  module Database
    # Object Relational Mapper for Repo Entities
    class QueryNumbersOrm < Sequel::Model(:queryNumbers)

      plugin :timestamps, update_on_create: true
    end
  end
end

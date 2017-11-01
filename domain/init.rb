# frozen_string_literal: true

folders = %w[entities database_repositories mappers]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end

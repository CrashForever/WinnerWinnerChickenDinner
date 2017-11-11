# frozen_string_literal: true

folders = %w[values entities database_repositories mappers]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end

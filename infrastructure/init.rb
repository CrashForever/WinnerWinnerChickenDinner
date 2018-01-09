# frozen_string_literal: false

folders = %w[database/orm youtube edamam google_vision messaging]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end

require 'rake/testtask'

desc 'run tests'
Rake::TestTask.new(:spec) do |t|
    t.pattern = 'spec/*_spec.rb'
    t.warning = false
end

namespace :quality do

  desc 'run flog'
  task :flog do
    sh 'flog lib/'
  end

  desc 'run reek'
  task :reek do
    sh 'reek lib/'
  end

  desc 'run rubocop'
  task :rubocop do
    sh 'rubocop'
  end
end

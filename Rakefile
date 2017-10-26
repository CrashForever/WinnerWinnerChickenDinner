desc 'run tests'
task :spec do
  sh 'ruby spec/video_spec.rb'
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

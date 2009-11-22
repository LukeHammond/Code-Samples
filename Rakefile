require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => [:clean_files, :test]

desc 'Remove the last test file'
task :clean_files do
  `rm -f #{File.dirname(__FILE__)}/test/test_output.txt`
  `rm -f #{File.dirname(__FILE__)}/demo_output_files/gender_and_last_name.txt`
  `rm -f #{File.dirname(__FILE__)}/demo_output_files/date_of_birth.txt`
  `rm -f #{File.dirname(__FILE__)}/demo_output_files/last_name_desc.txt`
end

desc 'Test parser_project.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for parser_project.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Demographic Output Generator'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Demo parser_project.'
task :demo => :clean_files do
  require "#{File.dirname(__FILE__)}/lib/person.rb"
  require "#{File.dirname(__FILE__)}/lib/parser.rb"
  require "#{File.dirname(__FILE__)}/lib/populator.rb"

  data = Populator.new

  space_parser = Parser.new ' ', :last_name, :first_name, :middle_initial, :gender, :dob, :favorite_color
  File.open('data_files/space.txt') do |f|
    data.populate space_parser, f
  end

  pipe_parser = Parser.new ' | ', :last_name, :first_name, :middle_initial, :gender, :favorite_color, :dob
  File.open('data_files/pipe.txt') do |f|
    data.populate pipe_parser, f
  end

  comma_parser = Parser.new ', ', :last_name, :first_name, :gender, :favorite_color, :dob
  File.open('data_files/comma.txt') do |f|
    data.populate comma_parser, f
  end

  data.sort_by :gender, :last_name
  File.open('demo_output_files/gender_and_last_name.txt', 'w') do |f|
    data.records.each{|person| f << "#{person.to_s}\n" }
  end

  data.sort_by :dob, :last_name
  File.open('demo_output_files/date_of_birth.txt', 'w') do |f|
    data.records.each{|person| f << "#{person.to_s}\n" }
  end

  data.sort_by :last_name
  File.open('demo_output_files/last_name_desc.txt', 'w') do |f|
    data.records.reverse.each{|person| f << "#{person.to_s}\n" }
  end
end


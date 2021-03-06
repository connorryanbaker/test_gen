dir_name = "/practice_test"
iteration = 2
# make sure we're not writing to a directory that already exists
until !File.directory?(Dir.pwd + dir_name)
    dir_name = dir_name.split("-")[0] + "-#{iteration.to_s}"
    iteration += 1
end

# process command line arg if any

how_many = ARGV.any? ? ARGV[0].to_i : 5
return if !how_many.between?(1,42)

#create lib/spec directories and Gemfile
Dir.mkdir(Dir.pwd + dir_name)
Dir.mkdir(Dir.pwd + dir_name + "/lib")
File.open(Dir.pwd + dir_name +"/lib/test.rb", "w") do |f|
    f.write("# this is a randomly generated practice test :p\n")
    f.write("\n")
end 
Dir.mkdir(Dir.pwd + dir_name + "/spec")
File.open(Dir.pwd + dir_name +"/spec/test_spec.rb", "w") do |f|
    f.write("require 'test'\n")
end
File.open(Dir.pwd + dir_name + "/Gemfile", "w") do |f|
    f.write('source "https://rubygems.org"')
    f.write("\n")
    f.write('gem "rspec"')
end 

#now, we generate range of numbers 0 ... problems.length, convert it to an array and shuffle it
#to pick random problems. how_many stores argv / default of 5 problems
#
random_idxs = (0...42).to_a.shuffle.take(how_many)
problems_directory = Dir.new(Dir.pwd + "/problems")
problems = problems_directory.select {|f| !File.directory?(f)}.sort
my_problems = []
problems.each.with_index do |file, idx|
    if random_idxs.include?(idx)
      my_problems << file
        File.open(Dir.pwd + "/problems/" + file, 'rb') do |input|
            File.open(Dir.pwd + dir_name + "/lib/test.rb", "a") do |output|
                IO.copy_stream(input, output)
                output.write("\n")
            end 
        end 
    end 
end 

my_problems.map! {|str| str.gsub(/\.rb/, "")}

specs_directory = Dir.new(Dir.pwd + "/specs")
specs = specs_directory.select {|f| !File.directory?(f)}.sort 

specs.each.with_index do |file, idx|
    if my_problems.any? {|str| file[0..-9] == (str)}
        File.open(Dir.pwd + "/specs/" + file, 'rb') do |input|
            File.open(Dir.pwd + dir_name +"/spec/test_spec.rb", "a") do |output|
                IO.copy_stream(input, output)
                output.write("\n")
            end 
        end 
    end 
end 

dir_name = "/practice_test"
iteration = 2
# make sure we're not writing to a directory that already exists
until !File.directory?(Dir.pwd + dir_name)
    dir_name = dir_name.split("_")[0] + "_#{iteration.to_s}"
    iteration += 1
end


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
#to pick 5 random problems
random_5_idxs = (0...43).to_a.shuffle.take(5)
problems_directory = Dir.new(Dir.pwd + "/problems")
problems = problems_directory.select {|f| !File.directory?(f)}.sort

problems.each.with_index do |file, idx|
    if random_5_idxs.include?(idx)
        File.open(Dir.pwd + "/problems/" + file, 'rb') do |input|
            File.open(Dir.pwd + dir_name + "/lib/test.rb", "a") do |output|
                IO.copy_stream(input, output)
                output.write("\n")
            end 
        end 
    end 
end 

specs_directory = Dir.new(Dir.pwd + "/specs")
specs = specs_directory.select {|f| !File.directory?(f)}.sort 

specs.each.with_index do |file, idx|
    if random_5_idxs.include?(idx)
        File.open(Dir.pwd + "/specs/" + file, 'rb') do |input|
            File.open(Dir.pwd + dir_name +"/spec/test_spec.rb", "a") do |output|
                IO.copy_stream(input, output)
                output.write("\n")
            end 
        end 
    end 
end 

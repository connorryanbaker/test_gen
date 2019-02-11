class TestGenerator
    attr_reader :problem_count
    def initialize(problem_count)
        @problem_count = problem_count
        @dir_name = "/practice_test"
    end

    def run 
    end

    private
    
    def make_main_dir
        until !File.directory?(Dir.pwd + dir_name)
            self.dir_name = dir_name.split("-")[0] + "-#{iteration.to_s}"
            iteration += 1
        end
        Dir.mkdir(Dir.pwd + dir_name)
    end

    def write_gemfile
        File.open(Dir.pwd + dir_name + "/Gemfile", "w") do |f|
            f.write('source "https://rubygems.org"')
            f.write("\n")
            f.write('gem "rspec"')
        end 
    end

    def make_lib_dir
        Dir.mkdir(Dir.pwd + dir_name + "/lib")
        File.open(Dir.pwd + dir_name +"/lib/test.rb", "w") do |f|
            f.write("# this is a randomly generated practice test :p\n")
            f.write("\n")
        end 
    end

    def make_spec_dir
        Dir.mkdir(Dir.pwd + dir_name + "/spec")
        File.open(Dir.pwd + dir_name +"/spec/test_spec.rb", "w") do |f|
            f.write("require 'test'\n")
        end
    end

    def choose_problems
        random_idxs = (0...42).to_a.shuffle.take(problem_count)
        problems_directory = Dir.new(Dir.pwd + "/problems")
        problems = problems_directory.select {|f| !File.directory?(f)}.sort
        problems 
    end
    
    def write_problems_to_file
        @my_problems = []
        choose_problems.each.with_index do |file, idx|
        if random_idxs.include?(idx)
        my_problems << file
        File.open(Dir.pwd + "/problems/" + file, 'rb') do |input|
            File.open(Dir.pwd + dir_name + "/lib/test.rb", "a") do |output|
                IO.copy_stream(input, output)
                output.write("\n")
            end 
        end 
        my_problems.map! {|str| str.gsub(/\.rb/, "")}
    end 

    def match_specs
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
    end
    attr_accessor :dir_name, :my_problems
end

if $PROGRAM_NAME == __FILE__
    how_many = ARGV.any? ? ARGV[0].to_i : 5
    return if !how_many.between?(1,42)
    TestGenerator.new(how_many).run
end
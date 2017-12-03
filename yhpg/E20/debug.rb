require 'pry'
require_relative './main.rb'
searcher = Solver::Searcher.new(nil, nil)
searcher.step?([4, 2], [4, 1], {})

binding.pry
puts 1

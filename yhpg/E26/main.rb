require 'json'
require_relative 'solver.rb'

data = JSON.parse(File.read('test.json'))
test_data = data['test_data']
test_data.each do |e|
  ans = Solver.new(e).solve
  puts ans
end

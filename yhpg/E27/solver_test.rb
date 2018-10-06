require 'pry'
require_relative './solver.rb'

cards = [
  Solver::Card.new(3,2),
  Solver::Card.new(4,2),
  Solver::Card.new(2,1),
  Solver::Card.new(1,2),
  Solver::Card.new(2,2),
  Solver::Card.new(1,1),
  Solver::Card.new(0,2),
  Solver::Card.new(0,1)
]

tmp = Solver.new.send(:sequence?, 5, cards)
binding.pry
puts tmp

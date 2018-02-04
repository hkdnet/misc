require 'pry'
require_relative './solver.rb'

players = [
  Russian::Player.new(1, 3, true),
  Russian::Player.new(2, 4, false),
  Russian::Player.new(3, 4, true),
  Russian::Player.new(4, 3, false),
]
revolvers = [
  Russian::Revolver.new("1000100"),
]
p Russian.new(
  players: players,
  revolvers: revolvers
).exec

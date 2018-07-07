require_relative 'solver'

solver = Solver.new

s = [0, 3]
v = [0, -3]
p solver.points(s, v)

s = [3, 3]
v = [-1, 2]
p solver.points(s, v)

solver.instance_variable_set("@w", 2)
solver.instance_variable_set("@h", 3)

p solver.valid?([2, 3])
p solver.valid?([1, 3])

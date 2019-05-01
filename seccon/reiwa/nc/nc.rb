require 'open3'

stdin, stdout, stderr, wait_thr = *Open3.popen3("nc zerois-o-reiwa.seccon.jp 23615")

def solve(q)
  n = 0
  loop do
    a = eval(q.gsub('?', n.to_s))
    return n if a == 0
    a = eval(q.gsub('?', (-n).to_s))
    return -n if a == 0
    n+= 1
  end
end

loop do
  puts stdout.gets.chomp
  puts '='
  t = stdout.gets.chomp
  puts t
  puts '=='
  print stdout.getc
  print stdout.getc

  q = t.split('=')[1]
  n = solve(q)
  stdin.puts(n)
  puts n
  puts '===='
end

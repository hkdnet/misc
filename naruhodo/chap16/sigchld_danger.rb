# このプログラムはSIGCHLDをトラップしそこねる可能性があるのであまり安全ではない
child_processes = 3
dead_processes = 0

child_processes.times do
  fork do
    puts "#{Process.pid} START"
    sleep 3
  end
end

trap(:CHLD) do
  puts "#{Process.wait} END"
  dead_processes += 1
  exit 0 if dead_processes == child_processes
end

loop do
  puts Math.sqrt(rand(44))**8
  sleep 1
end

child_processes = 3
dead_processes = 0

child_processes.times do |i|
  fork do
    puts "#{Process.pid} START"
    sleep 3 + i
  end
end

$stdout.sync = true

trap(:CHLD) do
  begin
    while pid = Process.wait(-1, Process::WNOHANG)
      puts "#{pid} END"
      dead_processes += 1
    end
  rescue Errno::ECHILD
    if dead_processes == child_processes
      exit 0
    else
      STDERR.puts 'よくわからんエラー'
      exit 1
    end
  end
end

loop do
  puts Math.sqrt(rand(44))**8
  sleep 0.8
end

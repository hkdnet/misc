puts Process.pid
puts Process.getpgrp
fork do
  puts Process.pid
  puts Process.getpgrp
end

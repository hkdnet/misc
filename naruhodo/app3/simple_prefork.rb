require 'socket'

port = 8080
socket = TCPServer.open('0.0.0.0', port)
puts "listen localhost:#{port}"
root_pid = Process.pid

# initialize app

# wpidsの初期化はこっちじゃないとダメ
wpids = []
[:INT, :QUIT].each do |signal|
  trap(signal) do
    wpids.each do |wpid|
      p "#{wpid} | #{signal}"
      # signal送ったあと終了しないけどなんでやろ……
      Process.kill(signal, wpid)
    end
  end
end

5.times do
  wpids << fork do
    loop do
      connection = socket.accept
      connection.puts "Hello Readers! by #{Process.pid}"
      connection.close
    end
  end
end

Process.waitall if Process.pid == root_pid

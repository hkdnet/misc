reader, writer = IO.pipe

fork do
  reader.close unless reader.closed?
  10.times do
    writer.puts "#{Process.pid}: Another one bites the dust"
  end
end

writer.close
while message = reader.gets
  puts message
end

reader, writer = IO.pipe
writer.write("Into the pipe I go...\n")
puts reader.readline
writer.close
reader.close

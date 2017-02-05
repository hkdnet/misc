n = 32
args = (1..n).map { |e| "a#{e}" }
# args += (1..n).map { |e| "b#{e} = #{e}" }
str = <<-EOS
def foo(#{args.join(', ')})
  puts true
end
foo(*Array.new(#{n}))
EOS

File.write('main.rb', str)

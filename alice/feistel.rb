input   = "1001011110110010".freeze
sub_key = "10101101"

class Feistel
  def initialize(count)
    @count = count
    @sub_keys = []
  end

  def crypt(input)
    input = " #{input}" if input.odd?
    
  end

  private

  def split_two(text)
    len = text.length
    half = len / 2
    left = text[0, half]
    right = text[half, half]
    [left, right]
  end
end

def split_two(text)
  len = text.length
  half = len / 2
  left = text[0, half]
  right = text[half, half]
  [left, right]
end

def exec_round(text, sub_key)
  left, right = split_two(text)
  ret = yield(right, sub_key)
  il = left.to_i(2)
  ir = ret.to_i(2)
  new_left = (il ^ ir).to_s(2)
  "#{new_left}#{right}"
end

done = exec_round(input.dup, sub_key) do |r, s|
  (r.to_i(2) ^ s.to_i(2)).to_s(2)
end

done.freeze
puts "sub_key: #{sub_key}"
puts "input  : #{input}"
puts "-" * 20
puts "done   : #{done}"
output = exec_round(done.dup, sub_key) do |r, s|
  (r.to_i(2) ^ s.to_i(2)).to_s(2)
end
puts "output : #{output}"
puts "input  : #{input}"

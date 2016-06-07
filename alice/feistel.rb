class PlainText
  attr_accessor :text

  def initialize(text)
    @text = text
  end

  def to_binary
    @text.unpack("b*").first
  end

  def self.from_binary(bin)
    PlainText.new([bin].pack('b*'))
  end

  def to_s
    "#{@text}\t(#{to_binary})"
  end
end

class Feistel
  def initialize(count)
    @count = count
    @sub_keys = []
  end

  def crypt(pt)
    bin = pt.to_binary
    bin = "0#{bin}" if bin.length.odd?
    if @sub_keys.empty?
      @count.times do
        @sub_keys.push((0...(bin.length / 2)).map { [0, 1].sample }.join(''))
      end
    end
    bin.freeze
    crypted = bin.dup
    crypted_bin = @sub_keys.reduce(crypted) do |text, sub_key|
      tmp = exec_round(text, sub_key) do |right, sk|
        r = right.to_i(2)
        s = sk.to_i(2)
        (r ^ s).to_s(2)
      end
      split_two(tmp).tap { |arr| break "#{arr[1]}#{arr[0]}" }
    end
    PlainText.from_binary(crypted_bin)
  end

  def exec_round(text, sub_key)
    left, right = split_two(text)
    ret = yield(right, sub_key)
    il = left.to_i(2)
    ir = ret.to_i(2)
    new_left = (il ^ ir).to_s(2)
    new_left = '0' + new_left while new_left.length < right.length
    "#{new_left}#{right}"
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

f = Feistel.new(3)
pt = PlainText.new("Hello, world")
puts "plain    : #{pt}"
crypted = f.crypt(pt)
puts "crypted  : #{crypted}"
decrypted = f.crypt(crypted)
puts "decrypted: #{decrypted}"

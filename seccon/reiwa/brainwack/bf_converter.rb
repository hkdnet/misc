t = File.read('flag.bw')
h = {
  '令' => '>',
  '和' => '+',
  '平' => '<',
  '成' => '-',
  '。' => '.',
  '「' => '[',
  '」' => ']',
}
h.each do |k, v|
  t.gsub!(k, v)
end

puts t

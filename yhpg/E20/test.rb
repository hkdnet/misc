require 'pry'
require_relative './main.rb'

ng_c = 0
lines = DATA.read.split("\n")
lines.each.with_index(1) do |line, idx|
  _, input, expected = line.match(/"(.+)","(.+)"/).to_a
  solver = Solver.new
  actual = solver.solve(input)
  if actual != expected
    binding.pry
    ng_c += 1
    puts "#{idx}"
    puts "actual  : #{actual}"
    puts "expected: #{expected}"
  end
end
puts "NG: #{ng_c}"

__END__
"DE","13"
"EK","1"
"01","1"
"LG","2"
"A1","4"
"GJ","4"
"FK","4"
"LV","4"
"27","4"
"0O","4"
"G1","5"
"ZH","5"
"AB","5"
"KX","5"
"1G","5"
"WX","5"
"3L","5"
"9Y","5"
"EX","6"
"BG","6"
"7K","7"
"E3","7"
"SW","7"
"BM","7"
"3C","7"
"H9","7"
"J3","7"
"GX","8"
"2Z","8"
"8H","8"
"Z7","8"
"0B","8"
"U9","9"
"Z0","10"
"0N","10"
"U8","10"
"XZ","10"
"H0","11"
"CH","13"
"WB","13"
"0R","13"
"DZ","13"
"NI","13"
"QC","14"
"6U","14"
"PO","15"
"RI","16"
"UO","17"
"WO","17"
"OX","18"

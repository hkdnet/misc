# http://nabetani.sakura.ne.jp/hena/orde22numord/
require 'pry'
require_relative './solver.rb'

$dbg = false
ng_c = 0
lines = DATA.read.split("\n")
lines.each.with_index(0) do |line, idx|
  # $dbg = true
  # next unless idx == 7
  _, input, expected = line.match(/"(.+)", "(.+)"/).to_a
  solver = Solver.new
  actual = solver.solve(input)
  if actual == expected
    puts "ok #{idx}"
  else
    puts "#{idx}"
    puts "input   : #{input}"
    puts "actual  : #{actual}"
    puts "expected: #{expected}"
    ng_c += 1
  end
end
puts "NG: #{ng_c}"

__END__
"16,333", "38e"
"2,100", "-"
"2,1", "1"
"2,2", "-"
"11,8", "8"
"14,9", "9"
"11,12", "13"
"7,16", "34"
"20,16", "g"
"2,17", "-"
"8,26", "56"
"16,51", "3c"
"3,77", "-"
"2,100", "-"
"9,110", "1347"
"22,127", "78"
"24,142", "79"
"30,158", "5s"
"20,213", "139"
"6,216", "-"
"9,244", "235678"
"13,253", "57c"
"19,265", "19c"
"24,314", "13k"
"16,333", "38e"
"32,353", "eo"
"25,490", "1dg"
"26,498", "1bd"
"10,500", "2456789"
"10,543", "-"
"3,897", "-"
"11,1000", "1345789a"
"9,1307", "-"
"9,1412", "-"
"26,1678", "79e"
"8,1942", "-"
"12,1950", "234589ab"
"2,2245", "-"
"18,2670", "5ace"
"5,3013", "-"
"5,3048", "-"
"14,3099", "157acd"
"27,3440", "13hm"
"13,3698", "235689ab"
"36,5592", "dqs"
"10,9505", "-"
"27,9833", "49ej"
"16,10000", "123467e"
"24,14090", "14bfk"
"29,15270", "5mnq"
"17,20000", "23458cg"
"36,20000", "37bc"
"25,24346", "256bk"
"21,27815", "146adi"
"25,28030", "2aflm"
"25,34448", "3cefi"
"36,44811", "abpu"

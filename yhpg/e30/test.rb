require 'pry'
require_relative './solver.rb'

$dbg = false
ng_c = 0
lines = DATA.read.split("\n")
lines.each.with_index(0) do |line, idx|
  # $dbg = true
  next if idx != 6
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
"4,6,1,5/3", "14" );
"1/1", "1" );
"6/1", "1" );
"4,6/3", "9" );
"68/68", "68" );
"360/10", "10" );
"2,7,8/8", "256" );
"37,88/71", "504" );
"5,4,1,4/6", "10" );
"123/4567", "4567" );
"473,601/397", "9" );
"47,89,82/38", "402" );
"4,8,1,2,10/10", "98" );
"5,6,7,9,5,2/5", "48" );
"538,846,73/778", "213" );
"80,48,65,83/100", "830" );
"1,4,6,10,5,7,5/5", "904" );
"10,4,1,6,1,2,3,5/3", "9" );
"3,1,4,1,5,9,2/14", "385" );
"33,32,75,24,36/76", "491" );
"43,59,32,2,66,42/58", "849" );
"985,178,756,798/660", "675" );
"3,4,3,4,5,2,3,10,2/5", "334" );
"9,3,4,3,1,9,4,9,3,9/5", "516" );
"883,184,29,803,129/129", "154" );
"4,77,53,79,16,21,100/59", "690" );
"49,94,4,99,43,78,22,74/1", "282" );
"292,871,120,780,431,83/92", "396" );
"4,2,9,1,5,10,7,6,8,9,10/3", "234" );
"9,5,7,6,9,3,4,10,8,6,4,5/6", "990" );
"11,87,44,12,3,52,81,33,55/1", "384" );
"9,2,6,9,5,1,3,6,1,9,2,1,4/9", "498" );
"68,62,15,97,5,68,12,87,78,76/57", "751" );
"792,720,910,374,854,561,306/582", "731" );
"5,10,1,7,5,3,5,7,4,8,9,6,1,9,6/5", "768" );
"7,2,7,8,3,4,2,10,6,10,3,1,10,2/10", "120" );
"4,2,10,7,8,9,8,1,9,7,9,10,9,4,7,2/8", "40" );
"41,55,80,12,39,94,2,96,45,89,25/68", "152" );
"907,371,556,955,384,24,700,131/378", "600" );
"30,68,36,40,10,74,42,24,4,47,91,51/4", "180" );
"807,276,175,555,372,185,445,489,590/287", "80" );
"92,41,37,49,26,68,36,31,30,34,19,18,94/85", "626" );
"529,153,926,150,111,26,465,957,890,887/118", "114" );
"59,1,87,64,17,37,95,25,64,68,52,9,57,92/94", "998" );
"979,772,235,717,999,292,727,702,710,728,556/33", "912" );
"40,93,46,27,75,53,50,92,52,100,19,35,52,31,54/59", "512" );
"800,778,395,540,430,200,424,62,342,866,45,803/931", "260" );
"85,90,67,61,17,57,24,25,5,50,88,31,55,26,21,98/58", "884" );
"510,515,70,358,909,557,886,766,323,624,92,342,424/552", "238" );
"892,751,88,161,148,585,456,88,14,315,594,121,885,952/833", "700" );
"940,824,509,787,942,856,450,327,491,54,817,95,60,337,667/637", "206" );
"408,412,30,930,372,822,632,948,855,503,8,618,138,695,897,852/377", "212" );

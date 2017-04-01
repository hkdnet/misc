require_relative './main.rb'
require 'pry'

pattern = /\A.*\*(\d+)\*.*?"(.*?)", "(.*?)".*\Z/
DATA.read.split("\n").each do |line|
  m = pattern.match(line)
  no = m[1].to_i
  s = Solver.new(id: no)
  actual = s.solve(m[2])
  expected = m[3]
  if expected == actual
    # puts "#{no} ok"
  else
    puts "#{no} ng"
    puts "actual   #{actual}"
    puts "expected #{expected}"
  end
end

__END__
/*0*/ test( "glmq", "B" );
/*1*/ test( "fhoq", "-" );
/*2*/ test( "lmpr", "-" );
/*3*/ test( "glmp", "-" );
/*4*/ test( "dhkl", "-" );
/*5*/ test( "glpq", "D" );
/*6*/ test( "hlmq", "-" );
/*7*/ test( "eimq", "I" );
/*8*/ test( "cglp", "-" );
/*9*/ test( "chlq", "-" );
/*10*/ test( "glqr", "-" );
/*11*/ test( "cdef", "-" );
/*12*/ test( "hijk", "-" );
/*13*/ test( "kpqu", "B" );
/*14*/ test( "hklm", "B" );
/*15*/ test( "mqrw", "B" );
/*16*/ test( "nrvw", "B" );
/*17*/ test( "abfj", "B" );
/*18*/ test( "abcf", "B" );
/*19*/ test( "mrvw", "D" );
/*20*/ test( "ptuv", "D" );
/*21*/ test( "lmnr", "D" );
/*22*/ test( "hklp", "D" );
/*23*/ test( "himr", "D" );
/*24*/ test( "dhil", "D" );
/*25*/ test( "hlpt", "I" );
/*26*/ test( "stuv", "I" );
/*27*/ test( "bglq", "I" );
/*28*/ test( "glmn", "-" );
/*29*/ test( "fghm", "-" );
/*30*/ test( "cdgk", "-" );
/*31*/ test( "lpst", "-" );
/*32*/ test( "imrw", "-" );
/*33*/ test( "dinr", "-" );
/*34*/ test( "cdin", "-" );
/*35*/ test( "eghi", "-" );
/*36*/ test( "cdeg", "-" );
/*37*/ test( "bgko", "-" );
/*38*/ test( "eimr", "-" );
/*39*/ test( "jotu", "-" );
/*40*/ test( "kotu", "-" );
/*41*/ test( "lqtu", "-" );
/*42*/ test( "cdim", "-" );
/*43*/ test( "klot", "-" );
/*44*/ test( "kloq", "-" );
/*45*/ test( "kmpq", "-" );
/*46*/ test( "qrvw", "-" );
/*47*/ test( "mnqr", "-" );
/*48*/ test( "kopt", "-" );
/*49*/ test( "mnpq", "-" );
/*50*/ test( "bfko", "-" );
/*51*/ test( "chin", "-" );
/*52*/ test( "hmnq", "-" );
/*53*/ test( "nqrw", "-" );
/*54*/ test( "bchi", "-" );
/*55*/ test( "inrw", "-" );
/*56*/ test( "cfgj", "-" );
/*57*/ test( "jnpv", "-" );
/*58*/ test( "flmp", "-" );
/*59*/ test( "adpw", "-" );
/*60*/ test( "eilr", "-" );
/*61*/ test( "bejv", "-" );
/*62*/ test( "enot", "-" );
/*63*/ test( "fghq", "-" );
/*64*/ test( "cjms", "-" );
/*65*/ test( "elov", "-" );
/*66*/ test( "chlm", "D" );
/*67*/ test( "acop", "-" );
/*68*/ test( "finr", "-" );
/*69*/ test( "qstu", "-" );
/*70*/ test( "abdq", "-" );

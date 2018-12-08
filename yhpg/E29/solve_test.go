package e29

import "testing"

func TestNextToken(t *testing.T) {
	patterns := []struct{ input, want string }{
		{"a", "a"},
		{"//", "/"},
	}
	for _, v := range patterns {
		l := lexer{text: v.input}
		got, err := l.NextToken()
		if err != nil {
			t.Fatal(err)
		}
		if got != v.want {
			t.Errorf("got: %#v want:%#v", got, v.want)
		}
	}
}

func Test(t *testing.T) {
	test := func(input, want string) {
		res := solve(input)
		if got := res.output; got != want {
			if res.err != nil {
				t.Errorf("input: %s want: %#v but got %#v: err %s", input, want, got, res.err)
			} else {
				t.Errorf("input: %s want: %#v but got %#v", input, want, got)
			}
		}
	}
	/*0*/ test("foo/bar/baz", "foo,bar,baz")
	/*1*/ test("/foo/bar/baz'/", "-")
	/*2*/ test("\"", "-")
	/*3*/ test("'", "-")
	/*4*/ test("/", "-")
	/*5*/ test("\"\"", "-")
	/*6*/ test("''", "-")
	/*7*/ test("//", "/")
	/*8*/ test("\"/'", "-")
	/*9*/ test("'/\"", "-")
	/*10*/ test("Qux", "Qux")
	/*11*/ test("Foo/Bar", "Foo,Bar")
	/*12*/ test("foo\"bar", "-")
	/*13*/ test("foo'bar", "-")
	/*14*/ test("/foo/bar", "-")
	/*15*/ test("Foo//Bar", "Foo/Bar")
	/*16*/ test("foo/bar/", "-")
	/*17*/ test("'\"'a'\"'/b", "\"a\",b")
	/*18*/ test("Foo\"/\"Bar", "Foo/Bar")
	/*19*/ test("foo\"'\"bar", "foo'bar")
	/*20*/ test("foo'\"'bar", "foo\"bar")
	/*21*/ test("foo///bar", "foo/,bar")
	/*22*/ test("\"Z\"\"tO\"uFM", "ZtOuFM")
	/*23*/ test("''/foo/bar", "-")
	/*24*/ test("////'/\"//'", "///\"//")
	/*25*/ test("File/'I/O'", "File,I/O")
	/*26*/ test("Foo'//'Bar", "Foo//Bar")
	/*27*/ test("foo/''/bar", "-")
	/*28*/ test("foo/bar/\"\"", "-")
	/*29*/ test("'/////'////", "///////")
	/*30*/ test("'foo\"\"\"bar'", "foo\"\"\"bar")
	/*31*/ test("//'int'/V/c", "/int,V,c")
	/*32*/ test("foo/bar/baz", "foo,bar,baz")
	/*33*/ test("'H//Sg//zN'/", "-")
	/*34*/ test("//'//\"/'/'\"'", "///\"/,\"")
	/*35*/ test("foo//bar/baz", "foo/bar,baz")
	/*36*/ test("\"\"\"///\"/'/'//", "///,//")
	/*37*/ test("58\"\"N\"//nIk'd", "-")
	/*38*/ test("foo\"/\"bar/baz", "foo/bar,baz")
	/*39*/ test("/////'\"/'/'\"/'", "//,\"/,\"/")
	/*40*/ test("f\"//J\"/O9o\"//'", "-")
	/*41*/ test("foo\"//\"bar/baz", "foo//bar,baz")
	/*42*/ test("foo/bar////baz", "foo,bar//baz")
	/*43*/ test("\"\"\"'/'//'''/\"//", "'/'//'''//")
	/*44*/ test("8//'/k///\"3da\"'", "8//k///\"3da\"")
	/*45*/ test("foo/'/bar/'/baz", "foo,/bar/,baz")
	/*46*/ test("///''\"//\"\"///\"\"\"", "/,/////")
	/*47*/ test("//wUJ8KNAk'n0//\"", "-")
	/*48*/ test("What/is/'\"real\"'", "What,is,\"real\"")
	/*49*/ test("\"//'/////\"''/'//'", "//'/////,//")
	/*50*/ test("\"8hKE\"3Fx/4//Hk/J", "8hKE3Fx,4/Hk,J")
	/*51*/ test("'////''\"'//'/\"///'", "////\"//\"///")
	/*52*/ test("Ro\"/j''/2u/f/r/\"3n", "Ro/j''/2u/f/r/3n")
	/*53*/ test("hoge\"//\"fuga//piyo", "hoge//fuga/piyo")
	/*54*/ test("'foo//bar'//baz/qux", "foo//bar/baz,qux")
	/*55*/ test("//'//\"'/\"///'\"/''//", "///\",///',/")
	/*56*/ test("2/L'3'A8p/7//wP49Jb", "2,L3A8p,7/wP49Jb")
	/*57*/ test("\"foo'\"/\"bar'\"/\"baz'\"", "foo',bar',baz'")
	/*58*/ test("'//'\"//'///'///''\"//", "////'///'///''/")
	/*59*/ test("F6vX/q/Zu//5/'/H\"/'w", "F6vX,q,Zu/5,/H\"/w")
	/*60*/ test("\"foo'bar\"/'hoge\"fuga'", "foo'bar,hoge\"fuga")
	/*61*/ test("/\"/'//'/\"\"\"''//'/\"'''", "-")
	/*62*/ test("0gK\"koYUb\"\"S/p''z/\"Et", "0gKkoYUbS/p''z/Et")
	/*63*/ test("Foo/Bar/\"Hoge'/'Fuga\"", "Foo,Bar,Hoge'/'Fuga")
}
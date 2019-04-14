object Main {
  def main(args: Array[String]) {
    if (sys.env.getOrElse("TEST", "") == "1") {
      println(test());
    } else {
      val input = io.Source.stdin.getLines().mkString("\n");
      println(solve(input).trim());
    }
  }

  def solve(input: String): String = {
    val arr = input.split(" ").map(_.toInt)
    return (arr ++ arr.map(_ - 1)).sortWith(_ < _).drop(2).sum.toString()
  }

  val tests = List(
    """3 5""" -> """9""",
    """3 4""" -> """7""",
    """6 6""" -> """12""");

  def test(): String = {
    return tests.map { case (i, o) => (i.trim(), o.trim()) }
      .zipWithIndex.map {
      case ((input, outputExpect), i) => {
        val output = solve(input).trim();
        s"test${i + 1}:" + (if (output == outputExpect) {
          "Passed"
        } else {
          s"Failed\nexpect:\n${outputExpect}\noutput:\n${output}"
        })
      }
    }
      .mkString("\n");
  }
}

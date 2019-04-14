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
    val arr = input.split("\n")(1).split(" ").map(_.toInt)
    val t = arr.foldLeft((0, 0))((t, e: Int) => {
      if (t._1 <= e) {
        (e, t._2 + 1)
      } else {
        t
      }
    })
    return t._2.toString
  }

  val tests = List(
    """4
      |6 5 6 8""".stripMargin ->
      """3""",
    """5
      |4 5 3 5 4""".stripMargin -> "3",
    """5
      |9 5 6 8 4""".stripMargin -> "1");

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

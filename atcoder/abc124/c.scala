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
    val t = input.toCharArray.zipWithIndex.foldLeft((0, 0))((t, e) => {
      val (c, i) = e
      if (i % 2 == 0) {
        if (c == '0') {
          (t._1 + 1, t._2 )
        } else {
          (t._1, t._2 + 1)
        }
      } else {
        if (c == '1'){
          (t._1 + 1, t._2 )
        } else {
          (t._1, t._2 + 1)
        }
      }
    })
    val m = if (t._1 < t._2) t._1 else t._2
    m.toString
  }

  val tests = List(
    """000 """.stripMargin ->"1",
    """10010010""".stripMargin -> "3",
    """0""".stripMargin -> "0");

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

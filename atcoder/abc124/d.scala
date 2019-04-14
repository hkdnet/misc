object Main {
  def main(args: Array[String]) {
    if (sys.env.getOrElse("TEST", "") == "1") {
      println(test());
    } else {
      val input = io.Source.stdin.getLines().mkString("\n");
      println(solve(input).trim());
    }
  }
  type Chunk = (Char, Int)

  def solve(input: String): String = {
    val arr = input.split("\n")
    val tmp = arr(0).split(" ").map(_.toInt)
    val k = tmp(1)
    val t = arr(1).toCharArray.foldLeft((0, List.empty[Int], '2'))((acc, c) => {
      val (cnt, arr, prevChar) = acc
      if (prevChar == c) (cnt + 1, arr, c) else (1, cnt::arr, c)
    })
    val lens = if (arr(1).charAt(arr(1).length-1) == '1') {
      (t._1::t._2)
    } else {
      0 :: (t._1::t._2)
    }
    val chunk = lens.zipWithIndex.foldLeft((0, List.empty[Int]))((acc, t) => {
      val (c, arr) = acc
      val (count, index) = t
      if (index % 2 == 0) (count, arr) else (0, (c+count)::arr)
    })._2
    val max = chunk.zipWithIndex.foldLeft(chunk.take(k).sum)((max, t) => {
      val (count, index) = t
      if (index + k >= chunk.length) max
      else {
        val tmp = max - chunk(index) + chunk(index + k)
        if (tmp > max) tmp else max
      }
    })
    return max.toString
  }

  val tests = List(
    """5 1
      |00010""".stripMargin -> "4",
    """5 2
      |00010""".stripMargin -> "5",
    """6 1
      |000101""".stripMargin -> "4",
    """6 2
      |000101""".stripMargin -> "6",
    """14 2
      |11101010110011""".stripMargin -> "8",
    """15 2
      |111010101100110""".stripMargin -> "8",
    """1 1
      |1""".stripMargin -> "1");

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

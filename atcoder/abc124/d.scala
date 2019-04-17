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
    val arr = input.split("\n")
    val tmp = arr(0).split(" ").map(_.toInt)
    val k = tmp(1)
    val t = arr(1).toCharArray.foldLeft((0, '2', List.empty[Int])){
      case ((cnt, prev, arr), c) =>
        if (prev == c) (cnt + 1, c, arr)
        else (1, c, cnt::arr)
    }
    val lens = if (arr(1).charAt(arr(1).length - 1) == '1') {
      (t._1 :: t._3)
    } else {
      0 :: (t._1 :: t._3)
    }
    val chunk = lens.zipWithIndex.foldLeft((0, List.empty[Int]))({
      case ((c, arr), (count, index)) => {
        if (index % 2 == 0) (count, arr) else (0, (c + count) :: arr)
      }
    })._2
    val max = chunk.zipWithIndex.foldLeft(chunk.take(k).sum)({
      case (max, (count, index)) => {
        if (index + k >= chunk.length) max
        else {
          val tmp = max - chunk(index) + chunk(index + k)
          if (tmp > max) tmp else max
        }
      }
    })
    return max.toString
  }

  val tests = List(
    """5 1
      |00010""".stripMargin -> "4",
    """14 2
      |11101010110011""".stripMargin -> "8",
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

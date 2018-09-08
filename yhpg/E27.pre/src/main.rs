use std::fmt;
use std::char;
use std::iter::FromIterator;

struct Field {
    f: [[Cell; 5]; 5],
    passed: [[i32; 5]; 5],
    y_idx: (usize, usize),
}

#[derive(PartialEq, Debug, Clone)]
enum Cell {
    X, // x: 光を吸収するマス。
    D, // .: なにもないマス。光を通す。
    R, // 1: 「╱」という向きの鏡。
    L, // 0: 「╲」という向きの鏡。
    Y, // Y: あなた。
}
impl fmt::Display for Cell {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            Cell::X => write!(f, "X"),
            Cell::D => write!(f, "D"),
            Cell::R => write!(f, "R"),
            Cell::L => write!(f, "L"),
            Cell::Y => write!(f, "Y"),
        }
    }
}
impl Cell {
    fn reflect(c: Cell, dir: Direction) -> Direction {
        if c == Cell::R {
            // println!("reflect by {}", c);
            // R == /
            return match dir {
                Direction::N => Direction::E,
                Direction::E => Direction::N,
                Direction::S => Direction::W,
                Direction::W => Direction::S,
            }
        } else if c == Cell::L {
            // println!("reflect by {}", c);
            // L == \
            return match dir {
                Direction::N => Direction::W,
                Direction::E => Direction::S,
                Direction::S => Direction::E,
                Direction::W => Direction::N,
            }
        } else {
            dir
        }
    }
}

#[derive(Eq, PartialEq, Debug, Clone)]
enum Direction {
    N,
    E,
    S,
    W,
}

struct RayResult {
    from: (usize, usize),
    dir: Direction,
    stopped: bool,
}

fn coor_to_char(coor: (usize, usize)) -> char {
    let idx = coor.0 + coor.1 * 5;
    match char::from_digit(10 + idx as u32, 36) {
        Some(s) => return s,
        None => panic!("Cannot convert coor: ({}, {})", coor.0, coor.1),
    }
}

impl Field {
    fn set(&mut self, cell: Cell, x: usize, y: usize) {
        if cell == Cell::Y {
            self.y_idx = (x, y);
        }
        self.f[y][x] = cell;
    }

    fn start(&mut self) {
        let mut res = RayResult {
            from: self.y_idx,
            dir: Direction::N,
            stopped: false,
        };
        self.pass(self.y_idx, Direction::N);
        let mut f = res.stopped;
        while !f {
            // println!("now: ({}, {})", res.from.0, res.from.1);
            res = self.process(res);
            f = res.stopped;
        }
    }

    fn pass(&mut self, coor: (usize, usize), dir: Direction) {
        let f = match dir {
            Direction::N => 1,
            Direction::E => 2,
            Direction::S => 4,
            Direction::W => 8,
        };
        self.passed[coor.1][coor.0] = self.passed[coor.1][coor.0] | f;
    }

    fn passed(&self, coor: (usize, usize), dir: Direction) -> bool {
        let f = match dir {
            Direction::N => 1,
            Direction::E => 2,
            Direction::S => 4,
            Direction::W => 8,
        };
        return self.passed[coor.1][coor.0] & f != 0;
    }

    fn passed_coors(self) -> Vec<(usize, usize)> {
        let mut ret = Vec::new();

        for (y, r) in self.passed.iter().enumerate() {
            for (x, c) in r.iter().enumerate() {
                if c != &0 {
                    ret.push((x, y));
                }
            };
        }

        return ret
    }

    fn process(&mut self, res: RayResult) -> RayResult {
        let coor = match res.dir {
            Direction::N => (res.from.0 as i32, res.from.1 as i32 - 1),
            Direction::E => (res.from.0 as i32 + 1, res.from.1 as i32),
            Direction::S => (res.from.0 as i32, res.from.1 as i32 + 1),
            Direction::W => (res.from.0 as i32 - 1, res.from.1 as i32),
        };
        let x = coor.0;
        let y = coor.1;
        if x >= 0 && x < 5 && y >= 0 && y < 5 {
            let c = &self.f[y as usize][x as usize];
            let new_dir = Cell::reflect(c.clone(), res.dir);
            let new_from = (coor.0 as usize, coor.1 as usize);
            if self.passed(new_from, new_dir.clone()) {
                return RayResult {
                    from: new_from,
                    dir: new_dir,
                    stopped: true,
                }
            }
            if c != &Cell::X {
                self.pass(new_from, new_dir.clone());
            }
            return RayResult {
                from: new_from,
                dir: new_dir,
                stopped: c == &Cell::X,
            }
        } else {
            return RayResult {
                from: res.from,
                dir: res.dir,
                stopped: true,
            }
        }
    }
}


fn new_field() -> Field {
    Field {
        f: [
            [Cell::Y, Cell::X, Cell::X, Cell::X, Cell::X],
            [Cell::X, Cell::X, Cell::X, Cell::X, Cell::X],
            [Cell::X, Cell::X, Cell::X, Cell::X, Cell::X],
            [Cell::X, Cell::X, Cell::X, Cell::X, Cell::X],
            [Cell::X, Cell::X, Cell::X, Cell::X, Cell::X],
        ],
        passed: [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
        ],
        y_idx: (0, 0)
    }
}
fn solve(input: &str) -> String {
    let row_strs = input.split("/");
    let mut field = new_field();

    for (y, row_str) in row_strs.enumerate() {
        for (x, c) in row_str.chars().enumerate() {
            let cell = match c {
                'x' => Cell::X,
                '.' => Cell::D,
                '1' => Cell::R,
                '0' => Cell::L,
                'Y' => Cell::Y,
                _ => panic!("Invalid input: {}", input),
            };
            field.set(cell, x, y);
        };
    }

    field.start();
    let tmp = field.passed_coors().into_iter().map(|h| coor_to_char(h));
    return String::from_iter(tmp)
}
fn test(input: &str, expected: &str) {
    let actual = solve(input);
    if actual != expected {
        println!("ng\n  actual: {} \nexpected: {}", actual, expected);
    } else {
        println!("ok!");
    }
}
fn main() {
    test( "x...x/.1.0./..0../.Y.../0..x.", "ghilnqs" );
    test( "..Y../...../...../...../.....", "c" );
    test( "..x../..Y../...../...../.....", "h" );
    test( "..Y.x/..1x0/11.../....0/1..1.", "c" );
    test( "....1/....Y/...../...../.....", "ej" );
    test( ".10../x.1../x.1x./.Y.1./...0.", "bcghlq" );
    test( "0.x10/00..x/x0x.0/....0/...Y1", "deinsx" );
    test( "1.01./01Y.1/..1.1/..10./0.0..", "abcfgh" );
    test( "x..../x1x../0...0/....Y/.1..0", "klmnot" );
    test( "...../..10./.1Y1./.01../.....", "hilmnqr" );
    test( "...../..10./x.11./...../..Y..", "hilmnrw" );
    test( "...../x.10x/...../x.Y1x/.....", "himnqrs" );
    test( "..010/...Y1/..0../0.x../.....", "defghij" );
    test( "1.0../...../.0x../Y.1x./..1..", "abcfhkp" );
    test( "...../101../0.0../..Y../.....", "fgklmqrv" );
    test( "1.0../00.../.x..0/0.Y1./...10", "abcfghmr" );
    test( "x101./1..../.Y.x./..01./.00.1", "bcghlmrs" );
    test( "x11../x.x../.0.01/..x../...Y.", "bcglmnsx" );
    test( "..1.0/x0.x./0.0../x...Y/.10.1", "cdehjmnot" );
    test( "..x.0/.0.../1..0x/1..1./Y.00.", "klmnpqrsu" );
    test( "0.1.0/.0.xY/0...0/01..1/x00.x", "cdehjmrwx" );
    test( "...0./.0.0./..101/...10/..01Y", "mnpqrstwxy" );
    test( "10..0/.Y.0./0..1./....x/000..", "abfghiklmn" );
    test( "10..1/...../.1010/110.1/x..Yx", "lmnopqrstx" );
    test( "110../....1/x1..x/0.0.0/....Y", "bcghlmrsty" );
    test( "x.101/1..../..001/010Yx/..1.1", "cdehijmnos" );
    test( "x.111/x10../...0./00.1x/x.Y.1", "ghklmnqrsw" );
    test( "11.../....0/11..1/1.1../.Y..1", "fghijlmnoqv" );
    test( "...x1/.1.0./11.1./.01../Y..x.", "cghiklmnpqru" );
    test( ".0.../110x./11..0/01.x./..Y.x", "ghklmnopqrtw" );
    test( ".01.0/.110x/0...0/.01Y./x.1x.", "cdeghilmnqrs" );
    test( ".1100/..1.0/1.11Y/0..1./.0..0", "hijklmnopqrs" );
    test( "1..00/..11./.100./1..Y1/.....", "abcdfhikmnps" );
    test( "1.0../.11x0/.00.x/Y.10./.10x0", "abcfghklmpqr" );
    test( "11110/11.../.x.../.0111/0.Y0.", "deijnorstwxy" );
    test( "...1./.1.0x/10..0/0Y.11/.0.x0", "ghiklmnopqrst" );
    test( "...10/x111./0x.11/.0.../0.0Y.", "dehijmnorswxy" );
    test( ".1x../.x1.0/0x.x./x11.1/x0Y.1", "hijmoqrstvwxy" );
    test( "x.x../x110./1.1.0/0.Y.1/0.00x", "hiklmnopqrstx" );
    test( "...0./11.00/10..x/..0.1/Y0.10", "ghiklmnpqsuvwx" );
    test( ".110./....0/x..../.0001/11.Y.", "cdfghijmnorstx" );
    test( "1.00./....1/.1.../0...0/0..1Y", "abcfhkmpqrstwy" );
    test( ".1.01/..x../..100/..Y../...01", "bcdgilmnoqrstvxy" );
    test( "1...0/Y..../...../...../0...1", "abcdefjkoptuvwxy" );
    test( "x1..0/1..0./.Yx../0...1/.0.1.", "bcdefghijklnopqrstvwx" );
    test( "1...0/.1.0./..1../..01./Y0..1", "abcdefghijklmnopqrstuvwxy" );
}


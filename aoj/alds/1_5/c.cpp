#include <cstdio>
#include <iostream>
#include <set>
#include <utility>
#include <math.h>

typedef std::pair<double, double> point;

#define REP(i, n) for(int i = 0; i < n; i++)
void koch(int n, point a, point b) {
    if (n == 0) return;

    point s = point(
        a.first + (b.first - a.first) / 3,
        a.second + (b.second - a.second) / 3
    );
    point t = point(
        a.first + (b.first - a.first) / 3 * 2,
        a.second + (b.second - a.second) / 3 * 2
    );
    double th = M_PI * 60.0 / 180.0;
    point u = point(
        (t.first - s.first) * cos(th) - (t.second - s.second) * sin(th) + s.first,
        (t.first - s.first) * sin(th) + (t.second - s.second) * cos(th) + s.second
    );

    koch(n - 1, a, s);
    printf("%.6f %.6f\n", s.first, s.second);
    koch(n - 1, s, u);
    printf("%.6f %.6f\n", u.first, u.second);
    koch(n - 1, u, t);
    printf("%.6f %.6f\n", t.first, t.second);
    koch(n - 1, t, b);
}

int main() {
    int n;
    scanf("%d", &n);
    point p1 = point(0.0, 0.0);
    point p2 = point(100.0, 0.0);
    printf("%.6f %.6f\n", p1.first, p1.second);
    koch(n, p1, p2);
    printf("%.6f %.6f\n", p2.first, p2.second);
    return 0;
}

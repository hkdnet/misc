#include <cstdio>
#include <iostream>
#include <set>

#define REP(i, n) for(int i = 0; i < n; i++)

int main(int argc, char const* argv[])
{
    int n;
    scanf("%d\n", &n);
    int a[n];
    for (int i = 0; i < n; i++) {
        int t;
        scanf("%d", &t);
        a[i] = t;
    }
    std::cin.ignore();
    int m;
    scanf("%d\n", &m);
    int b[m];
    for (int i = 0; i < m; i++) {
        int t;
        scanf("%d", &t);
        b[i] = t;
    }
    std::set<int> s;
    REP(i, n) {
        REP(j, m) {
            if (a[i] == b[j]) {
                s.insert(a[i]);
                break;
            }
        }
    }
    std::cout << s.size() << "\n";
    return 0;
}

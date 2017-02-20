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
    REP(j, m) {
        int l = 0;
        int r = n;
        int target = b[j];
        while(true) {
            int idx = (l + r) / 2;
            if (a[idx] == target) {
                s.insert(target);
                break;
            }
            if (l == r) break;
            if (a[idx] < target) {
                l = idx + 1;
            } else {
                r = idx;
            }
        }
    }
    std::cout << s.size() << "\n";
    return 0;
}

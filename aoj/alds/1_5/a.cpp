#include <cstdio>
#include <iostream>
#include <set>

#define REP(i, n) for(int i = 0; i < n; i++)

bool is_creatable(int a[], int n, int idx, int target) {
    if(target < 0) return false;
    if(n == idx) {
        return target == 0;
    }
    if(is_creatable(a, n, idx + 1, target)) {
        return true;
    }
    if(is_creatable(a, n, idx + 1, target - a[idx])) {
        return true;
    }
    return false;
}
int main(int argc, char const* argv[]) {
    int n, q;
    scanf("%d", &n);
    std::cin.ignore();
    int a[n];
    REP(i, n) scanf("%d", &a[i]);
    std::cin.ignore();
    scanf("%d", &q);
    REP(i, q) {
        int t;
        scanf("%d", &t);
        if(is_creatable(a, n, 0, t)) {
            std::cout << "yes\n";
        } else {
            std::cout << "no\n";
        }
    }
    return 0;
}

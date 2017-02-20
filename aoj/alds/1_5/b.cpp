#include <cstdio>
#include <iostream>
#include <set>

#define REP(i, n) for(int i = 0; i < n; i++)

int merge(int a[], int l, int m, int r) {
    int la[m-l + 1];
    int ra[r-m + 1];
    int count = 0;
    for(int i = 0; i < m - l; i++) la[i] = a[l+i];
    for(int i = 0; i < r - m; i++) ra[i] = a[m+i];
    la[m - l] = 1000000001;
    ra[r - m] = 1000000001;
    int i = 0;
    int j = 0;
    for(int k = l; k < r; k++) {
        count++;
        if (la[i] <= ra[j]) {
            a[k] = la[i++];
        } else {
            a[k] = ra[j++];
        }
    }
    return count;
}

int merge_sort(int a[], int l, int r) {
    int count = 0;
    if (l+1 < r) {
        int m = (l + r) / 2;
        count += merge_sort(a, l, m);
        count += merge_sort(a, m, r);
        count += merge(a, l, m, r);
    }
    return count;
}

int main() {
    int n, q;
    scanf("%d", &n);
    std::cin.ignore();
    int a[n];
    REP(i, n) scanf("%d", &a[i]);
    int count = merge_sort(a, 0, n);
    REP(i, n - 1) std::cout << a[i] << " ";
    std::cout << a[n - 1] << std::endl;
    std::cout << count << "\n";

    return 0;
}

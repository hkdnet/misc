#include <iostream>
#include <cstdio>

# define REP(i, n) for(int i =0; i < n; i++)

# define MAX 10000
# define MAX_LEN 2000000

int arr[MAX_LEN];
int sorted[MAX_LEN];
int count[MAX + 1];
int main() {
    int n;
    scanf("%d", &n);
    std::cin.ignore();
    REP(i, n) scanf("%d", &arr[i]);
    REP(i, n) count[arr[i]]++;
    REP(i, MAX) count[i+1] += count[i];
    REP(j, n) {
        int i = n - 1 - j;
        count[arr[i]]--;
        sorted[count[arr[i]]] = arr[i];
    }
    REP(i, n) {
        if (i != 0) std::cout << " ";
        std::cout << sorted[i];
    }
    std::cout << std::endl;
    return 0;
}

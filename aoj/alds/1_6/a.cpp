#include <iostream>
#include <cstdio>
#include <memory>

# define REP(i, n) for(auto i = 0u; i < n; i++)

constexpr std::size_t MAX = 10000;
constexpr std::size_t MAX_LEN = 2000000;

int main() {
    uint n;
    std::unique_ptr<int[]> arr(new int[MAX_LEN]);
    std::unique_ptr<int[]> sorted(new int[MAX_LEN]);
    std::unique_ptr<int[]> count(new int[MAX + 1]);
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

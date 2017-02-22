#include <iostream>
#include <cstdio>

# define REP(i, n) for(int i =0; i < n; i++)

int partition(int arr[], int p, int r) {
    int x = arr[r];
    int i = p - 1;
    for(int j = p; j < r; j++) {
        if (arr[j] <= x) {
            i += 1;
            std::swap(arr[i], arr[j]);
        }
    }
    std::swap(arr[i+1], arr[r]);
    return i + 1;

}

int main() {
    int n;
    scanf("%d", &n);
    std::cin.ignore();
    int arr[n];
    REP(i, n) scanf("%d", &arr[i]);
    int idx = partition(arr, 0, n - 1);
    REP(i, n) {
        if (i != 0) {
            std::cout << " ";
        }
        if (i == idx) std::cout << "[";
        std::cout << arr[i];
        if (i == idx) std::cout << "]";
    }
    std::cout << std::endl;
    return 0;
}

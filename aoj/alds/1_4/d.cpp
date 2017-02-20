#include <cstdio>
#include <iostream>
#include <string>
#include <cstring>
#include <map>

#define REP(i, n) for(int i = 0; i < n; i++)

bool is_ok(int arr[], int n, int lim, int size)
{
    int count = 1;
    int tmp = 0;
    REP(i, n) {
        int t = tmp + arr[i];
        if (t > lim) {
            count += 1;
            if (count > size) {
                return false;
            }
            tmp = arr[i];
            if (arr[i] > lim) {
                return false;
            }
            continue;
        }
        tmp += arr[i];
    }
    return true;
}

int main(int argc, char const* argv[])
{
    int n, k;
    scanf("%d %d", &n, &k);
    long long max = 10000 * n / k;
    long long l = 0;
    long long r = max;
    int arr[n];
    std::cin.ignore();
    REP(i, n) {
        scanf("%d", &arr[i]);
        std::cin.ignore();
    }
    while(true) {
        if (l == r) {
            std::cout << r << "\n";
            break;
        }
        long long idx = (l + r) / 2;
        if(is_ok(arr, n, idx, k)) {
            r = idx;
        } else {
            l = idx + 1;
        }
    }
    return 0;
}

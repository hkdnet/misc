#include <iostream>
#include <cstdio>

# define REP(i, n) for(int i =0; i < n; i++)

struct Card {
    char suit;
    int rank;
};

int partition(Card arr[], int p, int r) {
    Card x = arr[r];
    int i = p - 1;
    for(int j = p; j < r; j++) {
        if (arr[j].rank <= x.rank) {
            i += 1;
            std::swap(arr[i], arr[j]);
        }
    }
    std::swap(arr[i+1], arr[r]);
    return i + 1;
}

void quicksort(Card arr[], int p, int r) {
    if (p < r) {
        int q = partition(arr, p, r);
        quicksort(arr, p, q - 1);
        quicksort(arr, q + 1, r);
    }
}

bool is_stable(int n, Card org[], Card arr[]) {
    int idx = 0;
    while(idx < n) {
        int target = arr[idx].rank;
        char arrcs[n];
        int count = 0;
        for(int i = idx; i < n; i++) {
            if (arr[i].rank != target) break;
            arrcs[count] = arr[i].suit;
            count += 1;
        }
        int orgcount = 0;
        REP(i, n) {
            if (orgcount == count) break;
            if (org[i].rank != target) continue;
            if (org[i].suit != arrcs[orgcount]) return false;
            orgcount++;
        }
        idx += count;
    }
    return true;
}

int main() {
    int n;
    scanf("%d", &n);
    std::cin.ignore();
    Card org[n];
    Card arr[n];
    REP(i, n) {
        char c[10];
        int r;
        scanf("%s %d", c, &r);
        std::cin.ignore();
        org[i].suit = c[0];
        arr[i].suit = c[0];
        org[i].rank = r;
        arr[i].rank = r;
    }
    quicksort(arr, 0, n - 1);
    if (is_stable(n, org, arr)) {
        std::cout << "Stable" << std::endl;
    } else {
        std::cout << "Not stable" << std::endl;
    }
    REP(i, n) {
        std::cout << arr[i].suit << " " << arr[i].rank << std::endl;
    }
    return 0;
}

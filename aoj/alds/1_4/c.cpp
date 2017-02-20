#include <cstdio>
#include <iostream>
#include <string>
#include <cstring>
#include <map>

#define REP(i, n) for(int i = 0; i < n; i++)

int main(int argc, char const* argv[])
{
    int n;
    scanf("%d\n", &n);
    std::map<std::string, bool> m;
    REP(i, n) {
        char t1[6];
        char t2[12];
        scanf("%s %s", t1, t2);
        if (strcmp(t1, "find") == 0) {
            if (m[t2]) {
                std::cout << "yes" << "\n";
            } else {
                std::cout << "no" << "\n";
            }
        } else {
            m[t2] = true;
        }
        std::cin.ignore();
    }
    return 0;
}

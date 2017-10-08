#include <stdio.h>

int foo(bar)
    int bar;
{
    return bar;
}

int main() {
    printf("%d\n", foo(3));
    return 0;
}


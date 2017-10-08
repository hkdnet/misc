```
~/.g/g/h/misc ❯❯❯ cat foo.c
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

~/.g/g/h/misc ❯❯❯ gcc -Werror -std=c89 foo.c
~/.g/g/h/misc ❯❯❯ echo $?
0
~/.g/g/h/misc ❯❯❯ ./a.out
3

```

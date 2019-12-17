import itertools

n, m = map(int, list(input().split(' ')))
paths = {}
for i in range(m):
    a, b = map(int, list(input().split(' ')))
    if a in paths:
        paths[a].add(b)
    else:
        paths[a] = set([b])

ans = 0
for t in itertools.permutations(range(2, n+1), n - 1):
    arr = list(t)
    arr.insert(0, 1)
    for i in range(len(arr) - 1):
        a = arr[i]
        b = arr[i + 1]
        if a > b:
            tmp = a
            a = b
            b = tmp
        if not a in paths:
            break
        if not b in paths[a]:
            break
    else:
        ans += 1

print(ans)

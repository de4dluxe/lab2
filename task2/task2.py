import sys

def main():
    print("Введите количество пар городов: ", end="")
    n = int(input())
    pairs = []
    for _ in range(n):
        a, b = input().split()
        pairs.append((a, b))

    error = False

    for p in pairs:
        if p[0] == p[1]:
            error = True
            break

    start_count = {}
    for p in pairs:
        start_count[p[0]] = start_count.get(p[0], 0) + 1
        if start_count[p[0]] > 1:
            error = True
            break

    end_count = {}
    for p in pairs:
        end_count[p[1]] = end_count.get(p[1], 0) + 1
        if end_count[p[1]] > 1:
            error = True
            break

    if error:
        print("Ошибка")
        return

    next_map = {p[0]: p[1] for p in pairs}

    starts = set()
    for p in pairs:
        if p[0] not in end_count:
            starts.add(p[0])

    if not starts:
        print("Ошибка")
        return

    best_end = ""
    max_len = -1

    for start in starts:
        cur = start
        length = 0
        while cur in next_map:
            cur = next_map[cur]
            length += 1
        if length > max_len:
            max_len = length
            best_end = cur

    print(best_end)


if __name__ == "__main__":
    main()
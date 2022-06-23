# first exercise

# n = int(input())

# array_n = list(map(int, input().split()))

# array_n.sort()

# m = int(input())

# array_m = list(map(int, input().split()))

# def binary_search(array, target, start, end):
#     if start > end:
#         return None
#     mid = (start + end) // 2

#     if array[mid] == target:
#         return mid
#     elif array[mid] > target:
#         return binary_search(array, target, start, mid-1)
#     else:
#         return binary_search(array, target, mid+1, end)


# for i in range (0,m):
#     if binary_search(array_n, array_m[i], 0, n-1) == None:
#         print("no", end = ' ')
#     else: print("yes", end = ' ')

# second exercise

n, m = map(int, input().split())

len_array = list(map(int, input().split()))

len_array.sort()

max_len = max(len_array)


while(True):
    tot = 0

    for i in range(0, n):
        if len_array[i] - max_len >= 0:
            tot += len_array[i] - max_len

    if tot >= m:
        break
    else:
        max_len -= 1

print(max_len)









print("line64")
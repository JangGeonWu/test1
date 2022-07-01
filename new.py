id_list = ["muzi", "frodo", "apeach", "neo"]
report = ["muzi frodo","apeach frodo","frodo neo","muzi neo","apeach muzi"]
k = 2

# id_list = ["con", "ryan"]
# report = ["ryan con","ryan con", "ryan con"]
# k = 3

reported = [[] for _ in range(0, len(id_list))]

for i in range(0, len(report)):
    array = list(report[i].split())
    if array[0] not in reported[id_list.index(array[1])]:
        reported[id_list.index(array[1])].append(array[0])

print(reported)

answer = [0 for _ in range(0, len(id_list))]

for i in range(0, len(id_list)):
    if len(reported[i]) >= k:
        for v in reported[i]:
            answer[id_list.index(v)] += 1

print(answer)            
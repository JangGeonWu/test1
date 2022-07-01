id_list = ["con", "ryan"]
report = ["ryan con","ryan con", "ryan con"]
k = 3

def solution(id_list, report, k):
    answer = [0] * len(id_list)  # answer라는 리스트 생성  
    reports = {x : 0 for x in id_list} # reports라는 딕셔너리 생성

    for r in set(report): # report를 set으로 하여 중복되는 값 제거
        reports[r.split()[1]] += 1 # 적발당한 캐릭터의 value에 1 추가

    for r in set(report):
        if reports[r.split()[1]] >= k: # 적발당한 캐릭터의 value가 k 이상이면
            answer[id_list.index(r.split()[0])] += 1 # 해당 캐릭터를 고발한 사람에게 +1

    return answer

print(solution(id_list, report, k))








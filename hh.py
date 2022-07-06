# id_list = ["con", "ryan"]
# report = ["ryan con","ryan con", "ryan con"]
# k = 3

# def solution(id_list, report, k):
#     answer = [0] * len(id_list)  # answer라는 리스트 생성  
#     reports = {x : 0 for x in id_list} # reports라는 딕셔너리 생성

#     for r in set(report): # report를 set으로 하여 중복되는 값 제거
#         reports[r.split()[1]] += 1 # 적발당한 캐릭터의 value에 1 추가

#     for r in set(report):
#         if reports[r.split()[1]] >= k: # 적발당한 캐릭터의 value가 k 이상이면
#             answer[id_list.index(r.split()[0])] += 1 # 해당 캐릭터를 고발한 사람에게 +1

#     return answer

# print(solution(id_list, report, k))

# lottos = [44, 1, 0, 0, 31, 25]
# win_nums = [31, 10, 45, 1, 6, 19]

# def solution(lottos, win_nums):
#     correct_num = 0
#     zero_num = 0

#     for i in lottos:
#         if i == 0: zero_num += 1
#         elif i in win_nums: correct_num += 1
#         print(i,correct_num, zero_num)
            
#     answer = [correct_num, correct_num + zero_num]
    
#     return answer

# print(solution(lottos, win_nums))


'''
def solution(new_id):
    step1 = new_id.lower()
    step2 = ''
    for i in range (0, len(step1)):
        asc = ord(step1[i])        
        if (asc >= 97 and asc <= 122) or (asc >= 48 and asc <= 57) or (asc == 45) or (asc == 95) or (asc == 46):
            step2 = step2+ step1[i]
        
    step3 = step2.replace('..','.')
    
    if step3[0] == '.':
        step4 = step3[2:]
    elif step3[-1] == '.':
        step4 = step3[:-1]
    else:
        step4 = step3
    
    if step4 == '': step5 = 'a'
    else: step5 = step4

    if len(step5) >= 16:
        step6 = step5[:15]
    else: step6 = step5

    if step6[-1] == '.': step6 = step6[:-1]
    
    if len(step6) <= 2:
        for _ in range(0, 3 - len(step6)):
            step6 = step6 + step6[-1]
    
    answer = step6
                       
    return answer

print(solution(	"abcdefghijklmn.p"))
'''

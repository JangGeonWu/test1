import requests
from bs4 import BeautifulSoup

url = "https://sesac.seoul.kr/course/active/detail.do"
res = requests.get(url)
res.raise_for_status()

soup = BeautifulSoup(res.text, "lxml")
# print(soup.title)
# print(soup.title.get_text())

als = soup.find_all("p", attrs={"class":"sub"})

title = als[0].get_text()
print(title)

print(len(als))
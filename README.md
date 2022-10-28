> Springboot로 마이그레이션을 진행하였습니다</br>
 https://geondev.github.io/project-vig-1/
 
 > VIG의 로그 정리 및 벤유저 자동 복구를 수행하는 데몬입니다.<br/>
 https://github.com/GeonDev/VigDaemon



# VIG(Visual Inspiration Gallery)
사용자 맞춤형 이미지 검색 기반 포트폴리오(핀터레스트 & 비헨스) 클론 프로젝트 입니다.   
머리속에 있는 막연한 이미지와 유사한 이미지를 찾고 싶을때 사용자의 검색기록, 키워드 등을 활용하여<br/>
찾고 있는 이미지와 가장 유사한 이미지를 찾을수 있도록 도와줍니다.


## 시연 동영상
[![VIG](https://images.velog.io/images/kada/post/358fb045-9759-4c03-9337-e35cf1fe9f99/t1.JPG)](https://www.youtube.com/watch?v=Ck9diBmMfdU) 
이미지를 클릭하시면 유튜브로 이동합니다.

# Screenshot

<img src="https://user-images.githubusercontent.com/24502814/104086667-2b9d3c00-529d-11eb-8015-961d9042cb6f.PNG" width="900" /></br>
###### 메인 페이지
<img src="https://user-images.githubusercontent.com/24502814/104086668-2dff9600-529d-11eb-892d-29407e197275.PNG" width="900" /></br>  
###### 피드 검색
<img src="https://user-images.githubusercontent.com/24502814/110430282-7a295400-80ef-11eb-8e8f-41fafce692c9.JPG" width="900" /></br> 
###### 이미지 검색
<img src="https://user-images.githubusercontent.com/24502814/104086670-2f30c300-529d-11eb-91d2-5439e41487a9.PNG" width="900" /></br>  
###### 유저 검색
<img src="https://user-images.githubusercontent.com/24502814/110430280-78f82700-80ef-11eb-9b90-18ec737cb398.JPG" width="900" /></br>  
###### 피드 상세(키워드, 색상 추출)
<img src="https://user-images.githubusercontent.com/24502814/110430290-7bf31780-80ef-11eb-848e-fe63dc580c04.JPG" width="900" /></br>  
###### 이미지 상세(유사 이미지 추천)
<img src="https://user-images.githubusercontent.com/24502814/110430271-7695cd00-80ef-11eb-89f7-4a146f967600.JPG" width="900" /></br>
###### 마이 피드

# 적용 내용
#### 1. java 1.8
#### 2. Spring 5.0 -> Springboot 2.4.2
#### 3. MariaDB 10.4
#### 4. Mybatis 3.2.1 -> JPA 적용중
#### 5. MAVEN 3.6.3
#### 6. JSTL/EL

## 기타 적용 
###### * apache tomcat 9 사용
###### * bootstrap 4.0/MDB 적용
###### * Ajax/RestFul 서버 적용
###### * Web socket(실시간 알람) 적용
###### * google API(login, VISION, TRANS) 적용 
###### * 결제(I'm port) 적용
###### * log4j2, AOP 적용
###### * DB URL 암호화(Jasypt)
###### * AWS EC2/ RDS 배포
   
   
## 참고 사항
###### * 어드민 계정: admin/1234
###### * 일반 유저 : user01/1111
###### * UTF-8로 인코딩
###### * eclipse로 개발되었습니다.

<b>이미지 정보 추출, 검색을 위해서는 구글 API 키가 필요합니다.</b> 

## AWS EC2 주소 
~~http://13.125.196.55:8080/VIG/~~  
(접속량/ 용량 문제로 인스턴스가 꺼져있는 경우가 있을수 있습니다.)



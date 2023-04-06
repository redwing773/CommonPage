# Portal WEB

### Technology Stack

Component         | Technology
---               | ---
Poject Name       | Portal WEB
Frontend          | 
Backend           | Spring Boot 2.7.3+, Java 11+
Security          |
Auth              |
Database          | 
Persistence       |
API Documentation | Swagger-UI 3.0.0+ (springfox)
Config            | YAML
Log               | logback
Client Build      |
Server Build      | Gradle
Coding Style      | intelliJ-java-google-style

### Webpack 사용법
__1. npm 패키지 설치__   
```aidl
npm install
```
__2. 빌드__
```
npm start
```
해당 명령어를 실행하면 ./dist 경로에 폴더 및 파일이 생성됩니다.   
local에서는 resources 경로, 그 외 환경에서는 dist 경로를 바라보게 됩니다.   
(Webpack Class에서 강제로 경로를 변경해서 local에서 dist 테스트 가능)   
__3. JSP 태그__   
상단에 아래 코드를 추가합니다.
```
<%@ taglib prefix="webpack" uri="/WEB-INF/tlds/webpack.tld" %>
```
jsp에서 사용할 resources 파일 경로는 아래와 같이 사용합니다. (resources 하위 폴더부터 기재합니다.)
```aidl
<script type="module" src="${webpack:getManifestResource('js/presentation/index.js')}"></script>
```
__4. library 관리__   
css, js 하위 library 폴더는 소스 코드 압축 및 dist 폴더의 파일과 매칭 작업에서 배제합니다.   
(library는 반드시 해당 폴더에 추가)


---
## 퍼블리싱작업(마크업)
### 퍼블 NPM
```
npm run dev-pub
- 웹팩데브서버(포트 8083) - 포털GNB호출을 위한 포트번호
- sass 컴파일사용 - 특정폴더에 적용
```
- src/main/webapp/html/ 의 html 사용
- src/main/webapp/resources/css/portalPage/scss/style.scss 사용(이 파일이 상위폴더로 동일한 이름의 css로 컴파일)

- src/main/webapp/resources/js/portalPage/ui.js 사용  
- webpack.pub.config.js 는 퍼블용 웹팩 config파일

> 그외 내재화되지 않은 질문톡,멘토칼럼은 src/main/resouces에 있음

## 퍼블리싱작업(마크업)
# 퍼블 NPM
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

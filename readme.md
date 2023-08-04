# 이투스 공통페이지 퍼블리싱작업

npm run dev-pub
- 웹팩데브서버(포트 8083) - 포털GNB호출을 위한 포트번호
- sass 컴파일사용 - 특정폴더에 적용

- src/main/webapp/html/ 의 html 사용
- src/main/webapp/resources/css/portalPage/scss/style.scss 사용(이 파일이 상위폴더로 동일한 이름의 css로 컴파일)
- src/main/webapp/resources/js/portalPage/ui.js 사용
- webpack.pub.config.js 는 퍼블용 웹팩 config파일
> 그외 내재화되지 않은 질문톡,멘토칼럼은 src/main/resouces에 있음

## 환경 및 설정
호환성  
- chrome, edge, safari, 네이버 등 최신버전 브라우저
- 모바일 최소사이즈 360px(320px은 일부 잘리는 수준)
웹 표준  
- 웹 표준을 준수
웹퍼블리싱 컨벤션  
- HTML/CSS Markup & Style Guide
git 버전관리  
- https://gitlab.linker.ac/portal-development-team/portal-project/portal-main
- develop기준으로 브랜치 생성하여 작업 후 개발자에게 전달
폴더 구조  
[HTML]  
html/portalPage  
    |-- CommonPage_6p_before.html - PC 메인 HTML  
    |-- m-CommonPage_6p_before.html 모바일 메인 HTML  
    |-- 위와 같이 서비스별로 메인 html 확인  
html/portalPage/modules/  
        |-- CommonPageTopBanner.html  
        |-- CommonPageTopContent.html  
        |-- CommonPageFooter.html  
        |-- m_CommonPageTopBanner.html  
        |-- m_CommonPageTopContent.html  
        |-- m_CommonPageFooter.html  
        |-- 상황에 따라 다른 모듈이 있을 수 있음  
html/portalPage/modules/3p_module(서비스별 모듈 폴더)  
            |-- CommonPage-tab1.html  
            |-- CommonPage-tab2.html  
            |-- CommonPage-tab3.html  
            |-- CommonPage-tab4.html  
            |-- CommonPage-tab5.html  
            |-- m_CommonPage-tab1.html  
            |-- m_CommonPage-tab2.html  
            |-- m_CommonPage-tab3.html  
            |-- m_CommonPage-tab4.html  
            |-- m_CommonPage-tab5.html  
            |-- 상황에 따라 다른 모듈이 있을 수 있음  


[CSS]
resources/css/portalPage  
    |-- style.css(배포용 css)  
    |-- m_style.css  
    |-- 3p.css  
    |-- m_3p.css  
resources/css/portalPage/scss  
        |-- style.scss(default scss)  
        |-- m_style.scss  
        |-- 3p.scss(서비스별 scss)  
        |-- m_3p.scss  
resources/css/portalPage/scss/modules  
            |-- _mixin.scss  
            |-- 상황에 따라 다른 모듈이 더 있을 수 있음  
resources/css/portalPage/scss/modules/3p_tab(서비스별 모듈 폴더)  
                |-- _tab_layout.scss  
                |-- _tab1.scss  
                |-- _tab2.scss  
                |-- _tab3.scss  
                |-- _tab4.scss  
                |-- _tab5.scss  
                |-- _m_tab_layout.scss  
                |-- _m_tab1.scss  
                |-- _m_tab2.scss  
                |-- _m_tab3.scss  
                |-- _m_tab4.scss  
                |-- _m_tab5.scss  
 

[JS]  
resources/js/portalPage  
    |-- ui.js(web/mobile 공용)  
    |-- entry.js(webpack용 파일 - 빈파일)  
resources/js/portalPage/modules  
        |-- 3p.js(서비스별 스크립트)  
        |-- Constant.js(상수 및 서비스별 모듈 파일 연결)  
        |-- TabsFunc.js(탭관련 동작)  
 
[IMAGES]  
https://eim.etoos.com/ 에 파일 업로드(live)  
경로 : https://resource-portal.etoos.com/common-page/static/파일명  
## 파일 구조  
HTML  

메인 HTML에서 topBanner, topContent, tab1~5, footer 의 모듈 HTML을 불러오는 구조  
topBanner는 해당 html에 인터널css로 작성  
topContent는 만약 tab이 없는 서비스일 경우 이 파일에 모든 콘텐츠 작성  
아래 부분 data-service에 서비스 타입 작성, data-service-type은 사전, 사후로 나뉠 경우 추가작성  
<div class="top_container" id="top_content" data-service="CommonPage6p" data-service-type="after">  
탭 헤드부분(선택버튼들 영역)은 admin에서 추가하는 것으로 별도 class추가가 불가능하여 script로 필요 시 "main_wrap .tab_wrap"에 before 또는 after 추가  
공통팝업 .popup_wrap > #popup_type1 > .box-cont > .txt[내용] + a.confirm 와 같은 형태  
CSS  

SASS 적용  
서비스별  ex> 3p.css 를 메인 html에 추가해서 사용  
style.scss는 기본, 레이아웃 등이 포함  
서비스별 scss에 topContent, 사용할 tab import  
JS  

퍼블본 JS는 개발에서 미사용 - 퍼블본 JS(ui.js) 개발에서 퍼블본 참고하여 common-page/index.js로 사용 중  
ui.js 에서 tobBanner, topContent > tabsFunc > 서비스.js, footer를 불러와서 실행  
Images  

이미지는 git에 직접 등록했으나 https://eim.etoos.com/ 에 업로드하여 경로를 직접 적용하는 것으로 변경  


작업안내  
새 서비스 작업 시 탭이 없는 경우  
메인이되는 서비스html 작성 후 topBanner, topContent html 작성  
서비스 scss작성 후 html에 css연결  
서비스 js작성 후 ui.js에서 import, topContent 로드 후 import 된 것 실행  
Constant.js에서 파일연결  


새 서비스 작업 시 탭이 있는 경우 - 보통 before, after도 있음  
메인이 되는 서비스html 작성 후 modules폴더 및에 서비스전용 모듈폴더 생성 후 topBanner, topContent, tab파일 들 작성(필요 시 파일명에 before, after로 구분되도록 작성)  
서비스 scss작성 후 html에 css연결  
modules폴더 및에 서비스전용 모듈폴더 생성 후 tablayout, tab들 작성, 서비스scss에 연결(클래스명으로 before, after로 구분되도록 작성하여 1개 파일안에 작성)  
서비스js 작성 후 ui.js에서 서비스top 부분 import, TabFunc에서 서비스별 js import  





<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="script_file" fragment="true" required="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="webpack" uri="/WEB-INF/tlds/webpack.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@environment.getProperty('spring.config.activate.on-profile')" var="activeProfile" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/tags/pc/head.tag" %>
</head>
<body>

<c:if test="${activeProfile eq 'dev'}">
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-TPZXZ6K"
                      height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->
</c:if>

<c:if test="${activeProfile eq 'qa'}">
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-WDGZTMV"
                      height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->

    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-P9PPVM9"
                      height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->
</c:if>

<c:if test="${activeProfile eq 'live'}">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-K85LNHK"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5FGHQ98"
                  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
</c:if>

    <jsp:doBody/>

    <div id="alertPopup" class="popup_all"></div>
    <script type="text/javascript">
        window.onload = function(){
            <%-- 공통 --%>
            $(document).on("click", ".logo", function () {
                if(tms.isEmpty(prev)){
                    location.href = common.urlInfo.index;
                }else{
                    location.href = common.urlInfo.index+"?prev="+prev;
                }
            });
            $(document).on("click", ".btn_go_login", function (event) {
                event.preventDefault();

                if(tms.isEmpty(prev)){
                    location.href = common.urlInfo.login;
                }else{
                    location.href = common.urlInfo.login+"?prev="+prev;
                }
            });
            $(document).on("click", ".btn_go_idFind", function () {
                if(tms.isEmpty(prev)){
                    location.href = common.urlInfo.findId;
                }else{
                    location.href = common.urlInfo.findId+"?prev="+prev;
                }
            });
            $(document).on("click", ".btn_go_pwFind", function () {
                if(tms.isEmpty(prev)){
                    location.href = common.urlInfo.findPwd;
                }else{
                    location.href = common.urlInfo.findPwd+"?prev="+prev;
                }
            });
            $(document).on("click", ".btn_go_mentee_join", function () {
                if(tms.isEmpty(prev)){
                    location.href = common.urlInfo.join + "?mentoringType=mentee";
                }else{
                    location.href = common.urlInfo.join + "?mentoringType=mentee&prev="+prev;
                }
            });
            $(document).on("click", ".btn_go_mentor_join", function () {
                if(tms.isEmpty(prev)){
                    location.href = common.urlInfo.join + "?mentoringType=mentor";
                }else{
                    location.href = common.urlInfo.join + "?mentoringType=mentor&prev="+prev;
                }
            });
            <%-- 공통 모바일웹 --%>
            $(document).on("click", ".logo_mo", function () {
                if(tms.isEmpty(prev)){
                    location.href = contextPath + "/";
                }else{
                    location.href = contextPath + "/?prev="+prev;
                }
            });
            $(document).on("click", ".btn_go_login_mo", function (event) {
                event.preventDefault();

                if(tms.isEmpty(prev)){
                    location.href = contextPath + "/page/membership-mo/login";
                }else{
                    location.href = contextPath + "/page/membership-mo/login?prev="+prev;
                }
            });
            $(document).on("click", ".btn_go_idFind_mo", function () {
                if(tms.isEmpty(prev)){
                    location.href = contextPath + "/page/membership-mo/idFind";
                }else{
                    location.href = contextPath + "/page/membership-mo/idFind?prev="+prev;
                }
            });
            $(document).on("click", ".btn_go_pwFind", function () {
                if(tms.isEmpty(prev)){
                    location.href = contextPath + "/page/membership-mo/pwFind";
                }else{
                    location.href = contextPath + "/page/membership-mo/pwFind?prev="+prev;
                }
            });
            $(document).on("click", ".btn_go_mentee_join_mo", function () {
                if(tms.isEmpty(prev)){
                    location.href = contextPath + "/page/membership-mo/join";
                }else{
                    location.href = contextPath + "/page/membership-mo/join?prev="+prev;
                }
            });
            $(document).on("click", ".awl_header_l > img", function () {
                location.href = contextPath + "/page/portal/talk/list";
            });
        }
    </script>

    <%@ include file="/WEB-INF/tags/pc/script.tag" %>
    <%@ include file="/WEB-INF/view/tmpl/pc/commonTmpl.tag" %>

    <jsp:invoke fragment="script_file"/>
    <style>
      /* Popup */
      .layer-popup {position:fixed;left:0;top:50px;width:100%;height:100%;display:-webkit-flex;display:flex;align-items:center;justify-content:center;flex-direction:column;z-index:511;}
      .layer-popup::before {content:'';position:fixed;left:0;top:0;right:0;bottom:0;display:block;width:100%;height:100%;background: rgba(0,0,0,0.8);z-index: 0;}
      .layer-popup.hide {display:none !important;}
      .layer-popup > div {position:relative;padding-bottom:41px;width:368px;border-radius:6px 6px 0 0;background-color:#fff;z-index:1;}
      .layer-popup .btn-close {width:368px;height:56px;border-radius:0 0 6px 6px;background-color: #BDC1CD;font-size:16px;font-weight:700;color: #fff;z-index:1;}
      .layer-popup .btn-close-x {position:absolute;top:10px;right:10px;width:26px;height:26px;background:url('/resources/images/portalTok/icon_close.png') no-repeat;background-size:26px auto;font-size:0;line-height:0;text-indent:-9999px;z-index:10;}

      .layer-popup .common-error-wrap {padding:51px 16px 41px;box-sizing:border-box;}
      /* .layer-popup .common-error-wrap .common-error-box {padding-top:51px;} */
      .layer-popup .common-error-wrap .common-error-box.inspection-box {padding-top:166px;}
      .layer-popup .common-error-wrap .common-error-box.error-box {padding-top:216px;}
      .layer-popup .common-error-wrap .common-error-box .emoji {display:block;margin:0 auto 24px;}
      .layer-popup .common-error-wrap .common-error-box .emoji.error-check {width:160px;}
      .layer-popup .common-error-wrap .common-error-box .emoji.error-temporary {width:160px;}
      .layer-popup .common-error-wrap .common-error-box .title {font-size:16px;font-weight:700;color:#242424;letter-spacing:-0.02em;text-align:center;}
      .layer-popup .common-error-wrap .common-error-box .desc {padding-top:7px;font-size:14px;font-weight:400;color:#676767;letter-spacing:-0.02em;text-align:center;}
      .layer-popup .common-error-wrap .common-error-box .notice-box {margin-top:30px;padding:18px 0;border-radius:12px;background-color:#FFF0E8;}
      .layer-popup .common-error-wrap .common-error-box .notice-box p {font-size:14px;font-weight:500;color: #FF5C00;letter-spacing:-0.02em;text-align:center;line-height: 1.7;}
    </style>
    <jsp:include page="/WEB-INF/tiles/layout/popup.jsp" />
    <script type="module" src="${webpack:getManifestResource('js/common.js')}"></script>
    <!-- portal error popup -->
</body>
</html>

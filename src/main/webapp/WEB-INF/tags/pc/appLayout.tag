<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="script_file" fragment="true" required="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@environment.getProperty('spring.config.activate.on-profile')" var="activeProfile" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/tags/pc/head.tag" %>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/pc/common/css/app_custom.css?ver=202210312" />
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

    <div id="top_banner">
        <p class="tit">상단 고정 팝업</p>
        <button type="button" class="btn_close"><span class="blind">닫기</span></button>
    </div>
    <%@ include file="/WEB-INF/tags/pc/inc/header.tag" %>

    <jsp:doBody/>


    <div id="alertPopup" class="popup_all"></div>

    <%@ include file="/WEB-INF/tags/pc/inc/footer.tag" %>
    <%@ include file="/WEB-INF/tags/pc/script.tag" %>
    <%@ include file="/WEB-INF/view/tmpl/pc/commonTmpl.tag" %>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/api/myPage_api.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/pc/common/js/common_lnb.js?ver=2022110322"></script>
    <jsp:invoke fragment="script_file"/>
</body>
</html>

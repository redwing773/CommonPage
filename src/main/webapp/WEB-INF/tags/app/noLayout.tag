<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="script_file" fragment="true" required="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@environment.getProperty('spring.config.activate.on-profile')" var="activeProfile" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/tags/app/head.tag" %>
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

    <div id="alertPopArea" class="popup_all"></div>

    <script>

        <%-- header 공통값 --%>
	    var authorization = tms.getCookie('linker_token');
        var hipId = tms.getCookie('hipid');
        var osType = tms.getCookie('ostype');
        var appVersion = tms.getCookie('appversion');
        var deviceId = tms.isEmpty(tms.getCookie('deviceid')) ? 'linker-web-20200312' : tms.getCookie('deviceid');
        var headerDeviceType = tms.getCookie('devicetype');
        var mentorYn = tms.getCookie('mentoryn');
        var systemEnv = "${activeProfile}";
        var etoosToken =  tms.getCookie('etoostoken');
        var integratedMemberNo  = tms.getCookie('integratedmemberno');
    </script>
    
    <%@ include file="/WEB-INF/tags/app/script.tag" %>
    <%@ include file="/WEB-INF/view/tmpl/app/commonTmpl.tag" %>
    <jsp:invoke fragment="script_file"/>
</body>
</html>

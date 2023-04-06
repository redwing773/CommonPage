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
<body class="footer_layout">
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

<!-- id : footer -->
<footer id="footer">
    <div class="inner_box">
        <div class="ft_info">
            <div>플랫비㈜ (대표 이종서)</div>
            <div>사업자등록번호 : 649-86-01526</div>
            <div>서울시 서초구 남부순환로 2547 (서초동 1354-3)v</div>
            <div>
                <span class="contact_tel">070-8859-8583</span>
                <span class="contact_email"><a href="mailto:support@ilinker.co.kr">support@ilinker.co.kr</a></span>
            </div>
        </div>
    </div><!-- class : inner_box -->
</footer>
<!-- id : footer -->

<div id="alertPopArea" class="popup_all"></div>

<script>
    <%-- hader 공통값 --%>
    var authorization = "${authorization}";
    var hipId = "${hipid}";
    var osType = "${ostype}";
    var appVersion = "${appversion}";
    var deviceId = "linker-web-20200312";
    var headerDeviceType = "${devicetype}";

</script>
<%@ include file="/WEB-INF/tags/app/script.tag" %>
<%@ include file="/WEB-INF/view/tmpl/app/commonTmpl.tag" %>
<jsp:invoke fragment="script_file"/>
</body>
</html>

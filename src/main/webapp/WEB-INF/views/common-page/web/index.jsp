<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="webpack" uri="/WEB-INF/tlds/webpack.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
    환경 별 javascript 로딩
    local : project 내
    dev,qa : s3 (dev)
    live : s3 (live)
 --%>
<spring:eval expression="@environment.getProperty('spring.config.activate.on-profile')"
             var="activeProfile"/>
<head>
    <title>이투스</title>
    <c:choose>
        <c:when test="${activeProfile eq 'local'}">
            <link rel="stylesheet" type="text/css"
                  href="${webpack:getManifestResource('css/portalPage/style.css')}"/>
        </c:when>
        <c:when test="${activeProfile eq 'live'}">
            <c:set var="timestamp" value="<%=new java.util.Date().getTime()%>"/>
            <link rel="stylesheet" type="text/css"
                  href="https://resource-portal.etoos.com/common-page/css/style.css?${timestamp}"/>
        </c:when>
        <c:otherwise>
            <c:set var="timestamp" value="<%=new java.util.Date().getTime()%>"/>
            <link rel="stylesheet" type="text/css"
                  href="https://dev-resource-portal.etoos.com/common-page/css/style.css?${timestamp}"/>
        </c:otherwise>
    </c:choose>
</head>
<body>
<div id="top_bar" class="top_bn"></div>

<!-- Common page -->
<div class="main_wrap">
    <div class="top_container" id="top_content">

        <!-- floating banner -->
        <div class="floating_bn" id="floating_banner_wrap" style="display:none;">
        </div>
    </div>

    <div class="tab_wrap">
        <div class="tab_head">
            <ul id="tab_ul">
            </ul>
        </div>
        <div class="tab_body" id="tab_body"></div>
        <div class="toTop">
            <button type="button">top</button>
        </div>
    </div>
</div>

<input type="hidden" id="select_tab" value="${tab}">
<input type="hidden" id="select_tab_detail" value="${tabDetail}">
<input type="hidden" id="address" value="">
<input type="hidden" id="address_detail" value="">
<input type="hidden" id="zipcode" value="">
<jsp:include page="../index_template.jsp"/>
<script src="${webpack:getManifestResource('js/library/swiper.min.js')}"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<c:choose>
    <c:when test="${activeProfile eq 'local'}">
        <script type="module"
                src="${webpack:getManifestResource('js/common-page/index.js')}"></script>
    </c:when>
    <c:when test="${activeProfile eq 'live'}">
        <c:set var="timestamp" value="<%=new java.util.Date().getTime()%>"/>
        <script type="module"
                src="https://resource-portal.etoos.com/common-page/js/index.js?${timestamp}"></script>
    </c:when>
    <c:otherwise>
        <c:set var="timestamp" value="<%=new java.util.Date().getTime()%>"/>
        <script type="module"
                src="https://dev-resource-portal.etoos.com/common-page/js/index.js?${timestamp}"></script>
    </c:otherwise>
</c:choose>

</body>
</html>
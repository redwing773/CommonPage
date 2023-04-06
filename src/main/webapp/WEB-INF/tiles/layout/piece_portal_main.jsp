<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webpack" uri="/WEB-INF/tlds/webpack.tld" %>
<spring:eval expression="@environment.getProperty('spring.config.activate.on-profile')" var="activeProfile" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport"
          content="user-scalable=no, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0, width=device-width" />
    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
    <c:choose>
        <c:when test="${device eq 'web'}">
            <link rel="stylesheet" type="text/css" href="${webpack:getManifestResource('css/common_style.css')}" />
        </c:when>
        <c:otherwise>
            <link rel="stylesheet" type="text/css" href="${webpack:getManifestResource('css/m_common_style.css')}" />
        </c:otherwise>
    </c:choose>
    <link rel="stylesheet" type="text/css" href="${webpack:getManifestResource('css/style.css')}" />
    <link rel="stylesheet" type="text/css" href="${webpack:getManifestResource('css/library/swiper.min.css')}" />
<%--    <title>Etoos Portal</title>--%>

    <jsp:include page="./script/utm.jsp"/>
</head>
<body>
    <tiles:insertAttribute name="content"/>

    <jsp:include page="popup.jsp"/>
    <script src="${webpack:getManifestResource('js/library/swiper.min.js')}"></script>
    <script src="${webpack:getManifestResource('js/library/jquery.min.js')}"></script>
    <script src="${webpack:getManifestResource('js/library/handlebars.min.js')}"></script>
    <script src="${webpack:getManifestResource('js/library/crypto-js.min.js')}"></script>
    <script type="module" src="${webpack:getManifestResource('js/common.js')}"></script>
    <script src="${webpack:getManifestResource('js/library/etoos.sdk.ie.js')}"></script>

    <jsp:include page="./script/gtm.jsp"/>
</body>
</html>
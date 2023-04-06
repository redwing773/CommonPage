<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@environment.getProperty('spring.config.activate.on-profile')" var="activeProfile" />
<c:choose>
    <c:when test="${activeProfile eq 'local'}">
        <c:set var="gnbDomain" value="https://dev-gnb.etoos.com"/>
    </c:when>
    <c:when test="${activeProfile eq 'dev'}">
        <c:set var="gnbDomain" value="https://dev-gnb.etoos.com"/>
    </c:when>
    <c:when test="${activeProfile eq 'qa'}">
        <c:set var="gnbDomain" value="https://qa-gnb.etoos.com"/>
    </c:when>
    <c:when test="${activeProfile eq 'live'}">
        <c:set var="gnbDomain" value="https://gnb.etoos.com"/>
    </c:when>
</c:choose>

<c:choose>
    <c:when test="${device eq 'app'}">
        <c:set var="gnbDisplay" value='style="display:none;"'/>
    </c:when>
    <c:otherwise>
        <c:set var="gnbDisplay" value=""/>
    </c:otherwise>
</c:choose>
<div id="portalGnb" ${gnbDisplay}></div>

<c:set var="timestamp" value="<%=new java.util.Date().getTime()%>"/>
<script async type="text/javascript" src="${gnbDomain}/v1/gnb.js?${timestamp}" id="gnbService" data-service="portal" data-device="${device}"></script>

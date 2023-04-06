<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webpack" uri="/WEB-INF/tlds/webpack.tld" %>
<!DOCTYPE html>
<html>
<head lang="ko">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport"
          content="user-scalable=no, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0, width=device-width"/>
    <link rel="stylesheet" type="text/css" href="${webpack:getManifestResource('css/style.css')}" />
</head>
<body>
    <div class="common-error-wrap">
        <div class="common-error-box error-box">
            <img src="/resources/images/portalTok/icon_emoji_error_temporary.png" alt="" class="emoji error-temporary" />
        <p class="title">일시적인 오류가 발생했습니다.</p>
            <p class="desc">서비스 이용에 불편을 드려 매우 죄송합니다.</p>
        </div>
    </div>
</body>
</html>
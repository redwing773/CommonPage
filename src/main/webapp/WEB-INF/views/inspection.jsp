<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
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
    <div class="common-error-box inspection-box">
        <img src="/resources/images/icon_emoji_error_check.png" alt="" class="emoji error-check" />
        <p class="title">현재 점검 중입니다.</p>
        <p class="desc">안정적인 서비스를 위해 점검을 진행하고 있습니다.</p>
        <div class="notice-box">
            <p class="notice"></p>
        </div>
    </div>
</div>

</body>
</html>
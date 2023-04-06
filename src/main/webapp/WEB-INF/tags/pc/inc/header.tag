<%@tag pageEncoding="UTF-8" %>
<header id="rwd_header">
    <div class="inner_box">
        <div class="pc_header" style="max-width:1400px;margin:0 auto;">
            <h1 class="logo"><a href="${pageContext.request.contextPath}/"><span class="blind">Linker</span></a></h1>

         <%--   <div class="app_link">
                <a href="#self" class="btn_google" onclick="goGoogle()"><span class="blind">Google Play</span></a>
                <a href="#self" class="btn_app" onclick="goApp()"><span class="blind">App Store</span></a>
            </div>--%>

            <nav id="rwd_gnb" class="gnb">
                <ul>
                    <%--<li  style="" data-value="purchase"><a href="${pageContext.request.contextPath}/">모지 합격예측</a></li>--%>
                    <li class="current" data-value="mentalk"><a href="${pageContext.request.contextPath}/">입시정보</a></li>
                    <li style="display: none;" data-value="mentoring"><a href="${pageContext.request.contextPath}/page/intro/mentoring">멘토링</a></li>
                    <li style="display: none;" data-value="lesson"><a href="${pageContext.request.contextPath}/page/intro/lesson">과외</a></li>
                    <li style="display: none;" data-value="menteeMentoring"><a href="${pageContext.request.contextPath}/page/mentee/mentoring">멘토링</a></li>
                    <li style="display: none;" data-value="menteeLesson"><a href="${pageContext.request.contextPath}/page/mentee/lesson">과외</a></li>
                    <li class="jq_simple_user_hide" style="display: none;" data-value="mylinker"><a href="${pageContext.request.contextPath}/page/myLinker/purchaseList">활동</a></li>
                    <li><a href="${pageContext.request.contextPath}/page/service/guide">이용가이드</a></li>
                        <%--<li><a href="${pageContext.request.contextPath}/page/service/introduce">회사소개</a></li>--%>
                        <%--<li><a href="#self">회사소개</a></li>--%>
                </ul>
            </nav>
            <ul class="login_menu">
                <li><a class="isEtoos" href="#self" onClick="common.startPotal();" style="display: none;"></a></li>
                <li><a href="#self" onClick="common.loginMembership();">로그인</a></li>
                <li><a href="#self" onClick="common.joinMembership();">회원가입</a></li>
            </ul>
        </div>
        <div class="mo_header">
            <h2 class="title"></h2>
            <ul class="login_menu_mo">
                 <li><a class="isEtoos" href="#self" onClick="common.startPotal();" style="display: none;"></a></li>
                 <li><a href="#self" onClick="common.loginMembership_mo();">로그인</a> | </li>
                 <li><a href="#self" onClick="common.joinMembership_mo();">회원가입</a></li>
             </ul>
             <%--
             <div class="app_link">
                 <a href="#self" class="btn_google" onclick="goGoogle()"><span class="blind">Google Play</span></a>
                 <a href="#self" class="btn_app" onclick="goApp()"><span class="blind">App Store</span></a>
             </div>
             --%>
        </div>
    </div>
</header>

<div id="util_layer"></div>
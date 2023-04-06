<%@tag pageEncoding="UTF-8" %>
<footer id="rwd_footer">
    <div class="pc_footer">
        <div class="inner_box">
            <h2 class="title">플랫비 주식회사</h2>
            <ul class="ft_menu">
                <li><a href="${pageContext.request.contextPath}/page/service/introduce">회사소개</a></li>
                <%--<li><a href="">서비스 소개</a></li>--%>
                <li><a href="${pageContext.request.contextPath}/page/terms?no=1">이용약관</a></li>
                <li><a href="${pageContext.request.contextPath}/page/terms?no=2">개인정보처리방침</a></li>
            </ul>
            <ul class="ft_info">
                <li><strong>사업자등록번호</strong>649-86-01526</li>
                <li><strong>대표이사</strong>이종서</li>
                <li><strong>연락처</strong>070-8859-8583</li>
                <li><strong>이메일</strong>linker@ilinker.co.kr</li>
                <li><strong>주소</strong>서울시 서초구 남부순환로 2547 (서초동 1354-3)</li>
                <li><strong>직업정보제공사업 신고번호</strong> 서울청 제2022-1호</li>
                <li><strong>통신판매번호 </strong> 2020-서울서초-3725</li>
            </ul>
            <div class="app_link">
                <li><button class="btn_google" onclick="goGoogle()"><span>Google Play</span></button></li>
                <li><button class="btn_app" onclick="goApp()"><span>App Store</span></button></li>
            </div>
            <p class="copyright">CopyrightⒸ 2020 linker. All Rights Reserved</p>
            <a href="${pageContext.request.contextPath}/page/service/introduce" class="btn_introduce">회사소개</a>
            <a href="#top" class="btn_top"><span>TOP</span></a>
        </div>
    </div>
    <div class="mo_footer">
<%--        <div style="position: fixed;width: 45px; height: 45px;right: 16px;bottom: 70px;">--%>
<%--            <img src="${pageContext.request.contextPath}/pc/images/app_down_mo.png" onclick="goDownAppMo()" style="width: 45px; height: 45px;">--%>
<%--        </div>--%>
        <nav class="nav">
            <ul>
                <%--<li><a href="${pageContext.request.contextPath}/" class="i0"><span>합격예측</span></a></li>--%>
                <li class="current"><a href="${pageContext.request.contextPath}/" class="i1"><span>입시정보</span></a></li>
                <li><a href="${pageContext.request.contextPath}/page/intro/mentoring" class="i2"><span>멘토링</span></a></li>
                <li><a href="${pageContext.request.contextPath}/page/intro/lesson" class="i3"><span>과외</span></a></li>
                <li style="display: none;"><a href="${pageContext.request.contextPath}/page/myLinker/purchaseList" class="i3"><span>활동</span></a></li>
                <li><a href="${pageContext.request.contextPath}/page/service/guide" class="i4"><span>이용가이드</span></a></li>
                <%--<li><a href="${pageContext.request.contextPath}/page/service/introduce" class="i5"><span>회사소개</span></a></li>--%>
</ul>
</nav>
</div>
</footer>

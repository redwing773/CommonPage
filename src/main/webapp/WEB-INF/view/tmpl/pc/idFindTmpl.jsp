<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="idFindTmpl" type="text/x-jquery-tmpl">
    <div class="in_box">
        <h1 class="logo"><img src="${pageContext.request.contextPath}/pc/images/logo_small.png" alt="" /><span>입시의 모든 것을 해결하다</span></h1>
        <h2 class="title">아이디 찾기</h2>
        <p class="comment">본인확인을 위하여 휴대폰인증이 필요합니다.</p>
        <p class="mb10"><span class="input_box"><input type="text" name="phoneNumber" placeholder="휴대폰번호 입력" maxlength="11"/><a href="#self" class="btn_send">발송</a></span></p>
        <p class="mb10"><span class="input_box"><input type="text" name="secretCode" disabled="disabled" placeholder="인증번호 입력" maxlength="4"/><span id="timer" class="timer"></span></span></p>
        <div id="secretCode_err" class="error_txt" style="display:none;">에러텍스트</div>
        <a href="#self" id="btn_certify" class="btn_confirm btn_48 btn_disabled">다음</a>
    </div>
</script>

<script id="idFindSuccessTmpl" type="text/x-jquery-tmpl">
    <div class="in_box">
        <h1 class="logo"><img src="${pageContext.request.contextPath}/pc/images/logo_small.png" alt="" /><span>입시의 모든 것을 해결하다</span></h1>
        <h2 class="title">아이디 찾기</h2>
        <p class="id_text1">고객님의 아이디는</p>
        <p class="id_text2"><strong>\${emailId}</strong> 입니다.</p>
        <a href="#self" class="btn_confirm btn_go_login">로그인 하러가기</a>
        <div class="txt_box">
            비밀번호가 기억나지 않는 경우 <a href="#self" class="btn_go_pwFind">비밀번호 찾기 &gt;</a>
        </div>
    </div>
</script>

<script id="idFindFailTmpl" type="text/x-jquery-tmpl">
    <div class="in_box">
        <h1 class="logo"><img src="${pageContext.request.contextPath}/pc/images/logo_small.png" alt="" /><span>입시의 모든 것을 해결하다</span></h1>
        <h2 class="title double">입력하신 정보로<br />등록된 회원이 없습니다.</h2>
        <p class="comment">정보를 다시 확인하시고 시도해주세요.</p>
        <a href="#self" class="btn_confirm btn_48 c_blue btn_go_login">확인</a>
        <div class="sub_tit"><em>or</em></div>
        <div class="btns">
            <a href="#self" class="btn_go_mentee_join"><span><strong>멘티</strong>로 가입하기</span></a>
            <a href="#self" class="btn_go_mentor_join"><span><strong>멘토</strong>로 가입하기</span></a>
        </div>
    </div>
</script>

<script id="idFindTmpl_mo" type="text/x-jquery-tmpl">
    <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    <div class="in_box">
        <h2 class="title">아이디 찾기</h2>
        <p class="comment">본인확인을 위하여 휴대폰인증이 필요합니다.</p>
        <p class="mb10"><span class="input_box"><input type="text" name="phoneNumber" placeholder="휴대폰번호 입력" maxlength="11"/><a href="#self" class="btn_send">발송</a></span></p>
        <p class="mb10"><span class="input_box"><input type="text" name="secretCode" disabled="disabled" placeholder="인증번호 입력" maxlength="4"/><span id="timer" class="timer"></span></span></p>
        <div id="secretCode_err" class="error_txt" style="visibility:hidden;">에러텍스트</div>
        <a href="#self" id="btn_certify" class="btn_confirm btn_48 btn_disabled">다음</a>

        <div class="integrationFindIdPw">
            <img src="${pageContext.request.contextPath}/pc/images/ic_exclamation_mark.png" alt="" class="integrationFindIdPwImg"/>
            <div class="integrationFindIdPwGo">
                <span class="integrationFindIdPwGoQ">통합회원 아이디/비밀번호를 찾고 계신가요?</span>
                <span class="integrationFindIdPwGoBlue">통합회원 계정찾기 <span>></span></span>
            </div>
        </div>
    </div>
</script>

<script id="idFindSuccessTmpl_mo" type="text/x-jquery-tmpl">
    <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    <div class="in_box">
        <p class="id_text1">고객님의 아이디는</p>
        <p class="id_text2"><strong>\${emailId}</strong><span style="margin-top: 16px;display: block;">입니다.</span></p>
        <a href="#self" class="btn_confirm btn_go_integrate_login">로그인 하러가기</a>
        <div class="txt_box">
            비밀번호가 기억나지 않으세요? <a href="#self" class="btn_go_pwFind">비밀번호 찾기 &gt;</a>
        </div>
    </div>
</script>

<script id="idFindFailTmpl_mo" type="text/x-jquery-tmpl">
    <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    <div class="in_box">
        <h2 class="title double">입력하신 정보로<br />등록된 회원이 없습니다.</h2>
        <p class="comment">가입 정보를 다시 확인하고 시도해 주세요.</p>
        <a href="#self" class="btn_confirm btn_48 c_blue btn_go_integrate_login" style="margin-bottom: 16px; color: #302cc8 !important; background-color: #fff; border: 1px solid #302cc8;">확인</a>
        <div class="btns">
            <a href="#self" class="btn_go_integrate_join"><span>회원가입하러 가기</span></a>
        </div>
    </div>
</script>
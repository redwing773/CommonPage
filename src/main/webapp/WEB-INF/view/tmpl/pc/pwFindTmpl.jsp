<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="pwFindTmpl" type="text/x-jquery-tmpl">
    <div class="in_box">
        <h1 class="logo"><img src="${pageContext.request.contextPath}/pc/images/logo_small.png" alt="" /><span>입시의 모든 것을 해결하다</span></h1>
        <h2 class="title">비밀번호 찾기</h2>
        <p class="comment">아이디 입력 및 본인확인을 위한 휴대폰인증이 필요합니다.</p>
        <p class="mb10"><input type="text" name="emailId" placeholder="이메일주소 입력" /></p>
        <div class="sub_tit"><em>and</em></div>
        <p class="mb10"><span class="input_box"><input type="text" name="phoneNumber" placeholder="휴대폰번호 입력" maxlength="11"/><a href="#self" class="btn_send">발송</a></span></p>
        <p class="mb10"><span class="input_box"><input type="text" name="secretCode" disabled="disabled" placeholder="인증번호 입력" maxlength="4"/><span id="timer" class="timer"></span></span></p>
        <div class="error_txt" id="all_err" style="display:none;"></div>
        <a href="#self" id="btn_certify" class="btn_confirm btn_disabled">다음</a>
    </div>
</script>

<script id="pwFind2Tmpl" type="text/x-jquery-tmpl">
    <div class="in_box">
        <h1 class="logo"><img src="${pageContext.request.contextPath}/pc/images/logo_small.png" alt="" /><span>입시의 모든 것을 해결하다</span></h1>
        <h2 class="title">비밀번호 재설정</h2>
        <p class="comment mb100">비밀번호는 6자리 이상 입력해야 합니다.</p>
        <p class="mb10"><input type="password" name="password" placeholder="새로운 비밀번호"/></p>
        <p class="mb10"><input type="password" name="rePassword" placeholder="비밀번호 확인"/></p>
        <div class="error_txt" id="password_err" style="display:none;">Error Text</div>
        <a href="#self" id="btn_changePw" class="btn_confirm btn_disabled">저장하기</a>
    </div>
</script>

<script id="pwFindSuccessTmpl" type="text/x-jquery-tmpl">
    <div class="in_box">
        <h1 class="logo"><img src="${pageContext.request.contextPath}/pc/images/logo_small.png" alt="" /><span>입시의 모든 것을 해결하다</span></h1>
        <h2 class="title double mb220">비밀번호 변경이 완료되었습니다.<br />로그인을 해주세요.</h2>
        <a href="#self" class="btn_confirm btn_go_login">로그인 하러가기</a>
        <div class="txt_box">
            아이디가 기억나지 않는 경우 <a href="#self" class="btn_go_idFind">아이디 찾기 &gt;</a>
        </div>
    </div>
</script>

<script id="pwFindFailTmpl" type="text/x-jquery-tmpl">
    <div class="in_box">
        <h1 class="logo"><img src="${pageContext.request.contextPath}/pc/images/logo_small.png" alt="" /><span>입시의 모든 것을 해결하다</span></h1>
        <h2 class="title double">입력하신 정보로<br />등록된 회원이 없습니다.</h2>
        <p class="comment">정보를 다시 확인하시고 시도해주세요.</p>
        <a href="#self" class="btn_confirm btn_48 c_blue btn_go_pwFind">확인</a>
        <div class="sub_tit"><em>or</em></div>
        <div class="btns">
            <a href="#self" class="btn_go_mentee_join"><span><strong>멘티</strong>로 가입하기</span></a>
            <a href="#self" class="btn_go_mentor_join"><span><strong>멘토</strong>로 가입하기</span></a>
        </div>
    </div>
</script>

<script id="pwFindTmpl_mo" type="text/x-jquery-tmpl">
    <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    <div class="in_box">
        <h2 class="title">비밀번호 찾기</h2>
        <p class="comment">아이디 입력 및<br>본인 확인을 위한 휴대폰 인증이 필요합니다.</p>
        <p class="mb10"><input type="text" name="emailId" placeholder="이메일주소 입력" /></p>
        <div class="sub_tit"><em>and</em></div>
        <p class="mb10"><span class="input_box"><input type="text" name="phoneNumber" placeholder="휴대폰번호 입력" maxlength="11"/><a href="#self" class="btn_send">발송</a></span></p>
        <p class="mb10"><span class="input_box"><input type="text" name="secretCode" disabled="disabled" placeholder="인증번호 입력" maxlength="4"/><span id="timer" class="timer"></span></span></p>
        <div class="error_txt" id="all_err" style="visibility:hidden;"></div>
        <a href="#self" id="btn_certify" class="btn_confirm btn_disabled">다음</a>

         <div class="integrationFindIdPw">
            <img src="${pageContext.request.contextPath}/pc/images/ic_exclamation_mark.png" alt="" class="integrationFindIdPwImg"/>
            <div class="integrationFindIdPwGo">
                <span class="integrationFindIdPwGoQ">통합회원 아이디/비밀번호를 찾고 계신가요?</span>
                <span class="integrationFindIdPwGoBlue">통합회원 계정찾기 <span>></span></span>
            </div>
        </div>
    </div>
</script>

<script id="pwFind2Tmpl_mo" type="text/x-jquery-tmpl">
    <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    <div class="in_box">
        <h2 class="title">비밀번호 재설정</h2>
        <p class="comment mb50">비밀번호는 6자리 이상 입력해야 합니다.</p>
        <p class="mb10"><input type="password" name="password" placeholder="새로운 비밀번호"/></p>
        <p class="mb10"><input type="password" name="rePassword" placeholder="비밀번호 확인"/></p>
        <div class="error_txt" id="password_err" style="visibility:hidden;">Error Text</div>
        <a href="#self" id="btn_changePw" class="btn_confirm btn_disabled">저장하기</a>
    </div>
</script>

<script id="pwFindSuccessTmpl_mo" type="text/x-jquery-tmpl">
    <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    <div class="in_box">
        <h2 class="title double" style="margin-bottom: 46px;">비밀번호 변경이 완료되었습니다.<br />로그인을 해주세요.</h2>
        <a href="#self" class="btn_confirm btn_go_integrate_login">로그인 하러가기</a>
    </div>
</script>

<script id="pwFindFailTmpl_mo" type="text/x-jquery-tmpl">
    <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    <div class="in_box">
        <h2 class="title double">입력하신 정보로<br />등록된 회원이 없습니다.</h2>
        <p class="comment">정보를 다시 확인하시고 시도해주세요.</p>
        <a href="#self" class="btn_confirm btn_48 c_blue btn_go_pwFind">확인</a>
        <div class="sub_tit"><em>or</em></div>
        <div class="btns">
            <a href="#self" class="btn_go_integrate_join" style="width:100%;"><span>회원가입하러 가기</span></a>
        </div>
    </div>
</script>
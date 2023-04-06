<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 회원가입 선택 --%>
<script id="joinStep1Tmpl" type="text/x-jquery-tmpl">
    <div class="inner_box">
        <h1 class="logo_mo">
            <a href="#self"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_big.png" alt="LinkerMoji" style="width: 253px;"/></a>
        </h1>
        <section class="mentee_box">
            <div class="conts_box">
                <a href="#self" class="btn_join">이메일로 가입하기</a>
                <div class="sub_tit"><em>간편가입</em></div>
                <a href="#self" class="btn_join_kakao"><span>카카오톡으로 가입하기</span></a>
				<a href="#self" class="btn_join_facebook"><span>페이스북으로 가입하기</span></a>
				<a href="#self" id="btn_join_google_mentor" class="btn_join_google"><span>구글로 가입하기</span></a>
                <%--<a href="#self" class="btn_naver_kakao"><span>네이버로 가입</span></a>--%>
            </div>
        </section>
        <section class="mentor_box" style="display: none;">
            <div class="conts_box">
                <a href="#self" class="btn_join">이메일로 가입하기</a>
                <div class="sub_tit"><em>간편가입</em></div>
                <a href="#self" class="btn_join_kakao"><span>카카오톡으로 가입</span></a>
				<a href="#self" class="btn_join_facebook"><span>페이스북으로 가입</span></a>
				<a href="#self" id="btn_join_google_mentee" class="btn_join_google"><span>구글로 가입</span></a>
                <%--<a href="#self" class="btn_naver_kakao"><span>네이버로 가입</span></a>--%>
            </div>
        </section>
        <div class="login_txt" style="text-align: center; font-size: 13px; line-height: 1.4; color: #272b3d;">
            이미 가입하셨나요? <a href="${pageContext.request.contextPath}/page/membership-mo/login" style="font-size: 13px; line-height: 1.53; color: #302cc8; font-weight: bold; padding-left: 10px;">로그인하기 &gt;</a>
        </div>
    </div>
</script>

<%-- 이용약관 --%>
<script id="joinStep2Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title mb40">이용약관</h2>
            <section class="all_agree">
                <label class="checkbox"><input type="checkbox" name="allSelectTerm"><em></em><span>약관 전체동의</span></label>
            </section>
            <div class="sub_agree">
            </div>
            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step03">저장하기</a>
            </div>
        </div>
    </div>
</script>

<%-- 멘티 회원 선택 --%>
<script id="joinMenteeStep3Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title mb25">회원유형 선택</h2>

            <label class="men_radio" style="margin-bottom:16px;"><input type="radio" name="userTypeCd" value="0"/><span><strong>학생 회원</strong>만14세 이상의 현재 학생으로,<br />멘토에게 정보를 제공받거나 과외를 받고자 하는 회원입니다.</span></label>
            <label class="men_radio"><input type="radio" name="userTypeCd" value="1"/><span><strong>학부모 회원</strong>학생을 자녀로 둔 회원으로,<br />멘토에게 정보를 제공 받거나 과외를 구하는 회원입니다.</span></label>

            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step04">다음</a>
            </div>
        </div>
    </div>
</script>

<%-- 기본정보 입력 --%>
<script id="joinStep4Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title" style="magin-bottom:8px;">회원가입</h2>
            <ul class="step_number">
                <li class="current">1</li>
                <li></li>
                <li></li>
            </ul>
            <div class="profile_box">
                <p class="img_box"></p>
                <input type="file" name="profile" accept="image/png,image/jpg,image/jpeg">
            </div>

            {{if !isOAuth}}
                <h3 class="in_title">이메일 <em id="email_err" class="error_txt" style="display:none;"></em></h3>
                <div class="mb30">
                    <input style="min-width:163px; width: calc(100% - 150px);" type="text" name="email1" placeholder="아이디" maxlength="128" />
                    <input style="width:150px; display: none;" type="text" name="email2" maxlength="128" class="mr5"/>
                    <select style="width:138px; margin-left: 8px;" name="domain">
                    </select>
                </div>
                <h3 class="in_title">비밀번호 <em id="password_err" class="error_txt" style="display:none;"></em></h3>
                <div class="mb30">
                    <%--<input type="text" name="tmpEmailId" value="\${tmpEmailId}" style="height:1px;width:1px;"/>--%>
                    <input class="mb12" type="password" name="password" placeholder="비밀번호 6자리 이상 입력" />
                    <input type="password" name="rePassword" placeholder="비밀번호 확인" />
                </div>
            {{/if}}
            <h3 class="in_title">닉네임 <em id="nickname_err" class="error_txt" style="display:none;"></em></h3>
            <div>
                <input type="text" name="nickname" placeholder="3~8자로 입력, 특수문자 제외" minlength="3" maxlength="7" />
            </div>

            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step05" style="margin-top: 92px;">다음</a>
            </div>
        </div>
    </div>
</script>

<%-- 멘티 상세정보 --%>
<script id="joinMenteeStep5Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title" style="magin-bottom:8px;">회원가입</h2>
            <ul class="step_number">
                <li class="on"></li>
                <li class="current">2</li>
                <li></li>
            </ul>

            <h3 class="in_title">학교명 (자녀의 학교명)</h3>
            <div class="mb30">
                <div class="it_search">
                    <input type="text" name="school" placeholder="학교 검색"/>
                    <button type="button" class="btn_search"><span class="blind">검색</span></button>
                    <div style="max-height:100px; overflow:auto;">
                        <ul class="list-group" id="school">
                        </ul>
                    </div>
                </div>
            </div>
            <h3 class="in_title">학년</h3>
            <div class="mb30">
                <select name="grade">
                    <option value="" selected="selected">학년 선택</option>
                </select>
            </div>
            <h3 class="in_title">성별</h3>
            <div class="mb30">
                <ul class="chk_list">
                    <li><label class="radiobox style_01"><input type="radio" name="gender" value="male" /><span>남성</span></label></li>
                    <li><label class="radiobox style_01"><input type="radio" name="gender" value="female" /><span>여성</span></label></li>
                </ul>
            </div>
            <h3 class="in_title">원하는 멘토링</h3>
            <div class="mb30">
                <ul id="need_mentoring" class="chk_list">
                </ul>
            </div>
            <h3 class="in_title">필요학습 과목</h3>
            <div class="mb30">
                <ul id="need_subject" class="chk_list">
                </ul>
            </div>
            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step06" style="margin-top:0">다음</a>
            </div>
        </div>
    </div>
</script>

<%-- 멘토 상세정보 --%>
<script id="joinMentorStep5Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title" style="magin-bottom:8px;">회원가입</h2>
            <ul class="step_number">
                <li class="on"></li>
                <li class="current">2</li>
                <li></li>
            </ul>
            <h3 class="in_title">고등학교</h3>
            <div class="mb30">
                <div class="it_search">
                    <input type="text" name="school" placeholder="학교검색"/>
                    <button type="button" class="btn_search"><span class="blind">검색</span></button>
                    <div style="max-height:100px; overflow:auto;">
                        <ul class="list-group" id="school">
                        </ul>
                    </div>
                </div>
            </div>
            <h3 class="in_title">대학교 <span class="error_txt" style="display:none;"></span></h3>
            <div class="mb30">
                <ul class="it_list_01">
                    <li>
                        <div class="both_area">
                            <div class="fl_l">
                                <div class="it_search">
                                    <input type="text" style="width:370px;" name="universitySchool" placeholder="학교검색" />
                                    <button type="button" class="btn_search"><span class="blind">검색</span></button>
                                    <div style="max-height:100px; overflow:auto;">
                                        <ul class="list-group" id="universitySchool">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="fl_r">
                                <select name="academicStatus" style="width:110px;">
                                    <option value="-1">재학 상태</option>
                                </select>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="both_area">
                            <div class="fl_l">
                                <select name="departmentLine" style="width:370px;">
                                    <option value="-1">계열</option>
                                </select>
                            </div>
                            <div class="fl_r">
                                <select name="studentId" style="width:110px;">
                                    <option value="">학번</option>
                                </select>
                            </div>
                        </div>
                    </li>
                    <li>
                        <input type="text" name="major" placeholder="학과" maxlength="20" />
                    </li>
                    <li>
                        <div class="both_area mb20">
                            <div class="fl_l">
                                <select name="acceptanceType1" style="width:240px;">
                                    <option value="-1">합격유형 선택</option>
                                </select>
                            </div>
                            <div class="fl_r">
                                <select name="acceptanceType2" style="width:240px;">
                                    <option value="-1">전형선택</option>
                                </select>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <h3 class="in_title">성별</h3>
            <div class="mb30">
                <ul class="chk_list">
                    <li><label class="radiobox style_01"><input type="radio" name="gender" value="male" /><span>남성</span></label></li>
                    <li><label class="radiobox style_01"><input type="radio" name="gender" value="female" /><span>여성</span></label></li>
                </ul>
            </div>
            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step06">다음</a>
            </div>
        </div>
    </div>
</script>

<%-- 휴대폰 인증 --%>
<script id="joinStep6Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title" style="magin-bottom:8px;">회원가입</h2>
            <ul class="step_number">
                <li class="on"></li>
                <li class="on"></li>
                <li class="current">3</li>
            </ul>
            <dl class="men_txt" style="margin-top:35px;">
                <dt>휴대폰 인증</dt>
                <dd>본인확인을 위하여 휴대폰인증이 필요합니다.</dd>
            </dl>

            <p class="mb10"><span class="input_box"><input type="text" name="phoneNumber" placeholder="휴대폰번호 입력" maxlength="11"/><a href="#self" class="btn_send">발송</a></span></p>
            <p class="mb10">
                <span class="input_box">
                    <input type="text" disabled="disabled" name="smsConfirmCd" placeholder="인증번호 입력" maxlength="4" />
                    <span id="timer" class="timer">
                        <span class="minutes">00</span>
                        <span class="dots">:</span>
                        <span class="seconds">00</span>
                    </span>
                </span>
            </p>

            <div id="smsConfirm_err" class="error_txt" style="display:none;"></div>

            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step07" style="margin-top: 45px;">다음</a>
            </div>
        </div>
    </div>
</script>

<%-- 멘티 가입 완료 --%>
<script id="joinMenteeStep7Tmpl" type="text/x-jquery-tmpl">
    <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/logo_linker_moji_sm.png" alt="" /></h1>
    <div class="inner_box">
        <div class="conts_box">
            <p class="txt1">회원가입 완료!</p>
            <p class="txt2">이제 MOJI 및 Linker 서비스를<br>이용하실 수 있습니다.</p>
            <a href="#self" class="btn_go_main_mo">시작하기</a>
        </div>
    </div>
</script>

<%-- 멘토 가입 완료 --%>
<script id="joinMentorStep7Tmpl" type="text/x-jquery-tmpl">
    <div class="inner_box">
        <h1 class="logo_mo"><img src="${pageContext.request.contextPath}/pc/images/login_logo.png" alt="Linker" /></h1>
        <div class="conts_box">
            <p class="txt1">회원가입이 완료 되었습니다.</p>
            <p class="txt2">링커에서 멘토로 활동하기 위해서 <strong>학력인증이 필요</strong>합니다.<br />간단하게 사진을 찍어서 업로드 하시면 됩니다.</p>
            <a href="#self" class="btn_go_certify">필수 정보 입력하기</a>
        </div>
    </div>
</script>
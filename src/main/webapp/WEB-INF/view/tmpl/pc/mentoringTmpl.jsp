<%--
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

&lt;%&ndash; 회원가입 선택 &ndash;%&gt;
<script id="mentoring1Tmpl1" type="text/x-jquery-tmpl">
    <tr>
        <th class="vt">
        	<p class="tit">대학교</p>
        </th>
        <td class="pt20 pb15">
        	<ul class="it_list_01">
        		<li>
        			<div class="both_area">
        				<div class="fl_l">
        					<div class="it_search">
        						<input type="text" style="width:470px;" value="대학교"/>
        						<button type="button" class="btn_search"><span class="blind">검색</span></button>
        					</div>
        				</div>
        				<div class="fl_r">
        					<select style="width:110px;">
        						<option>재학</option>
        						<option></option>
        					</select>
        				</div>
        			</div>
        		</li>
        		<li>
        			<div class="both_area">
        				<div class="fl_l">
        					<div class="it_search">
        						<input type="text" style="width:470px;" value="계열"/>
        						<button type="button" class="btn_search"><span class="blind">검색</span></button>
        					</div>
        				</div>
        				<div class="fl_r">
        					<select style="width:110px;">
        						<option>20학번</option>
        						<option></option>
        					</select>
        				</div>
        			</div>
        		</li>
        		<li>
        			<input type="text" value="학과"/>
        		</li>
        		<li>
        			<div class="both_area">
        				<div class="fl_l">
        					<select style="width:291px;">
        						<option>수시</option>
        						<option></option>
        					</select>
        				</div>
        				<div class="fl_r">
        					<select style="width:291px;">
        						<option>실기 위주</option>
        						<option></option>
        					</select>
        				</div>
        			</div>
        		</li>
        	</ul>
        </td>
	</tr>
</script>

&lt;%&ndash; 이용약관 &ndash;%&gt;
<script id="mentoring1Tmpl2" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo"><a href="#self"><span class="blind">linker</span></a></h1>
        <a href="#self" class="btn_login">로그인</a>
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
                <a href="#self" class="btn_disabled btn_go_step03">다음</a>
            </div>
        </div>
    </div>
</script>

&lt;%&ndash; 이용약관 목록 &ndash;%&gt;
<script id="termsListTempl" type="text/x-jquery-tmpl">
    {{if termsRequiredYn === 'Y'}}
        <p class="mb15"><label class="checkbox"><input type="checkbox" class="termRequired" name="subSelectTerm" value="\${termsNo}"><em></em><span>\${termsNm} <i>(필수)</i></span></label></p>
    {{else}}
        <p class="mb15"><label class="checkbox"><input type="checkbox" name="subSelectTerm" value="\${termsNo}"><em></em><span>\${termsNm} <i class="gray">(선택)</i></span></label></p>
    {{/if}}
    <section class="pro_box">
        \${termsContent}
    </section>
</script>

&lt;%&ndash; 멘티 회원 선택 &ndash;%&gt;
<script id="joinMenteeStep3Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo"><a href="#self"><span class="blind">linker</span></a></h1>
        <a href="#self" class="btn_login">로그인</a>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title mb25">회원가입</h2>
            <dl class="men_txt">
                <dt>멘티 회원선택</dt>
                <dd>멘티 회원 중 학생, 학부모 중에서 선택하세요.</dd>
            </dl>

            <label class="men_radio mb12"><input type="radio" name="userTypeCd" value="0"/><em></em><span><strong>학생 멘티 회원</strong>만14세 이상의 현재 학생으로 멘토에게 정보를 제공 받거나<br />과외를 받고자 하는 회원입니다.</span></label>
            <label class="men_radio mb50"><input type="radio" name="userTypeCd" value="1"/><em></em><span><strong>학부모 멘티 회원</strong>학생을 자녀로 둔 학부모 멘티 회원으로 멘토에게 정보를 제공 받거나<br />과외를 구하는 회원입니다.</span></label>

            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step04">다음</a>
            </div>
        </div>
    </div>
</script>

&lt;%&ndash; 멘토 회원 선택 &ndash;%&gt;
<script id="joinMentorStep3Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo"><a href="#self"><span class="blind">linker</span></a></h1>
        <a href="#self" class="btn_login">로그인</a>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title mb25">회원가입</h2>
            <dl class="men_txt">
                <dt>멘토 회원선택</dt>
                <dd>멘토 회원 중 학생, 학부모 중에서 선택하세요.</dd>
            </dl>

            <label class="men_radio mb12"><input type="radio" name="userTypeCd" value="0"/><em></em><span><strong>대학생 멘토 회원</strong>현재 대학생 혹은 대학졸업자로 멘티에게 정보를 제공 하거나<br />과외를 하고자 하는 회원입니다.</span></label>
            <label class="men_radio mb12"><input type="radio" name="userTypeCd" value="1"/><em></em><span><strong>학부모 멘토 회원</strong>대학생의 자녀를 둔 학부모이며 멘티에게 정보를 제공하고자 하는 학부모 회원입니다.</span></label>
            <label class="men_radio mb50"><input type="radio" name="userTypeCd" value="2"/><em></em><span><strong>전문가 멘토 회원</strong>전문업체에서 활동하는 전문가로 멘티에게 정보를 제공하는 전문 멘토 회원입니다.​</span></label>

            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step04">다음</a>
            </div>
        </div>
    </div>
</script>

&lt;%&ndash; 기본정보 입력 &ndash;%&gt;
<script id="joinStep4Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo"><a href="#self"><span class="blind">linker</span></a></h1>
        <a href="#self" class="btn_login">로그인</a>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title mb25">회원가입</h2>
            <ul class="step_number">
                <li class="current">1</li>
                <li></li>
                <li></li>
            </ul>
            <div class="profile_box">
                <p class="img_box"><input type="file" name="profile" accept="image/png,image/jpg,image/jpeg"></p>
                <a href="#self" class="btn_add"><span class="blind">사진 추가</span></a>
            </div>

            <h3 class="in_title">이메일 <em id="email_err" class="error_txt" style="display:none;"></em></h3>
            <div class="mb30">
                <input style="width:230px;" type="text" name="emailId" placeholder="아이디" /> <em>&nbsp;@&nbsp;</em>
                <select style="width:230px;" name="domain">
                </select>
            </div>
            <h3 class="in_title">비밀번호 <em id="password_err" class="error_txt" style="display:none;"></em></h3>
            <div class="mb30">
                <input class="mb12" type="password" name="password" placeholder="비밀번호 6자리 이상 입력" />
                <input type="password" name="rePassword" placeholder="비밀번호 확인" />
            </div>
            <h3 class="in_title">닉네임 <em id="nickname_err" class="error_txt" style="display:none;"></em></h3>
            <div class="mb65">
                <input type="text" name="nickname" placeholder="한글 최대 8자" />
            </div>

            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step05">다음</a>
            </div>
        </div>
    </div>
</script>

&lt;%&ndash; 멘티 상세정보 &ndash;%&gt;
<script id="joinMenteeStep5Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo"><a href="#self"><span class="blind">linker</span></a></h1>
        <a href="#self" class="btn_login">로그인</a>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title mb25">회원가입</h2>
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
                <a href="#self" class="btn_disabled btn_go_step06">다음</a>
            </div>
        </div>
    </div>
</script>

&lt;%&ndash; 멘토 상세정보 &ndash;%&gt;
<script id="joinMentorStep5Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo"><a href="#self"><span class="blind">linker</span></a></h1>
        <a href="#self" class="btn_login">로그인</a>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title mb25">회원가입</h2>
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
                                    <option>재학</option>
                                </select>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="both_area">
                            <div class="fl_l">
                                <div class="it_search">
                                    <input type="text" name="departmentLine" style="width:370px;" placeholder="계열"/>
                                    <button type="button" class="btn_search"><span class="blind">검색</span></button>
                                    <div style="max-height:100px; overflow:auto;">
                                        <ul class="list-group" id="departmentLine">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="fl_r">
                                <select name="studentId" style="width:110px;">
                                    <option>학번</option>
                                </select>
                            </div>
                        </div>
                    </li>
                    <li>
                        <input type="text" name="major" placeholder="학과" />
                    </li>
                    <li>
                        <div class="both_area mb20">
                            <div class="fl_l">
                                <select name="acceptanceType1" style="width:240px;">
                                    <option>합격 유형 선택</option>
                                </select>
                            </div>
                            <div class="fl_r">
                                <select name="acceptanceType2" style="width:240px;">
                                    <option>전형선택</option>
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

&lt;%&ndash; 휴대폰 인증 &ndash;%&gt;
<script id="joinStep6Tmpl" type="text/x-jquery-tmpl">
    <header>
        <h1 class="logo"><a href="#self"><span class="blind">linker</span></a></h1>
        <a href="#self" class="btn_login">로그인</a>
    </header>
    <div class="outer_box">
        <div class="inner_box">
            <h2 class="title mb25">회원가입</h2>
            <ul class="step_number">
                <li class="on"></li>
                <li class="on"></li>
                <li class="current">3</li>
            </ul>
            <dl class="men_txt">
                <dt>휴대폰 인증</dt>
                <dd>본인확인을 위하여 휴대폰인증이 필요합니다.</dd>
            </dl>

            <p class="mb10"><span class="input_box"><input type="text" value="" name="" placeholder="휴대폰번호 입력" /><a href="#self" class="btn_send">발송</a></span></p>
            <p class="mb10"><input type="text" disabled="disabled" value="" name="" placeholder="인증번호 입력" /></p>
            <div class="error_txt">에러 텍스트</div>

            <div class="btn_box">
                <a href="#self" class="btn_disabled btn_go_step07">다음</a>
            </div>
        </div>
    </div>
</script>

&lt;%&ndash; 멘티 가입 완료 &ndash;%&gt;
<script id="joinMenteeStep7Tmpl" type="text/x-jquery-tmpl">
    <div class="inner_box">
        <h1 class="logo"><img src="/pc/images/login_logo.png" alt="Linker" /></h1>
        <div class="conts_box">
            <p class="txt1">회원가입 완료!</p>
            <p class="txt2">이제 Linker에서 활동할 수 있습니다.</p>
            <a href="#self">서비스 시작하기</a>
        </div>
    </div>
</script>

&lt;%&ndash; 멘토 가입 완료 &ndash;%&gt;
<script id="joinMentorStep7Tmpl" type="text/x-jquery-tmpl">
    <div class="inner_box">
        <h1 class="logo"><img src="/pc/images/login_logo.png" alt="Linker" /></h1>
        <div class="conts_box">
            <p class="txt1">회원가입이 완료 되었습니다.</p>
            <p class="txt2">링커에서 멘토로 활동하기 위해서 <strong>학력인증이 필요</strong>합니다.<br />간단하게 사진을 찍어서 업로드 하시면 됩니다.</p>
            <a href="#self">필수 정보 입력하기</a>
        </div>
    </div>
</script>--%>
<%@tag pageEncoding="UTF-8" %>

<script id="popAlertTmpl" type="text/x-jquery-tmpl">
    <div class="pop_alert popup_alert_box open">
        <div class="outter_box">
            <div class="inner_box">
                <h2 class="title">{{html message}}</h2>
                <div class="ta_c">
                    <button type="button" class="btn_48 c_blue" style="width:182px;" onclick="Layer_CLOSE('.pop_alert')">확인</button>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="popAlertTmpl_mo" type="text/x-jquery-tmpl">
    <div class="pop_alert popup_alert_box open popup_point_charge_complete">
        <div class="outter_box">
            <div class="inner_box">
                <h2 class="title" style="margin:0;">{{html message}}</h2>
                <div class="btn_box">
                    <button type="button" class="btn_48 c_blue" style="width: 100%; height: 40px; line-height: 40px; border-radius: 0;" onclick="Layer_CLOSE('.pop_alert')">확인</button>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="popConfirmTmpl" type="text/x-jquery-tmpl">
    <div class="popup_alert_01">
        <div class="outter_box">
            <div class="inner_box">
                <h2 class="title" style="text-align:left;font-size:15px;">{{html message}}</h2>
                <div class="both_area">
                    <div class="fl_l">
                        <button type="button" class="btn_48" style="width:80px;" onclick="Layer_CLOSE('.popup_alert_01')">취소</button>
                    </div>
                    <div class="fl_r">
                        <a href="#self" class="btn_48 c_blue" style="width:200px;">확인</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="popConfirmTmpl02" type="text/x-jquery-tmpl">
    <div class="popup_alert_01_02">
        <div class="outter_box">
            <div class="inner_box">
                <h2 class="title" style="text-align:left;font-size:15px;">{{html message}}</h2>
                <div class="both_area">
                    <div class="fl_l">
                        <button type="button" class="btn_48" style="width:80px;" onclick="Layer_CLOSE('.popup_alert_01_02')">취소</button>
                    </div>
                    <div class="fl_r">
                        <a href="#self" class="btn_48 c_blue" style="width:200px;">확인</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="headerTmpl" type="text/x-jquery-tmpl">
    {{if isLogin }}
        <ul class="login_menu">
			<li class="money jq_simple_user_hide" style="padding-top:3px;"><a href="\${pointUrl}" class="btn_point"></a></li>
			<li><a href="\${couponUrl}" class="btn_coupon"></a></li>
            <li><a href="\${postUrl}" class="btn_mail"></a></li>
            <li><a href="\${myinfoUrl}" class="btn_user">\${nickname}</a></li>
            <li><a href="#self" onClick="common.logout();" class="btn_logout">로그아웃</a></li>
        </ul>
    {{else}}
        <ul class="login_menu">
            <li><a href="#self" onClick="common.loginMembership();">로그인</a></li>
            <li><a href="#self" onClick="common.joinMembership();">회원가입</a></li>
        </ul>
    {{/if}}
</script>

<script id="headerTmpl_mo" type="text/x-jquery-tmpl">
    {{if isLogin }}
        <ul class="login_menu_mo">
            <li><img src="${pageContext.request.contextPath}/pc/images/ic_user_mo.png" style="transform: translateX(5px);width: 18px; height: 18px;"></li>
            <li><a href="#self" class="btn_user" style="cursor: default;">\${nickname}</a> | </li>
            <li><a href="javascript:void(0)" onClick="common.logout_mo();" class="btn_logout">로그아웃</a></li>
        </ul>
    {{else}}
        <ul class="login_menu_mo">
             <li><a href="#self" onClick="common.loginMembership_mo();">로그인</a> | </li>
             <li><a href="#self" onClick="common.joinMembership_mo();">회원가입</a></li>
         </ul>
    {{/if}}
</script>


<script id="headerTmpl2" type="text/x-jquery-tmpl">
    <ul class="login_menu">
        <li><a href="#self" onClick="common.loginMembership();">Linker 시작하기</a></li>
        <li><a href="#self" onClick="common.logout();" class="btn_logout">로그아웃</a></li>
    </ul>
</script>

<script id="headerTmpl2_mo" type="text/x-jquery-tmpl">
    <ul class="login_menu_mo">
         <li><a href="#self" onClick="common.loginMembership_mo();">Linker 시작하기</a> | </li>
         <li><a href="javascript:void(0)" onClick="common.logout_mo();" class="btn_logout">로그아웃</a></li>
     </ul>
</script>

<script id="utilTmpl" type="text/x-jquery-tmpl">
    <div class="layer_mail">
        <div class="inner_box">
        </div>
    </div>
    <div class="layer_user">
        <div class="inner_box">
            <p class="hello">안녕하세요. <strong>\${nickname}님!</strong></p>
            <div class="profile">
                <div class="img">{{html profileImg}}</div>
                {{if mentorYn == "Y"}}
                    <p class="name">멘토</p>
                {{else}}
                    <p class="name">멘티</p>
                {{/if}}
                <p class="mail">\${email}</p>
            </div>
            <ul class="btn_box">
                <%--<li><a href="#self">인벤토리</a></li>--%>
                <li style="width:100%"><a href="\${myinfoUrl}">내 정보 관리</a></li>
            </ul>
            <a href="#" class="btn_logout" onclick="common.logout();">로그아웃</a>
        </div>
    </div>
</script>

<script id="lnbTmpl" type="text/x-jquery-tmpl">
    <div class="photo">{{html profileImg}}</div>
    <p class="nickname">\${nickname}</p>
    <p class="mail">\${email}</p>
    <div class="btn_box" style="margin-bottom:20px;">
        {{if mentorYn == "Y"}}
            <span class="btn_23" style="width:42px;">멘토</span>
        {{else}}
            <span class="btn_23" style="width:42px;">멘티</span>
        {{/if}}

        {{if isRecord}}
            <span class="btn_23 bor_01" style="width:54px;">생기부</span>
        {{/if}}
    </div>
	{{if mentorYn == "Y"}}
		<div class="previewProfile" onClick="previewProfile('\${hipId}');">
			<span class="name" style="cursor:pointer;">멘티가 보는 내 프로필 보기</span>
		</div>
	{{/if}}
</script>

<script id="noPostBoxTmpl" type="text/x-jquery-tmpl">
    <p class="name">우편함</p>
    <p class="no_message">메시지가 없습니다.</p>
</script>

<script id="postBoxTmpl" type="text/x-jquery-tmpl">
    <p class="name">우편함</p>
    <div class="list">
        <ul id="messageList">
        </ul>
    </div>
    <div class="btn_box">
        <a href="#self" class="btn_36 c_blue btn_list" style="width:100%;">전체보기</a>
    </div>
</script>

<script id="messageListTmpl" type="text/x-jquery-tmpl">
    <li {{if readYn == "N"}} class="on" {{/if}}>
        <div>
            <a href="${pageContext.request.contextPath}/page/post/detail?postBoxNo=\${postBoxNo}">
                <span class="tit">\${title}</span>
                <span class="txt">\${contents}</span>
                <span class="date">\${regDt}</span>
            </a>
        </div>
    </li>
</script>

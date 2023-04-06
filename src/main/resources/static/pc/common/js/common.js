if (!String.prototype.startsWith) {
    String.prototype.startsWith = function(searchString, position) {
        position = position || 0;
        return this.indexOf(searchString, position) === position;
    };
}

$(window).scroll(function() {
      gnbCss();
});
$(window).resize(function() {
      gnbCss();
});

var common = (function ($, win, doc) {
    var openAlertPopup = function(msgObj, fnAction) {
        $("#alertPopup").empty();
        $("#popAlertTmpl").tmpl({message: msgObj}).appendTo("#alertPopup");
        $(".pop_alert").addClass("open");

        if(typeof fnAction == "function"){
            $(".pop_alert button").bind("click", function(){
                fnAction();
                $(".pop_alert").removeClass("open");
                $(this).unbind();
            });
        }
    };

    var openAlertPopupMo = function(msgObj, fnAction) {
        $("#alertPopup").empty();
        $("#popAlertTmpl_mo").tmpl({message: msgObj}).appendTo("#alertPopup");
        $(".pop_alert").addClass("open");

        if(typeof fnAction == "function"){
            $(".pop_alert button").bind("click", function(){
                fnAction();
                $(".pop_alert").removeClass("open");
                $(this).unbind();
            });
        }
    };

    var openConfirmPopup = function(msgObj, fnAction) {
        $("#alertPopup").empty();
        $("#popConfirmTmpl").tmpl({message: msgObj}).appendTo("#alertPopup");
        $(".popup_alert_01").addClass("open");

        if(typeof fnAction == "function"){
            $(".popup_alert_01 .both_area a").bind("click", function(){
                fnAction();
                $(".popup_alert_01").removeClass("open");
                $(this).unbind();
            });
        }
    };

    var openConfirmPopup02 = function(msgObj, fnAction) {
        $("#alertPopup").empty();
        $("#popConfirmTmpl02").tmpl({message: msgObj}).appendTo("#alertPopup");
        $(".popup_alert_01_02").addClass("open");

        if(typeof fnAction == "function"){
            $(".popup_alert_01_02 .both_area a").bind("click", function(){
                fnAction();
                $(".popup_alert_01_02").removeClass("open");
                $(this).unbind();
            });
        }
    };

    // hr
    var openActionPopup= function(msgObj, fnAction){
    	$("#alertPopArea").html("");
    	$("#popCancel").tmpl(msgObj).appendTo("#alertPopArea");
    	$(".popup_out").addClass("open");

    	if(typeof fnAction == "function"){
            $(".popup_out .btn_box a.gray").bind("click", function(){
                fnAction();
                $(".popup_out").removeClass("open");
                $(this).unbind();
            });
        }
    }


    var dateFormat = function(date, format){
        return tms.isNotEmpty(date)? moment.utc(date).local().format(format) : "";
    };

    var dateUnixFormat = function(date, format){
        return tms.isNotEmpty(date)?moment.unix(date).tz('Asia/Seoul').format(format) : "";
    };

    /* Step 버튼 제어 */
    var btnControll = function(obj, isAction){
        if(isAction){
            obj.removeClass("btn_disabled");
            obj.addClass("c_blue");
        }else{
            obj.removeClass("c_blue");
            obj.addClass("btn_disabled");
        }
    };

    /* 페이지 이동 */
    var nextStep = function(ori, dst){
        ori.hide();
        dst.show();
    };

    var getDeviceType = function() {
        var agent = navigator.userAgent.toLowerCase();
        if (agent.indexOf('android') > -1) {
            //안드로이드 일때 처리
            return "A";
        } else if (agent.indexOf("iphone") > -1 || agent.indexOf("ipad")> -1 || agent.indexOf("ipod") > -1) {
            //IOS 일때 처리
            return "I";
        } else {
            //아이폰, 안드로이드 외 처리
            return "P";
        }
    };

    var urlInfo = {
        index: contextPath + "/",
        login: contextPath + "/page/membership/login", //로그인
        join: contextPath + "/page/membership/join", //회원가입
        findId: contextPath + "/page/membership/idFind", //아이디 찾기
        findPwd: contextPath + "/page/membership/pwFind", //비밀번호 찾기
        useItem: contextPath + "/page/item/use",
        endItem: contextPath + "/page/item/end",
        inventory: contextPath +  "/page/mypage/inventory", //인벤토리 메인
        payment: contextPath +  "/page/point/purchase", //포인트 결제
        paymentItem: contextPath + "/page/point/payment", //포인트 결제 상품 목록
        pointList: contextPath + "/page/point/list",
        withdrawMain: contextPath + "/page/withdraw/main",
        withdrawList: contextPath + "/page/withdraw/list",
        withdrawApply: contextPath + "/page/withdraw/apply",
        withdrawDetail: contextPath + "/page/withdraw/detail",
        withdrawBank: contextPath + "/page/withdraw/bank",
        withdrawPoint: contextPath + "/page/withdraw/point",
        myPageCertify: contextPath + "/page/mypage/certify",
        myPageMyInfo: contextPath + "/page/mypage/myinfo",
        myPageLesson: contextPath + "/page/mypage/lesson",
        myPageMentoring1: contextPath + "/page/mypage/mentoring_01",
        myPageMentoring2: contextPath + "/page/mypage/mentoring_02",
        myPageRecord: contextPath + "/page/mypage/record",
        myPageIntroduce: contextPath + "/page/mypage/introduce",
        myPageAcademicBg: contextPath + "/page/mypage/academic_background",
        myColumn: contextPath + "/page/column/list",
        myColumnDetail: contextPath + "/page/column/detail",
        customerCenter: contextPath + "/page/mypage/center",
        guide: contextPath + "/page/mypage/guide",
        serviceGuide: contextPath + "/page/service/guide",
        postList: contextPath + "/page/post/list",
        menteeInfo: contextPath + "/page/mypage/menteeInfo",
        useCoupon: contextPath + "/page/coupon/use", // 사용 가능한 쿠폰
        endCoupon: contextPath + "/page/coupon/end", // 사용한 쿠폰
        notice: contextPath + "/page/notice/list", // 공지사항
        recommend: contextPath + "/page/mypage/recommend", //추천인
        settings: contextPath + "/page/mypage/settings", // 설정
        saleInfo: contextPath + "/page/mypage/saleInfo", // 판매설정
        menteeHome: contextPath + "/page/mypage/menteeHome", // 멘티메인
        faq: contextPath + "/page/mypage/faq", //faq
        password: contextPath + "/page/mypage/password", // 비밀번호 변경
        myLinker: contextPath + "/page/myLinker/purchaseList", // 마이링커 이동
        connectLog: contextPath + "/page/admin/connectLog" // 어드민 페이지 이동
    };

    var message = {
        defaultErr: "오류가 발생했습니다. 잠시 후 다시 시도해주세요."
        , sendOk: "전송하였습니다."
        , update: "수정되었습니다."
        , dupUid: "이미 등록된 회원입니다."
        , dupEmail: "중복된 이메일 입니다."
        , dupNickName: "중복된 닉네임 입니다."
        , smsConfirmErr: "잘못된 인증번호 입니다."
        , noEmail: "정보가 일치하지 않거나, 존재하지 않는 이메일입니다."
        , requiredPassword: "비밀번호는 6자리 이상을 입력해주세요."
        , requiredRepassword: "비밀번호 확인은 6자리 이상을 입력해주세요."
        , notEqualPassword: "비밀번호가 일치하지 않습니다."
        , validEmail: "올바른 이메일 형식을 입력해주세요."
        , validEmailId: "이메일은 영어와 숫자를 포함하여 입력해주세요."
        , validDomain: "도메인을 입력해주세요."
        , validNickName: "'닉네임은 3글자 이상 8자 이하(특수문자 제외)'로 입력해주세요."
        , validPhoneNumber: "올바른 휴대폰 번호를 입력해주세요."
        , dupPhone: "이미 등록된 번호 입니다."
    };

    var userInfo = {
        nickname: '',
        mentorYn: '',
        email: '',
        mobileNumber: '',
        isLogin: false
    };

    var validation = {
        phoneNumber: /^(010)?[0-9]{8}$/,
        secretCode: /^[0-9]{4}$/,
        email: /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/,
        emailId: /[^a-zA-Z0-9]/gi,
    };

    var loginMembership = function() {
        location.href = properties.membershipAuthDomain()+"/login?clientId="+properties.membershipClientId()+"&callbackUrl="+ properties.membershipCallbackUrl() + "&returnURL=" + properties.membershipCallbackUrl();
    }

    var joinMembership = function() {
        location.href = properties.membershipAuthDomain()+"/signup/integrated?clientId="+properties.membershipClientId()+"&callbackUrl="+ properties.membershipCallbackUrl() + "&returnURL=" + properties.membershipCallbackUrl();
    }

    var loginMembership_mo = function() {
        location.href = properties.membershipAuthDomain()+"/login?clientId="+properties.membershipMobileClientId()+"&callbackUrl="+ properties.membershipCallbackUrl() + "&returnURL=" + properties.membershipCallbackUrl();
    }

    var joinMembership_mo = function() {
        location.href = properties.membershipAuthDomain()+"/signup/integrated?clientId="+properties.membershipMobileClientId()+"&callbackUrl="+ properties.membershipCallbackUrl() + "&returnURL=" + properties.membershipCallbackUrl();
    }

    var loginMembershipPortal = function(actionNm) {
        if(actionNm == "write"){
            location.href = properties.membershipAuthDomain()+"/login?clientId="+properties.membershipClientId()+"&branchType=toktok&callbackUrl="+ properties.membershipCallbackUrlPortal() + "&returnURL=" + encodeURIComponent(properties.membershipReturnUrlPortal() + location.search);
        }else if(actionNm == "writeSearch") {
            location.href = properties.membershipAuthDomain()+"/login?clientId="+properties.membershipClientId()+"&branchType=toktok&callbackUrl="+ properties.membershipCallbackUrlPortal() + "&returnURL=" + encodeURIComponent(location.origin + "/page/portal/search/question" + location.search);
        } else{
            location.href = properties.membershipAuthDomain()+"/login?clientId="+properties.membershipClientId()+"&branchType=toktok&callbackUrl="+ properties.membershipReturnUrlPortal() + "&returnURL=" + encodeURIComponent(properties.membershipReturnUrlPortal() + location.search);
        }
        // if(actionNm == "write"){
        //     location.href = properties.membershipAuthDomain()+"/login?clientId="+properties.membershipClientId()+"&branchType=toktok&callbackUrl="+ location.origin + "/auth/login" + "&returnURL=" + encodeURIComponent(location.origin + "/page/portal/talk/list" + location.search);
        // }else if(actionNm == "writeSearch") {
        //     location.href = properties.membershipAuthDomain()+"/login?clientId="+properties.membershipClientId()+"&branchType=toktok&callbackUrl="+ location.origin + "/auth/login" + "&returnURL=" + encodeURIComponent(location.origin + "/page/portal/search/question" + location.search);
        // } else{
        //     location.href = properties.membershipAuthDomain()+"/login?clientId="+properties.membershipClientId()+"&branchType=toktok&callbackUrl="+ location.origin + "/auth/login" + "&returnURL=" + encodeURIComponent(location.origin + "/page/portal/talk/list" + location.search);
        // }
    }

    var logout = function() {
        var clientId = properties.membershipClientId();
        var clientSecret = properties.membershipSecretKey();
        var signInCallbackUrl = properties.membershipCallbackUrl();
        var environment = properties.getSystemMode();
        if(environment == "qa") {
            environment = "stage";
        }
        var config = EtoosSDK.AuthConfiguration({ clientId: clientId, clientSecret: clientSecret, signInCallbackUrl: signInCallbackUrl, environment: environment })
        var auth = new EtoosSDK.Auth(config);
        auth.init();
        // auth.openSignOut();
        // tms.ajaxPostHelper(properties.membershipAuthApiDomain() + "/ext/auth/external/v1/logout", null, {headers:{'Authorization': 'bearer '+tms.getCookie("accessTokenInter"),'X-Client-Id':properties.membershipClientId(), 'X-Os-Code': 'OSC001'}});

        tms.setCookie("hipid", "", -1);
        tms.setCookie("linker_token", "", -1);
        tms.setCookie("accessTokenInter", "", -1);
        tms.setCookie("integratedMemberYn", "", -1);

        // 서드파티 로그아웃
        thirdPartyApi.facebook().logout();

        // window.location.reload();
        auth.openSignOut();

        var agent = navigator.userAgent.toLowerCase();
        if(agent.indexOf("safari") != -1) {
            setTimeout(function() {
                window.location.reload();
            }, 500);
        }
    }

    var logout_mo = function() {
        var clientId = properties.membershipClientId();
        var clientSecret = properties.membershipSecretKey();
        var signInCallbackUrl = properties.membershipCallbackUrl();
        var environment = properties.getSystemMode();
        if(environment == "qa") {
            environment = "stage";
        }
        var config = EtoosSDK.AuthConfiguration({ clientId: clientId, clientSecret: clientSecret, signInCallbackUrl: signInCallbackUrl, environment: environment })
        var auth = new EtoosSDK.Auth(config);
        auth.init();
        // auth.openSignOut();
        // tms.ajaxPostHelper(properties.membershipAuthApiDomain() + "/ext/auth/external/v1/logout", null, {headers:{'Authorization': 'bearer '+tms.getCookie("accessTokenInter"),'X-Client-Id':properties.membershipMobileClientId(), 'X-Os-Code': 'OSC001'}});

        tms.setCookie("hipid", "", -1);
        tms.setCookie("linker_token", "", -1);
        tms.setCookie("accessTokenInter", "", -1);
        tms.setCookie("integratedMemberYn", "", -1);

        // 서드파티 로그아웃
        thirdPartyApi.facebook().logout();

        // window.location.reload();
        auth.openSignOut();

        var agent = navigator.userAgent.toLowerCase();
        if(agent.indexOf("safari") != -1) {
            setTimeout(function() {
                window.location.reload();
            }, 500);
        }
    }

    var startMembership = function() {
        location.href = properties.membershipAuthDomain()+"/register/serviced/user-type?clientId="+properties.membershipClientId()+"&callbackUrl="+ properties.membershipCallbackUrl() + "&returnURL=" + properties.membershipCallbackUrl();
    }

    var ssoLoginCode = "";

    return {
        openAlertPopup: openAlertPopup,
        openAlertPopupMo: openAlertPopupMo,
        openConfirmPopup: openConfirmPopup,
        openConfirmPopup02: openConfirmPopup02,
        dateFormat: dateFormat,
        dateUnixFormat: dateUnixFormat,
        btnControll: btnControll,
        nextStep: nextStep,
        getDeviceType: getDeviceType,
        urlInfo: urlInfo,
        message: message,
        userInfo: userInfo,
        validation: validation,
        loginMembership: loginMembership,
        joinMembership: joinMembership,
        loginMembership_mo: loginMembership_mo,
        joinMembership_mo: joinMembership_mo,
        logout: logout,
        logout_mo: logout_mo,
        startMembership: startMembership,
        loginMembershipPortal: loginMembershipPortal,
        ssoLoginCode: ssoLoginCode
    }
}(jQuery, window, document));


$(function () {
    // console.log("linker-front-v0.1.27(1)");
    $('body').prepend('<div id="portalGnb"></div>');
    portalGnbFn();
    dataLayer.push({'conMedia': 'PCWEB'});
    var clientId = properties.membershipClientId();
    var clientSecret = properties.membershipSecretKey();
    var signInCallbackUrl = properties.membershipCallbackUrl();
    var environment = properties.getSystemMode();
    if(environment == "qa") {
        environment = "stage";
    }
    var config = EtoosSDK.AuthConfiguration({ clientId: clientId, clientSecret: clientSecret, signInCallbackUrl: signInCallbackUrl, environment: environment })
    var auth = new EtoosSDK.Auth(config);
    auth.init();

    /*
    var accessTokenInter = tms.getParameterByName("accessToken");
    if(accessTokenInter) {
        tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/etoos/login", JSON.stringify({pushKey: "", apnsPushKey: ""}), {headers:{'authorization':accessTokenInter, "osType": "P", "appVersion": "1.1.7"}}, function(res){
            if(res.resultCode === 0){
                tms.setCookie("accessTokenInter", accessTokenInter, -1);
                tms.setCookie("hipid", res.result.hipId, -1);
                tms.setCookie("token", res.result.token, -1);

                if(res.result.integratedMemberNo > 0){
                    tms.setCookie("integratedMemberYn", "Y", -1);
                }else{
                    tms.setCookie("integratedMemberYn", "N", -1);
                }
                if (accessTokenInter) {
                    history.replaceState({}, null, location.pathname);
                }

                window.location.reload();
            }
        });
    }
    */
    path = $(location).attr('pathname');

    if (path.indexOf(contextPath + "/app") == -1 &&
        path.indexOf(contextPath + "/page/membership-mo/idFind") == -1 && path.indexOf(contextPath + "/page/membership-mo/pwFind") == -1) {
        etoosSDK(auth);
    }

    $("#rwd_gnb li").each(function () {
        var href = $(this).find("a").attr("href");
        if (path == href) {
            $(this).addClass("current");
        } else {
            $(this).removeClass("current");
        }
    });

    $(".mo_footer ul > li").each(function () {
        var href = $(this).find("a").attr("href");
        if (path == href) {
            $(this).addClass("current");
        } else {
            $(this).removeClass("current");
        }
    });

    if (path.indexOf("/service/guide") > -1) {
        $(".mo_header .title").text("이용가이드");
    } else if (path.indexOf("/myLinker") > -1) {
        $(".mo_header .title").text("마이링커");
    }

    $(".ready").on("click", function () {
        alert("준비중 입니다.");
    });
});

function goDownAppMo() {

    var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
    var goDownUrl = "";
    if ( varUA.indexOf('android') > -1) {
        //안드로이드
        goDownUrl = "https://play.google.com/store/apps/details?id=com.linker.edulinker&referrer=utm_source=Weblinker&utm_medium=MOBILE";
    } else if ( varUA.indexOf("iphone") > -1||varUA.indexOf("ipad") > -1||varUA.indexOf("ipod") > -1 ) {
        //IOS
        goDownUrl = "https://apps.apple.com/kr/app/id1514722373?referrer=utm_source=Weblinker&utm_medium=MOBILE";
    } else {
        //아이폰, 안드로이드 외
        goDownUrl = "https://play.google.com/store/apps/details?id=com.linker.edulinker&referrer=utm_source=Weblinker&utm_medium=MOBILE";
    }
    window.open(goDownUrl);
}

function goGoogle() {
    if(common.getDeviceType() == "P") {
        window.open("https://play.google.com/store/apps/details?id=com.linker.edulinker&referrer=utm_source=Weblinker&utm_medium=PC");
    } else {
        window.open("https://play.google.com/store/apps/details?id=com.linker.edulinker&referrer=utm_source=Weblinker&utm_medium=MOBILE");
    }

}

function goApp(){
    if(common.getDeviceType() == "P") {
        window.open("https://apps.apple.com/kr/app/id1514722373?referrer=utm_source=Weblinker&utm_medium=PC");
    } else {
        window.open("https://apps.apple.com/kr/app/id1514722373?referrer=utm_source=Weblinker&utm_medium=MOBILE");
    }

}

var mentoPageChk = function(){
    var url = location.pathname;
    var pageArr = [contextPath + "/page/mypage/myinfo", contextPath + "/page/mypage/certify", contextPath + "/page/mypage/record", contextPath + "/page/mypage/academic_background"
        , contextPath + "/page/mypage/mentoring_01", contextPath + "/page/mypage/mentoring_02", contextPath + "/page/mypage/record", contextPath + "/page/mypage/lesson"];
    if(pageArr.indexOf(url) !== -1){
        location.href = contextPath + "/";
    } else {
        if(url.indexOf(contextPath + "/page/withdraw") !== -1 ){
            location.href = contextPath + "/";
        }
    }
}

$(document).on("click", ".btn_mail", function() {
    if ( $('.btn_mail').hasClass("on") ) {
        linkerApi.listPostBox({pageNo:1}, function(code, data, res) {
            if (code === 0) {

                var list = data.map(function (obj) {
                    obj.regDt = common.dateFormat(obj.regDt, "YYYY-MM-DD");
                    return obj;
                });

                if ( list.length ) {
                    $(".layer_mail .inner_box").append($("#postBoxTmpl").tmpl());

                    for ( var i = 0 ; i < (list.length > 5 ? 5:list.length) ; i++)
                        $("#messageList").append($("#messageListTmpl").tmpl(list[i]));
                }
                else {
                    $(".layer_mail .inner_box").append($("#noPostBoxTmpl").tmpl());
                }
            }
        });
    }
    else {
        $(".layer_mail .inner_box").empty();
    }
});

$(document).on("click", ".btn_list", function() {
    location.href = common.urlInfo.postList;
});

function previewProfile(hipId){
	$(".rwd_popup_mentoring").addClass("open");
	var hipId = hipId;
	var listType = 'MENTORING';
	getMentorProfile(hipId, listType);
	getMentorInfo(hipId);
}

function closePopup() {
    window.location.reload();
}

var etoosSDK = function(auth) {
    // 서드파티 로그아웃
    thirdPartyApi.facebook().logout();
    if (tms.isEmpty(tms.getCookie("mid_at")) && tms.getCookie("integratedMemberYn") == "Y") {
        // 포탈 토큰 없을때 -> 로그아웃으로 처리
        if (properties.getSystemMode() != "dev") {
            tms.setCookie("hipid", "", -1);
            tms.setCookie("linker_token", "", -1);
            tms.setCookie("accessTokenInter", "", -1);
            tms.setCookie("integratedMemberYn", "", -1);

            // 서드파티 로그아웃
            thirdPartyApi.facebook().logout();

            // if (tms.getCookie("reload") != "false") {
            //     var todayDate = new Date();
            //     todayDate.setMinutes(todayDate.getMinutes() + 1);
            //     document.cookie = "reload" + "=" + escape("false") + "; path=/; expires=" + todayDate.toGMTString() + ";"
            //     setTimeout(function () {
            //         window.location.reload();
            //     }, 800);
            // }
        }
    }

    auth.signIn(function (response) {
        // console.log("[Client] signIn(response): " + JSON.stringify(response));
        // gnb내 질문톡에서 사용할 변수
        common.ssoLoginCode = response.code;

        if (response.code === 0) {
            // Success: handle SignIn
            auth.getToken(function (response2) {
                //console.log("[Client] getToken(response): " + JSON.stringify(response2));
                if (response2.code === 0) {
                    tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/etoos/login", JSON.stringify({
                        pushKey: "",
                        apnsPushKey: ""
                    }), {
                        headers: {
                            'authorization': response2.value,
                            "osType": "P",
                            "appVersion": "1.1.7"
                        }
                    }, function (res) {
                        var accessTokenInter = tms.getCookie("accessToken");

                        if (res.resultCode === 0) {
                            if(tms.isEmpty(tms.getCookie("linker_token")) && tms.isEmpty(tms.getCookie("hipid"))) {
                                tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/etoos/addConnectLog", JSON.stringify({pushKey: "", apnsPushKey: ""}), {headers: {'authorization': response2.value, "osType": "P", "appVersion": "1.1.7"}}, null);
                            }

                            tms.setCookie("accessTokenInter", response2.value, -1);
                            tms.setCookie("hipid", res.result.hipId, -1);
                            tms.setCookie("linker_token", res.result.token, -1);

                            if (res.result.integratedMemberNo > 0) {
                                tms.setCookie("integratedMemberYn", "Y", -1);
                            } else {
                                tms.setCookie("integratedMemberYn", "N", -1);
                            }

                            if(accessTokenInter) {
                                //var todayDate = new Date();
                                //todayDate.setMinutes(todayDate.getMinutes() + 1);
                                //document.cookie = "reload2" + "=" + escape("false") + "; path=/; expires=" + todayDate.toGMTString() + ";";

                                history.replaceState({}, null, location.pathname);
                            }
                        }
                        linkerLoginLogic();
                    });
                }
            });
        } else if(response.code === 10009 || response.code === 10046 || response.code === 10047) {
            // if(tms.isNotEmpty(tms.getCookie("mid_at")) && !common.userInfo.isLogin){
            //     // 포탈 토큰 있고, 서비스 로그인 안되었을때 -> 로그인 대신 동의 후 시작하기 버튼 노출 / 회원가입 대신 로그아웃
            //     console.log("포탈 토큰 있고, 서비스 로그인 안되었을때");
            //     $("#rwd_header .login_menu").replaceWith($("#headerTmpl2").tmpl(null));
            //     $("#rwd_header .login_menu_mo").replaceWith($("#headerTmpl2_mo").tmpl(null));
            //     isEtoosIpCheck();
            // }
            tms.setCookie("hipid", "", -1);
            tms.setCookie("linker_token", "", -1);
            tms.setCookie("accessTokenInter", "", -1);
            tms.setCookie("integratedMemberYn", "", -1);
            linkerLoginLogic();
            $("#rwd_header .login_menu").replaceWith($("#headerTmpl2").tmpl(null));
            $("#rwd_header .login_menu_mo").replaceWith($("#headerTmpl2_mo").tmpl(null));
        }else{
            // Failure: handle SignOut
            // var accessTokenInter = tms.getCookie("accessToken");
            // var integrateType = tms.getCookie("mid_type");
            var accessTokenInter = tms.getParameterByName("accessToken");
            var integrateType = tms.getParameterByName("type");

            if(accessTokenInter && integrateType != "account" && integrateType != "sns"){
                tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/etoos/login", JSON.stringify({
                    pushKey: "",
                    apnsPushKey: ""
                }), {
                    headers: {
                        'authorization': accessTokenInter,
                        "osType": "P",
                        "appVersion": "1.1.7"
                    }
                }, function (res) {
                    if (res.resultCode === 0) {
                        tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/etoos/addConnectLog", JSON.stringify({pushKey: "", apnsPushKey: ""}), {headers: {'authorization': accessTokenInter, "osType": "P", "appVersion": "1.1.7"}}, null);

                        tms.setCookie("accessTokenInter", accessTokenInter, -1);
                        tms.setCookie("hipid", res.result.hipId, -1);
                        tms.setCookie("linker_token", res.result.token, -1);

                        if (res.result.integratedMemberNo > 0) {
                            tms.setCookie("integratedMemberYn", "Y", -1);
                        } else {
                            tms.setCookie("integratedMemberYn", "N", -1);
                        }

                        history.replaceState({}, null, location.pathname);
                    }
                    linkerLoginLogic();
                });
            }else{
                linkerLoginLogic();
            }
        }
    });
}

var portalGnbFn = function() {
    if($(location).attr('pathname').indexOf("point/payment") < 0 && $(location).attr('pathname').indexOf("point/purchase") < 0 &&
        $(location).attr('pathname').indexOf("/page/portal") == -1 && $(location).attr('pathname').indexOf("/app") == -1 &&
        $(location).attr('pathname').indexOf("/page/membership-mo/idFind") == -1 && $(location).attr('pathname').indexOf("/page/membership-mo/pwFind") == -1
    ){
        $('head').append('<script type="text/javascript" src="'+properties.etoosGnbUrl()+'" id="gnbService" data-service="linker" data-device="web" defer="defer"></script>');
        $('#rwd_header .inner_box').removeClass("topzero");
    }

    setTimeout(function() {
        gnbCss();
    }, 800);
}

var gnbCss = function () {
    var jbMedia = window.matchMedia("( max-width: 1024px )");
    if($(location).attr('pathname').indexOf("point/payment") < 0 && $(location).attr('pathname').indexOf("point/purchase") < 0 &&
        $(location).attr('pathname').indexOf("/page/portal") == -1 && $(location).attr('pathname').indexOf("/app") == -1 &&
        $(location).attr('pathname').indexOf("/page/membership-mo/idFind") == -1 && $(location).attr('pathname').indexOf("/page/membership-mo/pwFind") == -1
    ){
        if (jbMedia.matches === true) {
            //$('#rwd_header .inner_box').removeClass("top100");
            //$('#rwd_header .inner_box').addClass("top50");
            if($(window).scrollTop() == 0) {
                $(".rwd_mentoring .choice_box, .rwd_lesson .choice_box").css("top", "102px");
                //$("#main_contents").css("top", "190px");
                $(" .rwd_column .rwd_tab").css("top", "102px");
                $(".rwd_column .rwd_top_wrap").css("top", "50px");
            }else{
                $(".rwd_mentoring .choice_box, .rwd_lesson .choice_box").css("top", "52px");
                //$("#main_contents").css("top", "90px");
                $(" .rwd_column .rwd_tab").css("top", "52px");
                $(".rwd_column .rwd_top_wrap").css("top", "0");
            }
        }else {
            //$('#rwd_header .inner_box').removeClass("top50");
            //$('#rwd_header .inner_box').addClass("top100");
            if($(window).scrollTop() == 0) {
                $(".rwd_mentoring .choice_box, .rwd_lesson .choice_box").css("top", "160px");
                $("#main_contents").css("top", "190px");
                $(".rwd_column .rwd_top_wrap").css("top", "100px");
            }else{
                $(".rwd_mentoring .choice_box, .rwd_lesson .choice_box").css("top", "60px");
                $("#main_contents").css("top", "90px");
                $(".rwd_column .rwd_top_wrap").css("top", "0");
            }
        }
    }else {
        $("#portalGnb").css("display", "none");
        $('#rwd_header .inner_box').addClass("topzero");
        //$('#rwd_header .inner_box').removeClass("top100");
        //$('#rwd_header .inner_box').removeClass("top50");
        if (jbMedia.matches === true) {
            $(".rwd_mentoring .choice_box, .rwd_lesson .choice_box").css("top", "52px");
            //$("#main_contents").css("top", "90px");
            $(" .rwd_column .rwd_tab").css("top", "52px");
            $(".rwd_column .rwd_top_wrap").css("top", "0");
        }else {
            $(".rwd_mentoring .choice_box, .rwd_lesson .choice_box").css("top", "60px");
            $("#main_contents").css("top", "90px");
            $(".rwd_column .rwd_top_wrap").css("top", "0");
        }
    }
}

var linkerLoginLogic = function () {
    authorization = tms.getCookie("linker_token");
    hipId = tms.getCookie("hipid");
    tms.setAjaxDefaults(hipId, authorization);

    if (path.indexOf(contextPath + "/page/portal") == -1) {
        if (tms.isNotEmpty(authorization)) {
            inventoryApi.retrieveUserInformationInTheInventory(function (code, data, res) {
                if (code === 0) {
                    common.userInfo.nickname = data.nickname;
                    common.userInfo.mentorYn = data.mentorYn;
                    common.userInfo.email = data.emailId;
                    common.userInfo.mobileNumber = data.mobileNumber;
                    common.userInfo.isLogin = true;

                    var pointParam = {
                        service_id: "LINKER",
                        coin_id: (common.userInfo.mentorYn == "Y") ? "LINKER_MENTO_CASH" : "LINKER_MENTI_CASH"
                    };

                    if (common.userInfo.mentorYn === "N") {
                        mentoPageChk();
                        tms.ajaxGetHelper(properties.apiHostShop() + "/coin/" + properties.apiVersionShop + "/Balance", pointParam, null, function (res) {
                            var code = res.response_code;
                            var data = (code === 0) ? res.value.coin_amount : '';

                            var $rwdObj = $("#rwd_header .login_menu");
                            $rwdObj.find('.money').prepend(tms.setComma(data));

                            var $sumObj = $(".awl_header .awl_mentee_summary");
                            $sumObj.find('.awl_summary_point').text(tms.setComma(data));
                        });
                    } else if (common.userInfo.mentorYn === "Y") {
                        tms.ajaxGetHelper(properties.apiHostShop() + "/coin/" + properties.apiVersionShop + "/Balance", pointParam, null, function (res) {
                            var code = res.response_code;
                            var data = (code === 0) ? res.value.coin_amount : '';

                            var $rwdObj = $("#rwd_header .login_menu");
                            $rwdObj.find('.money').prepend(tms.setComma(data));
                        });
                    }

                }

                var data = common.userInfo;
                data.loginUrl = common.urlInfo.login;
                data.joinUrl = common.urlInfo.join;
                data.postUrl = common.urlInfo.postList;
                data.myinfoUrl = (common.userInfo.mentorYn === "Y") ? common.urlInfo.myPageMyInfo : common.urlInfo.menteeHome; // 멘티인 경우 별도로 home을 생성함
                data.couponUrl = common.urlInfo.useCoupon; // 쿠폰함 추가
                data.pointUrl = (common.userInfo.mentorYn === "Y") ? common.urlInfo.withdrawPoint : common.urlInfo.pointList; // 포인트 추가

                //GNB 메뉴 멘토칼럼/과외 뷰/숨김처리
                if (common.userInfo.mentorYn == "Y") {
                    $("#rwd_gnb li").each(function () {
                        var dataValue = $(this).attr("data-value");
                        if (dataValue == "mentoring" || dataValue == "lesson" || dataValue == "mylinker") {
                            $(this).hide();
                        } else if (dataValue == "menteeMentoring" || dataValue == "menteeLesson") {
                            $(this).show();
                        }
                    });
                } else {
                    $("#rwd_gnb li").each(function () {
                        var dataValue = $(this).attr("data-value");
                        if (dataValue == "mentoring" || dataValue == "lesson" || dataValue == "mylinker") {
                            $(this).show();
                        }
                    });
                }

                $("#rwd_header .login_menu").replaceWith($("#headerTmpl").tmpl(data));
                $("#rwd_header .login_menu_mo").replaceWith($("#headerTmpl_mo").tmpl(data));

                // 간소화 회원 포인트 메뉴 삭제 처리
                simpleUser.hideMenuToPoint();

                tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveProfile", null, null, function (res) {
                    if (res.resultCode === 0) {
                        var destUrl = res.result.destUrl;
                        if (tms.isNotEmpty(destUrl)) {
                            data.profileImg = "<img src='" + destUrl + "' />";
                        }

                        $("#util_layer").append($("#utilTmpl").tmpl(data));

                        /* 마이페이지 callback */
                        if (typeof mypageCallback === "function") {
                            mypageCallback(res);
                        }
                    }

                    var newImg = '<img src="https://d3520qxzbk1an7.cloudfront.net/etc/78d45ed152f444ebb28b2d5e0f0e3df1.png" class="new"/>';
                    var $rwdObj = $("#rwd_header .login_menu");

                    linkerApi.unreadCountPostBox(function (code, data, res) {
                        if (code === 0) {
                            if (data > 0) {
                                $rwdObj.find('.btn_mail').html(newImg);
                            }
                        }
                    });

                    inventoryApi.inventoryNumber({inventoryType: 1}, function (code, data) {
                        if (code === 0) {
                            if (data.inventoryNumber != 0) {
                                $rwdObj.find('.btn_coupon').html(newImg);
                            }
                        }
                    });

                    UI.fn_gnb();
                });
                if (typeof sessionCallback === "function") {
                    sessionCallback(res);
                }
                // portalGnbFn();
            });
        } else {
            var data = {};
            data.loginUrl = common.urlInfo.login;
            data.joinUrl = common.urlInfo.join;
            data.myinfoUrl = common.urlInfo.myPageMyInfo;

            $("#rwd_header .login_menu").replaceWith($("#headerTmpl").tmpl(data));
            $("#rwd_header .login_menu_mo").replaceWith($("#headerTmpl_mo").tmpl(data));

            // portalGnbFn();

            $("#rwd_gnb li").each(function () {
                var dataValue = $(this).attr("data-value");
                if (dataValue == "mentoring" || dataValue == "lesson") {
                    $(this).show();
                }
            });
        }
    }else if(path.indexOf(contextPath + "/page/portal/talk/list") != -1) {
        inventoryApi.retrieveUserInformationInTheInventory(function (code, data) {
            if (code === 0) {
                common.userInfo.isLogin = true;
                mentorYn = data.mentorYn;
                userMentorYn = data.mentorYn;
                if (mentorYn == "Y") {
                    $(".moveQuestion_btn").hide();
                    $("#moveQuestion").hide();
                    $('#moveQuestion2').unbind().bind('click', function () {
                        //$(".downloadApp").trigger('click');
                        window.open(goAppOneLink);
                    });
                    if (!inappCheck) {
                        $('.banner_img').attr("src", "/pc/images/image_portal_mentor_01.png");
                    } else {
                        $('.banner_img').attr("src", "/pc/images/image_portal_mentor_01_pc.png");
                    }
                }else {
                    $(".moveQuestion_btn").show();
                    $("#moveQuestion").show();
                }
            }
        });
    }else if(path.indexOf(contextPath + "/page/portal/search/question") != -1) {
        inventoryApi.retrieveUserInformationInTheInventory(function (code, data) {
            if (code === 0) {
                mentorYn = data.mentorYn;
                userMentorYn = data.mentorYn;
                if (mentorYn == "Y") {
                    $(".moveQuestion_btn").hide();
                    $("#moveQuestion3").hide();
                } else {
                    $(".moveQuestion_btn").show();
                    $("#moveQuestion3").show();
                }
            }
        });
    }else if(path.indexOf(contextPath + "/page/portal/talk/myTalk") != -1){
        getMyTalkList(currentPaging2, limit, ".awl_main_mojimylist");
    }else if(path.indexOf(contextPath + "/page/portal/talk/detail") != -1){
        var etoosOpentalkToken = tms.getParameterByName("etoosOpentalkToken");
        if (etoosOpentalkToken) {
            portaltalkApi.retrieveAuthorValue(JSON.stringify({etoosOpentalkToken:etoosOpentalkToken}), {async:false}, function(code, data){
                if (code == 0) {
                    if (data.hasKey) {
                        userHipId = data.hipId;
                        authorization = data.token;
                        tms.setAjaxDefaults(userHipId, authorization);
                    }
                }else {
                    userHipId = "";
                    authorization = "";
                    tms.setAjaxDefaults(userHipId, authorization);
                }
            });
        }
    }else if(path.indexOf(contextPath + "/page/portal/talk/write") != -1){
        if(isLoginCheck() != 0) {
            return;
        }

        /* 회원정보 조회 */
        inventoryApi.retrieveUserInformationInTheInventory(function (code, data) {
            if (code === 0) {
                common.userInfo.isLogin = true;
                userMentorYn = data.mentorYn;
                if (data.mentorYn == "Y") {
                    openAlertPopupMoji("질문톡 작성하기는<br>멘티님만 이용이 가능합니다.", function(){
                        location.href = contextPath + "/page/portal/talk/list"  + location.search;
                    });
                }
                //$(".moji_write_option").prepend("<div class='myNickname'><strong>" + data.nickname + "</strong>님 정확하고 빠른 답변을 위해<br>계열을 선택해주세요.<span class='myNickname_txt1'> (최대 3개)</span><span class='myNickname_txt2'>* 처음 오신 회원님은 닉네임이 자동 생성 되었어요!</span></div>");
            }
        });

        /*첫질문 여부 확인*/
        mojiMatchingRequestInfo();

        /* 질문가능 여부 확인 */
        canJoinPortalDailyEvent("stayCheck");
    }
}
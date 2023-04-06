<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/pc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="commonUtils" class="com.etoos.portal.global.util.CommonUtils"/>
<t:noLayout>
	<jsp:attribute name="script_file">
        <%@ include file="/WEB-INF/view/tmpl/pc/portalTalkTmpl.jsp" %>
		<%@ include file="/WEB-INF/view/tmpl/app/talkSearchTmpl.jsp" %>
        <%@ include file="/WEB-INF/view/tmpl/app/talkAutoCompleteTmpl.jsp" %>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/inventory_api.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/shop_api.js?ver=20221215"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/consult_api.js?ver=20221215"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/linker_api.js?ver=20221215"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/myPage_api.js?ver=20221215"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/blockContents.js?ver=20221215"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/apps/js/search/list.js?ver=20221215"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/apps/js/search/log.js?ver=20221215"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/api/portaltalk_api.js?ver=20221215"></script>
        <script type="text/javascript" async>
            searchTab = "Q";
            var keywordParam = tms.getParameterByName("keyword");
            keywordParam = unescape(decodeURIComponent(keywordParam));
            var ipAddress = "${commonUtils.getClientIP(null)}";
            jsessionid = "${commonUtils.getCookie(null, 'JSESSIONID')}";

            var userAgent = window.navigator.userAgent.toLowerCase();

            var inApp = new Array('iphone','android');

            var inappCheck = false;
            for(var appWord in inApp){
                if(userAgent.match(inApp[appWord]) != null){
                    appcss();
                    inappCheck = true;
                }
            }
            if(userAgent.indexOf("mac") > -1){
                if(window.navigator.maxTouchPoints == 5){
                    appcss();
                }
            }``

            function appcss() {
                top.window.$('head').append('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">');
                // $('.moveQuestion_btn > div').css({'width': '100%', 'margin': '', 'max-width': 'inherit'});
                $('.awl_fixer_plus2').css({'right':'16px'});
                // $(".btn_top_moji").css({"background": "url(" + contextPath +"/apps/images/ic_moji_top.png)", "background-size" : "contain"});
            }

            if(!inappCheck) {
                var width = $(window).width();
                width = (width-400)/2+4.5;
                $('.awl_fixer_plus2').css({'right':width+'px'});

                $(window).resize(function() {
                    var width = $(window).width();
                    width = (width-400)/2+13;
                    $('.awl_fixer_plus2').css({'right':width+'px'});
                });
            }

            var gnbParams = location.search;
            if(gnbParams.indexOf("keyword") != -1) {
                gnbParams = "?" + gnbParams.substr(gnbParams.indexOf("gnbService"));
            }
            tms.isBriefing();

            $(function() {
                $("body").css({"background-color": "#F7F9FF","overflow":"hidden",});
                <%--top.window.$('head').append('<link rel="shortcut icon" href="${pageContext.request.contextPath}/pc/images/favicon/72x72.png">');--%>

                if(keywordParam.length > 0) {
                    $(".search_area .btn_del").show();
                }else{
                    $(".search_area .btn_del").hide();
                }

                $("#searchKeyword").val(keywordParam);
                // 질문톡 목록 조회
                getOpenTalkListSearchResult(currentPaging, limit, ".awl_main_list");

                // 스크롤 페이지
                $(window).scroll(function(){
                    if ((chkPage <= currentPaging) && !endPage &&  $(window).scrollTop() + $(window).height() >= $(document).height() - 182) {
                        getOpenTalkListSearchResult(currentPaging, limit, ".awl_main_list");
                    }

                    if ($(this).scrollTop() <= 0) {
                        $(".btn_top_moji").hide();
                        $('.btn_moveQuestion_moji').css('grid-area', 'c');
                        $(".moveQuestion_btn").hide();
                    } else {
                        $(".btn_top_moji").show();
                        $('.btn_moveQuestion_moji').css('grid-area', 'b');
                        $(".moveQuestion_btn").show();
                    }
                });

                $("#searchKeyword").on("keypress", function(event) {
                    if(event.keyCode == 13) {
                        keywordParam = $("#searchKeyword").val().trim();
                        if(tms.isEmpty(keywordParam)) {
                            openAlertPopupMoji("검색어를 입력해주세요.");
                            return false;
                        }
                        endPage = false;
                        currentPaging = 1;
                        chkPage = 1;
                        $(".awl_main_list").html("");

                        getOpenTalkListSearchResult(currentPaging, limit, ".awl_main_list");
                    }
                });

                $(".btn_do_search").on("click", function(event) {
                    keywordParam = $("#searchKeyword").val().trim();
                    if(tms.isEmpty(keywordParam)) {
                        openAlertPopupMoji("검색어를 입력해주세요.");
                        return false;
                    }
                    endPage = false;
                    currentPaging = 1;
                    chkPage = 1;
                    $(".awl_main_list").html("");

                    getOpenTalkListSearchResult(currentPaging, limit, ".awl_main_list");
                });

                //닫기 버튼
                $(".awl_opentalk_header .btn_prev").on("click", function(){
                    location.href = contextPath + "/page/portal/talk/list"  + gnbParams;
                });

                <%-- 질문톡 작성 페이지 이동 --%>
                $(document).on("click",  "#moveQuestion3", function(){
                    if (isLoginCheck("writeSearch") == 0) {
                        portaltalkApi.canJoinPortalDailyEvent(null, function(code, data, res){
                            portaltalkApi.retrieveMeasure(null, function(code2, data2){
                                if(code === 0 && code2 === 0){
                                    if (data.canJoin) {
                                        if(gnbParams.indexOf("?") == 0) {
                                            location.href = contextPath + "/page/portal/talk/write?keyword="+keywordParam+"&prev=question&" + gnbParams.substr(1);
                                        }else {
                                            location.href = contextPath + "/page/portal/talk/write?keyword="+keywordParam+"&prev=question";
                                        }
                                    }else{
                                        openAlertPopupMoji("질문 작성 건수가 모두 소진 되었어요.<br>(1일 선착순 "+data2.dailyTotalCnt+"건, 1인 1일 "+data2.dailyJoinCnt+"회 작성 가능)");
                                    }
                                }else {
                                    location.href = contextPath + "/page/portal/talk/movePage" + gnbParams;
                                }
                            });
                        });
                    }
                });
            });

            //질문톡 통합검색 결과
            var getOpenTalkListSearchResult = function(no, limit, obj, option) {
                chkPage++;

                var params = {
                    pageNo: no,
                    limit: limit,
                    keyword: keywordParam
                };

                var url = contextPath + "/api/search/questionList";
                var options = {
                    showLoding : true
                }
                tms.ajaxGetHelper(url, params, options, function(res) {

                    var code = res.code;
                    var talkList = res.data.list;
                    var msg = res.message;
                    var totalSize = res.data.totalCnt;
                    var hitYn = false;
                    if(totalSize > 0) {
                        hitYn = true;

                    }
                    if(Math.ceil(totalSize / limit) == no){
                        endPage = true;
                    }
                    $("#recommendList").empty();
                    if(code === 0 && talkList.length > 0){
                        talkList.map(function(obj){
                            obj.resourceUri = "";
                            return obj;
                        });
                        setTalkQuestionSearchList(talkList, no, obj, 'question');
                        logSearchList(hitYn, "Q");
                        $(".btn_question").hide();
                        $(".blockContents").hide();
                    } else {
                        if(spellCheck == 0) {
                            spellCheck++;
                            setTalkSpellCheck("Q", ".awl_main_list");
                        } else {
                            if(no == 1){
                                //var noData = [{msgData : '조회된 결과가 없습니다.'}];
                                //$("#noDataTmpl").tmpl(noData).appendTo(obj);

                                $("#talkNoDataRecommendTmpl3").tmpl().appendTo("#recommendList");
                                getRecommendKeyworkPortal();
                            }
                            endPage = true;
                            return;
                        }
                    }

                })
            };

            var openAlertPopupMoji = function(title, fnAction){
                $(".popup_alert_moji").html("");
                $("#alert_moji").tmpl({title:title}).appendTo(".popup_alert_moji");

                $(".popup_alert_moji .btn_box a").html("");
                $(".popup_alert_moji .btn_box a").html("확인");
                Layer_OPEN(".popup_alert_moji");

                if(typeof fnAction == "function"){
                    $(".popup_alert_moji .btn_box a").bind("click", function(){
                        fnAction();
                        $(this).unbind();
                    });
                }

            };

            var isLoginCheck = function(actionNm){
                if(tms.isNotEmpty(tms.getCookie("linker_token")) && common.ssoLoginCode == -1) {
                    if(tms.isEmpty(tms.getCookie("integratedMemberYn")) || tms.getCookie("integratedMemberYn") == "N"){
                        var params = {
                            client_id: properties.membershipClientId(),
                            client_secret: properties.membershipSecretKey(),
                            hip_id: tms.getCookie("hipid")
                        }

                        tms.ajaxPostHelper(properties.membershipAuthApiDomain() + "	/ext/auth/external/v1/linker/hipid/transfer/check", JSON.stringify(params), {headers:{'X-Os-Code': 'OSC001'}, showLoding: true}, function(res){
                            if(res.code == 10008){
                                //var membershipUrl = properties.getSystemMode() == "dev" ? "https://dev-my.linker.ac" : properties.getSystemMode() == "stage" ? "https://stage-my.linker.ac" : "https://my.linker.ac";
                                openAlertPopupMoji("질문톡은 통합회원에 한해서 제공됩니다.<br>통합회원으로 전환하시겠어요?", function(){
                                    location.href = properties.membershipAuthDomain()+"/transfer/gate?forceTransfer=Y&clientId="+properties.membershipClientId()+"&sessionToken="+res.value.session_token+"&callbackUrl="+properties.membershipCallbackUrlPortal() + "&returnURL=" + encodeURIComponent(properties.membershipReturnUrlPortal() + location.search);
                                });
                                return -1;
                            }else if(res.code == 10027) {
                                openAlertPopupMoji("재로그인 후 이용해 주시길 바랍니다.", function(){
                                    tms.setCookie("hipid", "", -1);
                                    tms.setCookie("linker_token", "", -1);
                                    tms.setCookie("accessTokenInter", "", -1);
                                    tms.setCookie("integratedMemberYn", "", -1);

                                    common.loginMembershipPortal();
                                });
                                return -1;
                            }else {
                                location.href = contextPath + "/page/portal/talk/movePage" + gnbParams;
                            }
                        });
                    }
                }else if(common.ssoLoginCode === 10009 || common.ssoLoginCode === 10046 || common.ssoLoginCode === 10047) {
                    //openConfirmPopupMoji({title: "질문톡 서비스 이용 동의 후 사용할 수 있습니다.", checkWord: "확인", cancelWord: "취소"}, function(){
                    common.loginMembershipPortal(actionNm);
                    //});
                    return -1;
                }else if(!common.userInfo.isLogin && common.ssoLoginCode !== 0){
                    //openConfirmPopupMoji({title: "로그인 후 서비스를 이용할 수 있습니다.", checkWord: "로그인", cancelWord: "취소"}, function(){
                    //window.opener.postMessage("parentWindowLogin", "*");
                    common.loginMembershipPortal(actionNm);
                    //});
                    return -1;
                }else {
                    return 0;
                }
            };

            <%-- 상단으로 이동 --%>
            $('#moveTop').on("click",function(){
                $('.portal_search').animate({scrollTop: '0'}, 1000);
            });

            <%-- 탭메뉴 이동 --%>
            $('.board_menu_box a').click(function(event){
                event.preventDefault();
                var tabNo = $(this).data("tab");
                $('.awl_header_b').children('a').removeClass('on');

                if(tabNo == 3) {
                    location.href = contextPath + "/page/portal/column" + gnbParams;
                }else if(tabNo == 4) {
                    location.href = contextPath + "/page/portal/briefing" + gnbParams;
                }else if(tabNo == 0) {
                    location.href = contextPath + "/page/portal/talk/myTalk" + gnbParams;
                }else{
                    location.href = contextPath + "/page/portal/talk/list" + gnbParams;
                }
            });

            (function(){
                const portal_search = document.querySelector('.portal_search');
                const search_box = document.querySelector('.portal_search .search_area');
                const awl_wrap = document.querySelector('.portal_search .awl_wrap');
                const both_area_new = document.querySelector('.portal_search .both_area_new');
                const datalist = document.querySelector('.datalist');
                const searchKeyword = document.getElementById('searchKeyword');
                let awl_opentalk_header_H = document.querySelector('.portal_search .awl_opentalk_header .in_box').clientHeight;
                let awl_wrap_top = both_area_new.getBoundingClientRect().top + both_area_new.clientHeight + search_box.querySelector('.in_box').clientHeight + 9 + 15 - 100;
                let portalSearchTop;

                window.addEventListener('resize', function(){
                    if(search_box.classList.contains('fixed')){
                        datalist.style.paddingLeft = searchKeyword.getBoundingClientRect().left + 'px';
                    } else {
                        datalist.style.paddingLeft = 17 + 'px';
                    }
                    $(datalist).width(searchKeyword.offsetWidth + 'px');
                });

                portal_search.addEventListener('scroll',() => {
                    portalSearchTop = portal_search.scrollTop;
                    if(portalSearchTop > awl_wrap_top){
                        search_box.classList.add('fixed');
                        awl_wrap.style.marginTop = awl_opentalk_header_H+'px';

                        datalist.style.top = 58 + 'px';
                        datalist.style.paddingTop = 0;
                        datalist.style.paddingRight = 0;
                        datalist.style.paddingBottom = 0;
                        datalist.style.paddingLeft = searchKeyword.getBoundingClientRect().left + 'px';
                        $(datalist).width(searchKeyword.offsetWidth + 'px');
                    } else{
                        search_box.classList.remove('fixed');
                        awl_wrap.style.marginTop = 0;

                        datalist.style.top = 42 + 'px';
                        datalist.style.paddingTop = 0;
                        datalist.style.paddingRight = 0;
                        datalist.style.paddingBottom = 0;
                        datalist.style.paddingLeft = 17 + 'px';
                        $(datalist).width(searchKeyword.offsetWidth + 'px');
                    };

                    if ((chkPage <= currentPaging) && !endPage &&  portal_search.scrollTop + portal_search.clientHeight >= portal_search.scrollHeight - 300) {
                        getOpenTalkListSearchResult(currentPaging, limit, ".awl_main_list");
                    }

                    if (portal_search.scrollTop <= 0) {
                        $(".btn_top_moji").hide();
                    } else {
                        $(".btn_top_moji").show();
                    }
                });

                $.fn.scrollStopped = function(callback) {
                    var that = this, $this = $(that);
                    $this.scroll(function(ev) {
                        if($this.scrollTop() > 0) {
                            $(".moveQuestion_btn").hide();
                            clearTimeout($this.data('scrollTimeout'));
                            $this.data('scrollTimeout', setTimeout(callback.bind(that), 250, ev));
                        }
                    });
                };

                $(portal_search).scrollStopped(function(ev){
                    if(userMentorYn == "N") {
                        $(".moveQuestion_btn").show();
                    }
                });
            })();
        </script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/apps/common/css/common.css?ver=20221215" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/apps/common/css/custom.css?ver=20221215" />
<%--        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/apps/common/css/awl_openTalk.css?ver=20221102" />--%>
        <style>
            .rank_list ol{width: 100%; padding: 0; float:none; overflow-y: auto; overflow-x: auto; white-space: inherit; height: auto; padding-top: 0;}
            #recommendList{overflow-y: auto; overflow-x: auto; white-space: inherit;}
            .rank_list ol li{margin-right: 5px; margin-left: 0; font-size: 13px; font-weight: 400; color: #676767; overflow: hidden; box-shadow:none; margin-top: 0 !important; background: #E8EBF5; border-radius: 100px; padding: 0 11px; width: fit-content; display: inline-block; letter-spacing: -0.04em; vertical-align: top; line-height: 26px;}
            .awl_main_list li{border: 1px solid #cdcdcd; box-shadow: none;}
            .awl_main_list li + li{margin-top: 16px;}
            .awl_content{padding: 14px 18px; padding-top: 15px;}
            .awl_categoryNm{justify-content: flex-end;}
        </style>
    </jsp:attribute>
    <jsp:body>
        <div class="mojiboard">
            <div id="headerArea" class="board_menu_box" style="padding: 0;width: 100%; position:relative; top: 0px; left: 0;background-color: #fff; border-bottom: 1px solid #F1F1F1;z-index: 999">
                <div class="awl_header2" style="width: 100%; height: 50px; max-width: 400px; margin: 0 auto;">
                    <div class="awl_header_l">
                        <img src="${pageContext.request.contextPath}/pc/images/portaltalk_title2.png" alt="입SEE" style="width: 99px;">
                    </div>
                    <div class="awl_header_c" style="cursor: pointer;width: fit-content; position: absolute;top: 0;right: 0;">
<%--                        <div class="goKakaoQuestion">--%>
<%--                            <div class="goKakaoQuestion_img">--%>
<%--                                <img src="${pageContext.request.contextPath}/pc/images/gnb_kakao_talk_img2.svg" alt="질문톡 고객센터" style="width: 16px;">--%>
<%--                            </div>--%>
<%--                            <div class="goKakaoQuestion_txt_area">--%>
<%--                                <span class="goKakaoQuestion_txt1">질문톡 고객센터</span>--%>
<%--                                <span class="goKakaoQuestion_txt2">평일 10시 - 17시</span>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div class="veiwEventWinner" style="width: 175px; height: 42px; margin-top: 4px;margin-right: 16px; display: none;">
                            <img src="${pageContext.request.contextPath}/pc/images/event_winner_btn2.svg" alt="질문톡 이벤트 당첨자" style="transform: translateX(-4px);">
                        </div>
                    </div>
                    <div class="awl_header_r">
                    </div>
                </div>

                <div class="awl_header_b" style="max-width: 384px;margin: 0 auto;padding-left: 16px;font-family:'Apple SD Gothic Neo', dotum, Arial, sans-serif;">
                    <a href="javascript:void(0);" id="btn_talk" class="moji_tab on" data-tab="1">질문톡</a>
                    <a href="javascript:void(0);" id="btn_column" class="moji_tab" data-tab="3">멘토칼럼</a>
                    <a href="javascript:void(0);" id="btn_briefing" class="moji_tab" data-tab="4" style="display: none">
                        <img src="${pageContext.request.contextPath}/pc/images/briefing_icon.png" style="width: 14px; vertical-align: text-top;margin-top: 1px;"> 설명회
                    </a>
                    <a href="javascript:void(0);" id="btn_mytalk" class="moji_tab" data-tab="0">내글</a>
                </div>
            </div>

            <div class="portal_search">
                <div class="awl_opentalk_header">
                    <div class="both_area_new">
                        <div class="fl_r">
                            <a href="javascript:void(0);" class="btn_prev"><span class="blind">닫기</span></a>
                        </div>
                        <h2 class="awl_talkTit">검색 결과</h2>
                    </div>
                    <div class="search_area">
                        <div class="in_box">
                            <a href="javascript:void(0);" class="btn_prev"><span class="blind">닫기</span></a>
                            <input type="text" id="searchKeyword" placeholder="검색어를 입력해 주세요." value="">
                            <button type="button" class="btn_del"><span class="blind">삭제</span></button>
                            <button type="button" class="btn_do_search"><span>검색하기</span></button>
                        </div>
                        <div class="datalist" style="padding: 0 93px 0 17px; top:42px; display: none;">
                        </div>
                    </div>
                </div>
                <div class="awl_wrap">
                    <div class="awl_content" style="background-color: #F7F9FF;">
                            <%-- 리스트 --%>
                        <ul class="awl_main_list"></ul>
                        <div id="recommendList" style="position: relative;"></div>
                    </div>
                    <div class="awl_fixer_plus2 on" style="bottom: 79px;">
                        <a href="javascript:void(0);" id="moveTop" class="btn_top_moji" style="display: none;"><span class="blind">TOP</span></a>
                    </div>
                    <div class="moveQuestion_btn">
                        <div>
                            <a href="javascript:void(0);" id="moveQuestion3">멘토에게 질문하기<span class="ico_badge"><img src="${pageContext.request.contextPath}/apps/images/ico_question_badge.png" alt="5분 답변"></span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="popup_all">
            <div class="popup_alert_moji" style="z-index: 99999999">
            </div>
        </div>
    </jsp:body>
</t:noLayout>
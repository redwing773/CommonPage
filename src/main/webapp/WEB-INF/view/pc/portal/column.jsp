<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/pc" %>
<t:noLayout>
    <jsp:attribute name="script_file">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/api/code_api.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/api/consult_api.js?ver=20220"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/page/intro/mentalk.js?ver=2208027"></script>
        <%@ include file="/WEB-INF/view/tmpl/pc/intro/mentalkListTmpl.jsp" %>
        <script type="text/javascript">
            var mentalkNextPage = true;
            var sessionCallback = function() {
                if ( tms.isNotEmpty(common.userInfo.mentorYn) && common.userInfo.mentorYn == 'Y' ) {
                    $(".section_01").show();
                    var innerWidth = window.innerWidth;
                    if(innerWidth > 1024) {
                        $("#main_contents").addClass("mentorY");
                        $(".rwd_column > div").addClass("mentorY");
                        $(".rwd_column > section").addClass("mentorY");
                    }
                }
                else {
                	$(".section_02").show();
                    var innerWidth = window.innerWidth;
                    if(innerWidth > 1024) {
                        $("#main_contents").addClass("mentorY");
                        $(".rwd_column > div").addClass("mentorY");
                        $(".rwd_column > section").addClass("mentorY");
                    }
                }
            };
            var systemMode = properties.getSystemMode();
            var userAgent = window.navigator.userAgent.toLowerCase();

            var inApp = new Array('iphone','android');

            var inappCheck = false;
            for(var appWord in inApp){
                if(userAgent.match(inApp[appWord]) != null){
                    appcss();
                    inappCheck = true;
                    <%--if (appWord == 0 || appWord == 2 || appWord == 3) {--%>
                    <%--    $('.downloadApp').attr("src", "${pageContext.request.contextPath}/apps/images/ic_apple_badge.png");--%>
                    <%--    $('.downloadApp').attr("onclick", "goApp2()");--%>
                    <%--}else {--%>
                    <%--    $('.downloadApp').attr("src", "${pageContext.request.contextPath}/apps/images/ic_google_badge.png");--%>
                    <%--    $('.downloadApp').attr("onclick", "goGoogle2()");--%>
                    <%--}--%>
                    <%--$('.downloadApp').css("height", "28px");--%>
                    <%--$('.downloadApp').css("padding", "12px");--%>
                }
            }
            if(!inappCheck) {
                pccss();
            }

            if(userAgent.indexOf("mac") > -1){
                if(window.navigator.maxTouchPoints == 5){
                    <%--$('.downloadApp').attr("src", "${pageContext.request.contextPath}/apps/images/ic_apple_badge.png");--%>
                    <%--$('.downloadApp').attr("onclick", "goApp2()");--%>
                    goAppOneLink = "https://ilinker.onelink.me/xLdV/q0qpcq0u";
                }
            }

            function goGoogle2() {
                window.open("https://ilinker.onelink.me/xLdV/ywoid3u6");
            }
            function goApp2(){
                window.open("https://ilinker.onelink.me/xLdV/q0qpcq0u");
            }
            function goQr2(){
                openAlertPopupMojiQr();
            }

            function pccss(){
                var width = $(window).width();
                width = (width-400)/2+4.5;
                // $('.mojiboard').css({'width': '400px', 'margin': '0 auto'});
                $('#divList').css({'width': '400px', 'margin': '0 auto'});
                $('.awl_fixer_plus2').css({'right':width+'px'});
                // $('.board_menu_box').css('width', 'inherit');
                <%--$('.downloadApp').attr("src", "${pageContext.request.contextPath}/apps/images/ic_linker_badge2.png");--%>
                <%--$('.downloadApp').attr("onclick", "goQr2()");--%>
                <%--$('.downloadApp').css("height", "36px");--%>
                <%--$('.downloadApp').css("padding", "7px");--%>

                <%-- 화면 리사이즈될때 --%>
                $(window).resize(function() {
                    var width = $(window).width();
                    width = (width-400)/2+13;
                    $('.awl_fixer_plus2').css({'right':width+'px'});
                });
            }

            function appcss() {
                top.window.$('head').append('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">');
                // $('.mojiboard').css({'width': '100%', 'margin': ''});
                $('#divList').css({'width': '100%', 'margin': ''});
                $('.awl_fixer_plus2').css({'right':'16px'});
                // $('.board_menu_box').css('width', '100%');
                $(".btn_top_moji").css({"background": "url(" + contextPath +"/apps/images/ic_moji_top.png)", "background-size" : "contain"});
                <%-- 화면 리사이즈될때 --%>
                $(window).resize(function() {
                    $('.awl_fixer_plus2').css({'right':'16px'});
                });
            }

            let gnbParams = "";
            try {
                const briefingHide = {
                    "service" : ["eci"],
                    "detail-service" : [],
                    "branch-code" : []
                };
                const urlSearch = new URLSearchParams(location.search);
                const gnbService = urlSearch.getAll('gnbService')[0];
                const gnbDetailService = urlSearch.getAll('gnbDetailService')[0];
                const gnbBranch = urlSearch.getAll('gnbBranch')[0];

                let isHide = false;
                briefingLoop:
                    for(const bKey in briefingHide){
                        let target = "";

                        switch (bKey) {
                            case "service" :
                                target = gnbService;
                                break;
                            case "detail-service" :
                                target = gnbDetailService;
                                break;
                            case "branch-code" :
                                target = gnbBranch;
                                break;
                            default:
                                break;
                        }

                        for(let idx in briefingHide[bKey]){
                            if(target == briefingHide[bKey][idx]){
                                isHide = true;
                                break briefingLoop;
                            }
                        }
                    }

                if(isHide){
                    $("#btn_briefing").css('display', 'none');
                } else {
                    $("#btn_briefing").css('display', '');
                }

                gnbParams = location.search;
            }catch (e){
                console.error(e)
            }

            $(function() {
                $("body").css("overflow", "hidden");

                $("#ongoingList").empty();
                ongoingNo = 1;
                searchChannelPortal(ongoingNo, limit, "#ongoingList");

                $(document).on("click", ".rwd_dropdown.open", function(e) {
                    if($(e.target).hasClass("rwd_dropdown")){
                        Layer_CLOSE(".rwd_dropdown");
                    }
                });


                <%-- 탭메뉴 이동 --%>
                $('.board_menu_box a').click(function(event){
                    event.preventDefault();
                    var tabNo = $(this).data("tab");
                    if(tabNo == 1) {
                        location.href = contextPath + "/page/portal/talk/list" + gnbParams;
                    }else if(tabNo == 4){
                        location.href = contextPath + "/page/portal/briefing" + gnbParams;
                    }else if(tabNo == 0) {
                        location.href = contextPath + "/page/portal/talk/myTalk" + gnbParams;
                    }
                });

                <%-- 질문톡 고객센터(카카오톡)으로 이동 --%>
                $('.goKakaoQuestion').on("click", function(){
                    window.open("http://pf.kakao.com/_DDxdTxj/chat");
                });

                <%-- 상단으로 이동 --%>
                $('#moveTop').on("click",function(){
                    $('#divList').animate({scrollTop: '0'}, 1000);
                });
            });

            <%-- 멘토 칼럼 호출 --%>
            $(window).scroll(function() {
                if (mentalkNextPage && $(window).scrollTop() >= $(document).height() - $(window).height()) {
                    searchChannelPortal(ongoingNo, limit, "#ongoingList");
                    mentalkNextPage = false;
                }

                if ($(this).scrollTop() <= 0) {
                    $(".btn_top_moji").hide();
                }else{
                    $(".btn_top_moji").show();
                }
            });

            $("#divList").scroll(function(){
                if (mentalkNextPage && $(this).scrollTop() + $(this).height() >= $(this).prop('scrollHeight') - 300) {
                    searchChannelPortal(ongoingNo, limit, "#ongoingList");
                    mentalkNextPage = false;
                }

                if ($(this).scrollTop() <= 0) {
                    $(".btn_top_moji").hide();
                }else{
                    $(".btn_top_moji").show();
                }
            });

            var searchChannelPortal = function(page, limit, obj) {
                var params = {
                    page:page
                    , limit:limit
                    // , mentalkCategoryNoList: [23]
                    , type: 1
                };

                //consultApi.searchOpentalkPortal(params, function(res) {
                consultApi.searchOpentalk(params, function(res) {
                    var code = res.resultCode;
                    var data = res.result.mentalkColumnList;

                    if (code === 0) {
                        if(data != null && data.length > 0) {
                            //var comingTrueList = new Array();
                            //var comingFalseList= new Array();
                            // data.forEach(function (obj) {
                            //     obj.replyCnt = 0;
                            //     if(moment(obj.startDate).isAfter(moment().format('YYYY-MM-DD HH:mm:ss'))) {
                            //         obj.startDate = moment(obj.startDate).format('MM.DD').toString();
                            //         comingTrueList.push(obj);
                            //     }else {
                            //         comingFalseList.push(obj);
                            //     }
                            // });

                            //$("#mentalkComingListTmpl").tmpl(comingTrueList).appendTo(obj);
                            //$("#mentalkListTmpl2").tmpl(comingFalseList).appendTo(obj);

                            data.forEach(function (obj) {
                                obj.replyCnt = 0;
                            });
                            $("#mentalkListTmpl2").tmpl(data).appendTo(obj);

                            mentalkNextPage = true;
                            ongoingNo++;

                            // 멘토칼럼 상세
                            $(obj).find(".mentalkList").not(".comingsoon").unbind().bind("click", function(){
                                var talkNo = $(this).data("no");
                                getMentalkDetailPortal(talkNo);
                            });

                            var lst_height = $("#ongoingList").height() + 180;
                            $(".slider_list > div.slick-list").css("height", lst_height + "px");

                        } else {
                            mentalkNextPage = false;
                            if(page == 1) {
                                $("#searchNoDataTmpl").tmpl().appendTo(obj);
                            }
                        }
                    } else {
                        mentalkNextPage = false;
                        if(page == 1) {
                            $("#searchNoDataTmpl").tmpl().appendTo(obj);
                        }
                    }
                });
            }

            // 칼럼 상세 보기
            var getMentalkDetailPortal = function(talkNo) {
                location.href = contextPath + "/page/portal/detail/"+talkNo+ gnbParams;
            }
            var openAlertPopupMojiQr = function(){
                Layer_OPEN(".popup_alert_moji_qr");
            };
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="mojiboard">
            <div class="board_menu_box" style="padding: 0;width: 100%; position: fixed; top: 0; left: 0;background-color: #fff; border-bottom: 1px solid #F1F1F1;z-index: 999">
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
                    </div>
                    <div class="awl_header_r">

                    </div>
                </div>
                <div class="awl_header_b" style="max-width: 384px;margin: 0 auto; padding-left: 16px;">
                    <a href="javascript:void(0);" id="btn_talk" class="moji_tab" data-tab="1">질문톡</a>
                    <a href="javascript:void(0);" id="btn_column" class="moji_tab on" data-tab="3">멘토칼럼</a>
                    <a href="javascript:void(0);" id="btn_briefing" class="moji_tab" data-tab="4" style="display: none">
                        <img src="${pageContext.request.contextPath}/pc/images/briefing_icon.png" style="width: 14px; vertical-align: text-top;margin-top: 1px;"> 설명회
                    </a>
                    <a href="javascript:void(0);" id="btn_mytalk" class="moji_tab" data-tab="0">내글</a>
                </div>
            </div>
            <div style="display: flex; justify-content: center; background-color: #F7F9FF; height: 100vh; width: 100%;">
                <div id="divList" style="position:absolute;top:100px;height:calc(100vh - 100px); overflow:auto;">
                    <div id="rwd_contents" class="portal" style="max-width: 400px; margin: 0 auto; z-index: 100;margin-top: 16px;">
                        <div class="inner_box">
                            <div class="rwd_column portal">
                                <section class="column_section">
                                    <div class="list" style="margin-top: 16px;">
                                        <ul id="ongoingList" style="min-height: 190px;">
                                        </ul>
                                    </div>
                                </section>
                            </div>
                        </div>
                        <button type="button" class="btn_close" onclick="detailPopupClose()"/><span class="blind">닫기</span></button>
                    </div>
                    <div class="awl_fixer_plus2 on" style="bottom: 79px;">
                        <a href="javascript:void(0);" id="moveTop" class="btn_top_moji" style="display: none;"><span class="blind">TOP</span></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="popup_all">
            <div class="popup_alert_moji_qr">
                <div class="outter_box">
                    <div class="inner_box" style=" width: 320px;  height: 383px; padding: 20px 25px 20px 25px;  text-align: center; border-radius: 6px;">
                        <h2 class="title" style="font-size: 16px; line-height: 22px; color: #000; font-weight: 600; letter-spacing: -0.5px;">QR코드로 다운로드하기</h2>
                        <img src="${pageContext.request.contextPath}/pc/images/portal_linker_qr.svg" style="width: 238px; bottom: 80px; position: absolute; left: 45px;">
                        <div class="btn_box" style=" width: 100%; position: absolute; left: 0px; bottom: 0px;">
                            <a href="javascript:void(0);" class="btn_40" style="width:100%; background: #302cc8; line-height: 60px; height: 60px; font-size: 16px;" onclick="Layer_CLOSE('.popup_alert_moji_qr')">확인</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:noLayout>
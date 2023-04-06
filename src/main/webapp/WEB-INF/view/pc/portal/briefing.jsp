<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/pc" %>
<t:noLayout>
    <jsp:attribute name="script_file">
    <script type="text/javascript">
        let presentationCls = {};
        let iframeSrc = properties.getPortalHost();
        let gnbParams = "";

        try {
            const urlSearch = new URLSearchParams(location.search);
            const gnbService = urlSearch.getAll('gnbService').length > 0 ? urlSearch.getAll('gnbService')[0] : "";
            const gnbDetailService = urlSearch.getAll('gnbDetailService').length > 0 ? urlSearch.getAll('gnbDetailService')[0] : "";
            const gnbBranch = urlSearch.getAll('gnbBranch').length > 0 ? urlSearch.getAll('gnbBranch')[0] : "";

            iframeSrc = iframeSrc + "/piece-portal/presentation?gnbService=" + gnbService + "&gnbDetailService=" + gnbDetailService + "&gnbBranch=" + gnbBranch;
            gnbParams = location.search;
        }catch (e){
            console.error(e)
        }

        function setScreenSize() {
            let vh = window.innerHeight - 100;
            $(".if-briefing").css('height', vh + "px");
        }
        setScreenSize();
        window.addEventListener('resize', setScreenSize);

        $(function(){
            $("body").css("background-color", "#F7F9FF");
            $("body").css("height", "auto");
            $("body").css("overflow", "hidden");
            $(".awl_header_c").css("display", "none");

            presentationCls.init();

            $('.awl_header_b > a').on('click', function(e){
                e.preventDefault();
                const tabNo = $(this).data("tab");
                switch (tabNo) {
                    case 1: location.href = contextPath + "/page/portal/talk/list" + gnbParams; break;
                    case 3: location.href = contextPath + "/page/portal/column" + gnbParams; break;
                    case 0: location.href = contextPath + "/page/portal/talk/myTalk" + gnbParams; break;
                }
            });
        });

        presentationCls = {
            init: function(){
                const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
                // let css = {'width': '400px', 'margin': '0 auto'};
                let css = {'width': '100%', 'margin': ''};
                if(isMobile) {
                    top.window.$('head').append('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">');
                }

                $('.mojiboard').css(css);
                $('#ifPresentation').attr('src', iframeSrc);
            }
        }
    </script>
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
                    </div>
                    <div class="awl_header_r">
                    </div>
                </div>
                <div class="awl_header_b" style="max-width: 384px;margin: 0 auto;padding-left: 16px;">
                    <a href="javascript:void(0);" class="moji_tab" data-tab="1">질문톡</a>
                    <a href="javascript:void(0);" class="moji_tab" data-tab="3">멘토칼럼</a>
                    <a href="javascript:void(0);" class="moji_tab on" data-tab="4">
                        <img src="${pageContext.request.contextPath}/pc/images/briefing_icon.png" style="width: 14px; vertical-align: text-top;margin-top: 1px;"> 설명회
                    </a>
                    <a href="javascript:void(0);" id="btn_mytalk" class="moji_tab" data-tab="0">내글</a>
                </div>
            </div>

            <iframe id="ifPresentation" class="if-briefing" style="width:100%;"></iframe>
        </div>

    </jsp:body>
</t:noLayout>

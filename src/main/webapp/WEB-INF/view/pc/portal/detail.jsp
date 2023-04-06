<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/pc" %>
<t:noLayout>
    <jsp:attribute name="script_file">
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/api/code_api.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/api/consult_api.js?ver=20220"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/page/intro/mentalk.js?ver=2208027"></script>
        <%@ include file="/WEB-INF/view/tmpl/pc/intro/mentalkListTmpl.jsp" %>
        <script type="text/javascript">
            $(function() {
                <%-- 조회수 증가--%>
                addViewCnt(${talkNo});

                consultApi.getMentalkDetail({talkNo:${talkNo}}, function(code, data, res){
                    if(code === 0){
                        var list = data[0];

                        $("#mentalkDetailPopupTmpl").tmpl(list).appendTo(".rwd_column_detail .cont");

                        $(".propose").on("click", function(){
                            Layer_OPEN(".popup_app");
                        });
                    }
                });
            });

            <%-- 조회수 증가 --%>
            var addViewCnt = function(talkNo) {
                $.ajax({
                    type : 'GET',
                    url : tms.portalProxyUrl(contextPath + '/app/column/add/' + talkNo) + "?" + $.param({'talkNo' : talkNo}),
                    success : function(){
                        console.log('success');
                    },error: function(){
                        console.log('fail');
                    }
                });
            };
        </script>
    </jsp:attribute>
    <jsp:body>
        <div id="rwd_contents" class="portal" style="max-width: 400px; margin: 0 auto; z-index: 100;">
            <div class="inner_box">
                <div class="rwd_column portal">
                    <div style="width: 100%; height: 54px;position: fixed; left: 0; background: #fff; top: 0;z-index: 100;">
                        <div class="title" style="display: grid; grid-template-columns: 56px 1fr 56px; grid-template-areas: 'a b c';">
                            <div class="fl_l" onclick="javascript:history.go(-1);"></div>
                            <div class="fl_c">대학생 멘토칼럼</div>
                        </div>
                    </div>
                    <div class="rwd_column_detail">
                        <div class="cont"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="popup_all">
            <div class="popup_app">
                <div class="outter_box">
                    <div class="inner_box">

                        <h2 class="title"><strong>멘토</strong>에게 문의하고 싶으세요?<br/>
                            더욱 편리한 <strong>Linker앱</strong>을 통해 문의해보세요.</h2>
                        <div class="btn_box">
                            <a href="https://ilinker.onelink.me/xLdV/ywoid3u6" target="_blank" class="btn_google"><span>Google Play</span></a>
                            <a href="https://ilinker.onelink.me/xLdV/q0qpcq0u" target="_blank" class="btn_app"><span>App Store</span></a>
                        </div>
                        <div class="both_area">
                            <div class="fl_r">
                                <button type="button" class="btn_close" onclick="Layer_CLOSE('.popup_app')">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:noLayout>
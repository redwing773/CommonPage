<%@ tag pageEncoding="UTF-8" %>
<%@attribute name="script_file" fragment="true" required="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:eval expression="@environment.getProperty('spring.config.activate.on-profile')" var="activeProfile" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/tags/pc/head.tag" %>
</head>
<body>
<c:if test="${activeProfile eq 'dev'}">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-TPZXZ6K"
                  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
</c:if>

<c:if test="${activeProfile eq 'qa'}">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-WDGZTMV"
                  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-P9PPVM9"
                      height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->
</c:if>

<c:if test="${activeProfile eq 'live'}">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-K85LNHK"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5FGHQ98"
                  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
</c:if>

    <div id="rwd_wrap">
        <%@ include file="/WEB-INF/tags/pc/inc/header.tag" %>
        <div id="rwd_container">
            <jsp:doBody/>
        </div>
        <%@ include file="/WEB-INF/tags/pc/inc/footer.tag" %>
        <%@ include file="/WEB-INF/tags/pc/script.tag" %>
        <%@ include file="/WEB-INF/view/tmpl/pc/commonTmpl.tag" %>

    <div class="rwd_popup_phone">
        <div class="outter_box">
            <div class="inner_box">
                <div class="in_box">
                    <!-- <div class="title">
                        <p class="name"></p>
                        <span class="label">질문</span>
                    </div> -->
                    <div class="cont">
                    </div>
                </div>
            </div>
            <button type="button" class="btn_close" onclick="Layer_CLOSE('.rwd_popup_phone')"/><span class="blind">닫기</span></button>
        </div>
    </div>

    <div class="rwd_popup_mentoring">
        <div class="outter_box">
            <div class="inner_box">
                <div class="in_box">
                    <div class="top_box">
                        <%--<div class="app_link">
                            <a href="#self" class="btn_google" onclick="goGoogle()"><span class="blind">Google Play</span></a>
                            <a href="#self" class="btn_app" onclick="goApp()"><span class="blind">App Store</span></a>
                        </div>--%>
                        <div class="profile_area">
                        </div>
                        <div class="btn_tab">
                            <button class="on" data-value="contentsYn">생기부</button>
                            <button data-value="selfReportYn">자소서</button>
                            <button data-value="mentoring">멘토링</button>
                            <button data-value="lesson">과외</button>
                        </div>
                    </div>
                    <div class="tab_cont">
                        <div class="cont_01 conts profile_record on">
                            <div class="table_box">
                                <div class="buy_box" data-cd="COURSE_1">
                                    <span><strong>학년별 <span class="introPrice"></span>P</strong> (<strong><span class="introExpDay"></span>일간</strong> 열람)</span>
                                </div>
                                <div class="buy_box2">
                                    <a href="#self" class="btn_buy2" data-cd="COURSE_1">1학년 <em class="isPayment">구입</em></a>
                                    <a href="#self" class="btn_buy2" data-cd="COURSE_2">2학년 <em class="isPayment">구입</em></a>
                                    <a href="#self" class="btn_buy2" data-cd="COURSE_3">3학년 <em class="isPayment">구입</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="COURSE_1">
                                    <img src="${pageContext.request.contextPath}/pc/images/record01.png">
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="EXP_1">
                                    <span><strong>학년별 <span class="introPrice"></span>P</strong> (<strong><span class="introExpDay"></span>일간</strong> 열람)</span>
                                </div>
                                <div class="buy_box2">
                                    <a href="#self" class="btn_buy2" data-cd="EXP_1">1학년 <em class="isPayment">구입</em></a>
                                    <a href="#self" class="btn_buy2" data-cd="EXP_2">2학년 <em class="isPayment">구입</em></a>
                                    <a href="#self" class="btn_buy2" data-cd="EXP_3">3학년 <em class="isPayment">구입</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="EXP_1">
                                    <img src="${pageContext.request.contextPath}/pc/images/record02.png">
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="COMP_1">
                                    <span><strong>학년별 <span class="introPrice"></span>P</strong> (<strong><span class="introExpDay"></span>일간</strong> 열람)</span>
                                </div>
                                <div class="buy_box2">
                                    <a href="#self" class="btn_buy2" data-cd="COMP_1">1학년 <em class="isPayment">구입</em></a>
                                    <a href="#self" class="btn_buy2" data-cd="COMP_2">2학년 <em class="isPayment">구입</em></a>
                                    <a href="#self" class="btn_buy2" data-cd="COMP_3">3학년 <em class="isPayment">구입</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="COMP_1">
                                    <img src="${pageContext.request.contextPath}/pc/images/record03.png">
                                </div>
                            </div>
                            <div class="txt_box srsampling_sampling_Y" style="display: none;">
                                <div class="txt">
                                    <p class="txt_01">* 멘토가 무료열람 보기를 승인하였습니다.</p>
                                    <p class="txt_02">- 아래 생기부 항목 중 1개를 무료열람 가능 합니다.</p>
                                </div>
                            </div>
                            <div class="txt_box srsampling_sampling_N" style="display: none;">
                                <div class="txt free_open">
                                    <p class="txt_01">* 무료 열람 보기를 완료한 멘토입니다.</p>
                                    <p class="txt_02">- 무료 열람 보기는 <span class="sampling_period"></span>일간만 가능합니다.</p>
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="AWARDS">
                                    <span><strong><span class="introPrice"></span>P</strong> 구입 시 <strong><span class="introExpDay"></span>일간</strong> 열람 가능</span>
                                    <a href="#self" class="btn_buy" data-cd="AWARDS"><img class="mat" src="${pageContext.request.contextPath}/pc/images/ic_mat.png" alt="" style="display: none;"><em class="itemNm">수상경력</em> <em class="isPayment">구입하기</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="AWARDS">
                                    <img src="${pageContext.request.contextPath}/pc/images/record_award.png">
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="CAREER">
                                    <span><strong><span class="introPrice"></span>P</strong> 구입 시 <strong><span class="introExpDay"></span>일간</strong> 열람 가능</span>
                                    <a href="#self" class="btn_buy" data-cd="CAREER"><img class="mat" src="${pageContext.request.contextPath}/pc/images/ic_mat.png" alt="" style="display: none;"><em class="itemNm">진로희망</em> <em class="isPayment">구입하기</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="CAREER">
                                    <img src="${pageContext.request.contextPath}/pc/images/record_career.png">
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="SERVICE">
                                    <span><strong><span class="introPrice"></span>P</strong> 구입 시 <strong><span class="introExpDay"></span>일간</strong> 열람 가능</span>
                                    <a href="#self" class="btn_buy" data-cd="SERVICE"><img class="mat" src="${pageContext.request.contextPath}/pc/images/ic_mat.png" alt="" style="display: none;"><em class="itemNm">봉사활동</em> <em class="isPayment">구입하기</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="SERVICE">
                                    <img src="${pageContext.request.contextPath}/pc/images/record_volunteer.png">
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="READING">
                                    <span><strong><span class="introPrice"></span>P</strong> 구입 시 <strong><span class="introExpDay"></span>일간</strong> 열람 가능</span>
                                    <a href="#self" class="btn_buy" data-cd="READING"><img class="mat" src="${pageContext.request.contextPath}/pc/images/ic_mat.png" alt="" style="display: none;"><em class="itemNm">독서활동</em> <em class="isPayment">구입하기</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="READING">
                                    <img src="${pageContext.request.contextPath}/pc/images/record_reading.png">
                                </div>
                            </div>
                        </div>
                        <div class="cont_04 conts profile_selfintro">
                            <div class="table_box">
                                <div class="intro_box">
                                    <div class="intro on"></div>
                                    <div class="intro"></div>
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="SELF_REPORT1">
                                    <span><strong><span class="introPrice"></span>P</strong> (<strong><span class="introExpDay"></span>일간</strong> 열람)</span>
                                    <a href="#self" class="btn_buy" data-cd="SELF_REPORT1"><em class="itemNm">1번 항목</em> <em class="isPayment">구입하기</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="SELF_REPORT1">
                                    <img src="${pageContext.request.contextPath}/pc/images/intro01.png">
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="SELF_REPORT2">
                                    <span><strong><span class="introPrice"></span>P</strong> (<strong><span class="introExpDay"></span>일간</strong> 열람)</span>
                                    <a href="#self" class="btn_buy" data-cd="SELF_REPORT2"><em class="itemNm">2번 항목</em> <em class="isPayment">구입하기</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="SELF_REPORT2">
                                    <img src="${pageContext.request.contextPath}/pc/images/intro02.png">
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="SELF_REPORT3">
                                    <span><strong><span class="introPrice"></span>P</strong> (<strong><span class="introExpDay"></span>일간</strong> 열람)</span>
                                    <a href="#self" class="btn_buy" data-cd="SELF_REPORT3"><em class="itemNm">3번 항목</em> <em class="isPayment">구입하기</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="SELF_REPORT3">
                                    <img src="${pageContext.request.contextPath}/pc/images/intro03.png">
                                </div>
                            </div>
                            <div class="table_box">
                                <div class="buy_box" data-cd="SELF_REPORT4">
                                    <span><strong><span class="introPrice"></span>P</strong> (<strong><span class="introExpDay"></span>일간</strong> 열람)</span>
                                    <a href="#self" class="btn_buy" data-cd="SELF_REPORT4"><em class="itemNm">4번 항목</em> <em class="isPayment">구입하기</em></a>
                                </div>
                                <div class="buy_box3" style="text-align: center;" data-cd="SELF_REPORT4">
                                    <img src="${pageContext.request.contextPath}/pc/images/intro04.png">
                                </div>
                            </div>
                        </div>
                        <div class="cont_02 conts">
                            <ul class="list">
                            </ul>
                        </div>
                        <div class="cont_03 conts">
                        </div>
                    </div>
                    <div class="btn_box">
                        <ul>
                            <li><a href="#self" onclick="Layer_OPEN('.popup_app');">멘토링 사전 문의</a></li>
                            <li><a href="#self" onclick="Layer_OPEN('.popup_app');">과외 무료 상담</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <button type="button" class="btn_close" onclick="Layer_CLOSE('.rwd_popup_mentoring')"><span class="blind">닫기</span></button>
        </div>
    </div>

    <div id="alertPopup" class="popup_all"></div>

    <%-- 앱 다운로드 팝업 start --%>
    <div class="popup_all">
        <div class="popup_app">
            <div class="outter_box">
                <div class="inner_box">
                    <h2 class="title">모바일 앱에서 <strong>Linker</strong>의 서비스를 <br/>
                        더욱 편리하게 이용하실 수 있어요!</h2>
                    <div class="btn_box">
                        <a href="#self" class="btn_google" onclick="goGoogle()"><span>Google Play</span></a>
                        <a href="#self" class="btn_app" onclick="goApp()"><span>App Store</span></a>
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
    <%-- 앱 다운로드 팝업 end --%>

    <div class="popup_all">
        <div class="popup_type pass_type">
            <div class="outter_box">
                <div class="inner_box">
                    <h2 class="title">합격유형 선택</h2>
                    <div class="in_box choice_area">
                        <label class="select_radiobox style_01 mb10"><input type="radio" name="passType" value="" checked="checked"/><em></em><span>합격유형 전체</span></label>
                        <label class="select_radiobox style_01 mb10"><input type="radio" name="passType" value="susi"/><em></em><span>수시 합격</span></label>
                        <label class="select_radiobox style_01 mb10"><input type="radio" name="passType" value="jeongsi"/><em></em><span>정시 합격</span></label>
                    </div>
                    <div class="btn_box">
                        <a href="#self" class="btn_40 gray btn_cancel" style="width:92px;">취소</a>
                        <a href="#self" class="btn_40 btn_pass_type" style="width:216px;">적용하기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="rwd_popup_search">
        <div class="outter_box">
            <div class="inner_box">
                <div class="in_box">
                    <div class="top_box">
                        <div class="title" id="searchTitle"></div>
                        <div class="btn_tab">
                            <a href="#self" class="detail on">상세조건</a>
                            <a href="#self" class="nickname">닉네임 검색</a>
                        </div>
                    </div>
                    <div class="tab_cont">
                        <!-- 상세 조건 -->
                        <div class="cont_01 on">
                            <div>

                            </div>
                        </div>

                        <!-- 닉네임 검색 -->
                        <div class="cont_02">
                            <div class="table_box">
                                <div class="condition_content">
                                    <input type="text" class="search_box" name="nickNm" placeholder="찾고자 하는 멘토를 검색해보세요!">
                                    <a href="#self" class="search_btn"></a>
                                </div>
                                <div class="condition_mentoList">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="btn_box search_btn_box">
                        <ul>
                            <li><a href="#self" id="search_clean">전체 초기화</a></li>
                            <li><a href="#self" id="search_ok" class="blue">적용하기</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <button type="button" class="btn_close" onclick="Layer_CLOSE('.rwd_popup_search')"><span class="blind">닫기</span></button>
        </div>
    </div>
</div>

<jsp:invoke fragment="script_file"/>

</body>
</html>

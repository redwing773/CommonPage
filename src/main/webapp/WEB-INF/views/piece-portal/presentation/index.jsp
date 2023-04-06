<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="webpack" uri="/WEB-INF/tlds/webpack.tld" %>
<head>
    <title>설명회</title>
</head>
<body>
<div id="presentation_div">
    <section class="visual-swiper-box banner-section" id="banner_section">
    </section>

    <section class="explain-area">
        <div class="explain-option-box">
            <div class="switch-box">
                <div class="title">요약 보기</div>
                <label class="switch">
                    <input type="checkbox" id="summary_view_switch">
                    <span class="slider"></span>
                </label>
            </div>
            <div class="filter-box" id="filter_box">
                <a href="#" class="filter-select" id="filter_title">전체 학원 보기</a>
                <div class="filter-options">
                    <div class="option-head">
                        <a href="#" class="btn-all" id="view_all_academy">전체 학원 보기</a>
                        <a href="#" class="btn-close">닫기</a>
                    </div>
                    <div class="option-body">
                        <ul class="filter-list" id="academy_ul">
                        </ul>
                    </div>
                    <div class="option-foot">
                        <a href="#" class="btn-select" id="select_complete">선택 완료</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="explain-none-box explain-list-wrap" id="empty_search_presentation">
            <div class="explain-none">
                <img src="/resources/images/portalTok/icon_emoji1.png" alt="" class="emoji"/>
                <p class="desc">검색하신 조건에 맞는 설명회가 없습니다.</p>
                <a href="#" class="more-btn">더 다양한 설명회 보기</a>
            </div>
        </div>

        <div class="explain-none-box explain-list-wrap" id="empty_presentation">
            <div class="explain-none">
                <img src="/resources/images/portalTok/icon_emoji2.png" alt="" class="emoji"/>
                <p class="title">현재 진행중인 설명회가 없습니다.</p>
                <p class="desc">더욱 다양한 입시 콘텐츠로 찾아 뵙겠습니다.</p>
            </div>
        </div>

        <div class="explain-list-box explain-list-wrap" id="not_empty_presentation">
            <ul class="explain-list" id="presentation_ul">
            </ul>
        </div>

        <div class="awl_fixer_plus2">
            <a href="#" id="moveTop" class="btn_top_moji"><span class="blind">TOP</span></a>
        </div>
    </section>
</div>
<jsp:include page="template.jsp"/>
<script type="module"
        src="${webpack:getManifestResource('js/piece-portal/presentation/index.js')}"></script>
<input type="hidden" id="branch_code" value="${gnbBranch}">
<input type="hidden" id="service_code" value="${gnbDetailService}">
</body>
</html>
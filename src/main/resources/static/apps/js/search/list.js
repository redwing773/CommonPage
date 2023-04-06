var userHipId = hipId;
var userToken = authorization;
var userMentorYn = "";
if(typeof mentorYn != "undefined"){
    userMentorYn = mentorYn;
}
if(tms.isEmpty(userMentorYn)){
    userMentorYn = tms.getCookie("mentoryn");
}
if(tms.isEmpty(userMentorYn)){
    userMentorYn = "N";
}

//매니저 계정 처리를 위한 변수
var systemMode = properties.getSystemMode();
var managerHipId = "";
var managerSupportHipId = "";
var expertMentor = "";
if(systemMode == "live") {
    managerHipId = properties.managerLiveHipId;
    managerSupportHipId = properties.managerSupportLiveHipId;
    expertMentor= properties.expertMentorLiveHipId;
}else if(systemMode == "stage"){
    // stage 변경 필요
    managerHipId = properties.managerLiveHipId;
    managerSupportHipId = properties.managerSupportLiveHipId
    expertMentor= properties.expertMentorLiveHipId;
} else {
    managerHipId = properties.managerDevHipId;
    managerSupportHipId = properties.managerSupportDevHipId;
    expertMentor= properties.expertMentorDevHipId;
}

var isBlockPofile = "";

// 스크롤 처리 변수
var currentPaging = 1;
var chkPage = 1;
var limit = 15;
var endPage = false;

var consultType = 5;
var winScroll = null;
var spellCheck = 0;

var compareVer = "1.2.5";
var currentVer = appVersion;
var compareIOSver = "1.2.6";
var searchTab = "";

$(function() {
    $(".search_area .btn_del").on("click", function() {
        $("#searchKeyword").val("");
        $(".search_area .datalist").empty();

        if($(location).attr('pathname').indexOf("page/portal/") != -1) {
            $(".search_area .btn_del").hide();
        }
    });

    $("#searchKeyword").on("keyup", function() {
        var word = $(this).val();
        if($(location).attr('pathname').indexOf("page/portal/") != -1) {
            if (word.length > 0) {
                $(".datalist").show();
                $(".search_area .btn_del").show();
            } else {
                $(".search_area .btn_del").hide();
            }
        }
        getAutoComplete(word);
    });
    $(document).on("click", "html:not('.datalist, #searchKeyword')", function() {
        if($(location).attr('pathname').indexOf("page/portal/") != -1) {
            if(!$("#searchKeyword").is(":focus")){
                $(".datalist").hide();
            }
        }
    });
    $("#searchKeyword").on("focus", function() {
        if($(location).attr('pathname').indexOf("page/portal/") != -1) {
            $(".datalist").show();
        }
    });

    // $("html").not( '.datalist' ).on("click", function(){
    //     alert("!213");
    // });
});

// 검색 결과 탭 클릭시
function integrationSearch(param) {

    var keyword = $("#searchKeyword").val();
    keyword = escape(encodeURIComponent(keyword));

    var searchUrl = "";
    if($(location).attr('pathname').indexOf("page/portal/search") != -1) {
        if(param == "A") {
            searchUrl = contextPath + "/page/portal/search/all?keyword=" + keyword;
        } else if(param == "Q") {
            var gnbParams = location.search;
            if(gnbParams.indexOf("keyword") != -1) {
                gnbParams = "&" + gnbParams.substr(gnbParams.indexOf("gnbService"));
            }
            searchUrl = contextPath + "/page/portal/search/question?keyword=" + keyword + gnbParams;
        } else if(param == "R") {
            searchUrl = contextPath +"/page/portal/search/talkReply?keyword=" + keyword;
        }
    }else {
        if(param == "A") {
            searchUrl = contextPath + "/app/search/all?keyword=" + keyword;
        } else if(param == "Q") {
            searchUrl = contextPath + "/app/search/question?keyword=" + keyword;
        } else if(param == "P") {
            searchUrl = contextPath +"/app/search/poll?keyword=" + keyword;
        } else if(param == "F") {
            searchUrl = contextPath +"/app/search/free?keyword=" + keyword;
        } else if(param == "R") {
            searchUrl = contextPath +"/app/search/talkReply?keyword=" + keyword;
        }
    }

    location.href = searchUrl;
}

// 인기 검색어 키워드 클릭 시
function recommendWordClick(keyword) {
    $("#searchKeyword").val(keyword);
    $(".search_area .datalist").empty();
    integrationSearch(searchTab);
}

//질문톡 검색
var setTalkQuestionSearchList = function(talkList, no, obj, from) {
    if(talkList != null && talkList.length > 0){
        //목록 설정
        chkPage = currentPaging;

        var list = talkList.map(function(obj){
            if(obj.partyNm != null){
                obj.partyNm = obj.partyNm.substring(0,5);
            }
            if(obj.acceptanceLine != null){
                obj.acceptanceLine = obj.acceptanceLine.substring(0,2);
            }
            obj.adoptPoint = obj.adoptPoint;
            if(obj.categoryNm == "멘토링톡"){
                obj.categoryNm = "질문자와 멘토만 볼 수 있는 " + obj.categoryNm;
            }
            return obj;
        });

        for(var i=0; i<list.length; i++){
            list[i]["userMentorYn"] = userMentorYn;
            list[i]["userHipId"] = userHipId;
            list[i]["managerHipId"] = managerHipId;
            list[i]["summaryContent"] = list[i].talkContent;
            list[i]["paidReplyCnt"] = list[i].paidReplyCnt;
            list[i]["resourceUri"] = list[i].resourceUri == null ? "" : list[i].resourceUri;
            list[i]["from"] = from;

            //검색어 하이라이트
            var highlightList = list[i].highlightList;
            list[i].talkContent = setTextHighlight(highlightList, list[i].talkContent);
            //검색 클릭 랭크
            list[i]["rankNo"] = (currentPaging - 1) * limit + (i + 1);
        }

        $("#talkQuestionSearchListTmpl").tmpl(list).appendTo(obj);

        currentPaging++;
        // 토큰 값 없을 경우 처리
        if(tms.isEmpty(userToken)){
            $("#moveWrite").css("display","none");
            $(".swl_comment_input").css("display","none");
        }

        blockList('opentalk');
    }else{
        if(no == 1){
            //var noData = [{msgData : '조회된 결과가 없습니다.'}];
            //$("#noDataTmpl").tmpl(noData).appendTo(obj);

            $("#talkNoDataRecommendTmpl").tmpl().appendTo(obj);
        }
        endPage = true;
        return;
    }
}

//자유톡 검색
var setTalkFreeSearchList = function(talkList, no, obj, from) {
    if(talkList != null && talkList.length > 0){
        chkPage = currentPaging;

        var list = talkList.map(function(obj){
            if(obj.partyNm != null){
                obj.partyNm = obj.partyNm.substring(0,5);
            }
            if(obj.acceptanceLine != null){
                obj.acceptanceLine = obj.acceptanceLine.substring(0,2);
            }
            return obj;
        });

        for(var i=0; i<list.length; i++){
            list[i]["userMentorYn"] = userMentorYn;
            list[i]["userHipId"] = userHipId;
            list[i]["managerHipId"] = managerHipId;
            list[i]["from"] = from;

            //검색어 하이라이트
            var highlightList = list[i].highlightList;
            list[i].talkContent = setTextHighlight(highlightList, list[i].talkContent);
            //검색 클릭 랭크
            list[i]["rankNo"] = (currentPaging - 1) * limit + (i + 1);
        }

        $("#talkFreeSearchListTmpl").tmpl(list).appendTo(obj);

        currentPaging++;
        blockList('question');
    }else{
        if(no == 1){
            //var noData = [{msgData : '조회된 결과가 없습니다.'}];
            //$("#noDataTmpl").tmpl(noData).appendTo(obj);

            $("#talkNoDataRecommendTmpl").tmpl().appendTo(obj);
        }
        endPage = true;
        return;
    }
}

//투표톡 검색
var setTalkPollSearchList = function(talkList, no, obj, from) {
    if(talkList != null && talkList.length > 0){
        chkPage = currentPaging;

        var list = talkList.map(function(obj){
            obj.joinReward = "+" + obj.joinReward;
            obj.startDate = common.dateUnixFormat(obj.startDate, 'YY.MM.DD');
            obj.endDate = common.dateUnixFormat(obj.endDate, 'YY.MM.DD');
            return obj;
        });

        for(var i=0; i<list.length; i++){
            list[i]["mentorYn"] = userMentorYn;
            list[i]["from"] = from;

            //검색어 하이라이트
            var highlightList = list[i].highlightList;
            list[i].contents = setTextHighlight(highlightList, list[i].contents);
            //검색 클릭 랭크
            list[i]["rankNo"] = (currentPaging - 1) * limit + (i + 1);
        }

        $("#talkPollSearchListTmpl").tmpl(list).appendTo(obj);
        currentPaging++;

    } else {
        if(no == 1){
            //var noData = [{msgData : '조회된 결과가 없습니다.'}];
            //$("#noDataTmpl").tmpl(noData).appendTo(obj);

            $("#talkNoDataRecommendTmpl").tmpl().appendTo(obj);
        }
        endPage = true;
        return;
    }
}

//댓글 검색
var setTalkReplySearchList = function(replyList, no, obj, from) {
    if(replyList != null && replyList.length > 0){
        chkPage = currentPaging;

        replyList = replyList.map(function(obj){
            if(obj.partyNm != null){
                obj.partyNm = obj.partyNm.substring(0,5);
            }
            if(obj.acceptanceLine != null && obj.acceptanceLine != ""){
                obj.acceptanceLine = obj.acceptanceLine.substring(0,2);
            }
            return obj;
        });

        for(var i=0; i<replyList.length; i++){
            replyList[i]["userMentorYn"] = userMentorYn;
            replyList[i]["userHipId"] = userHipId;
            replyList[i]["managerHipId"] = managerHipId;
            replyList[i]["from"] = from;

            //검색어 하이라이트
            var highlightList = replyList[i].highlightList;
            replyList[i].replyContent = setTextHighlight(highlightList, replyList[i].replyContent);
            //검색 클릭 랭크
            replyList[i]["rankNo"] = (currentPaging - 1) * limit + (i + 1);
        }

        $("#replyTalkSearchListTmpl").tmpl(replyList).appendTo(obj);

        currentPaging++;
        blockList('opentalk');

    } else {
        if(spellCheck == 1) {
            if(no == 1){
                //var noData = [{msgData : '조회된 결과가 없습니다.'}];
                //$("#noDataTmpl").tmpl(noData).appendTo(obj);

                $("#talkNoDataRecommendTmpl").tmpl().appendTo(obj);
            }
            endPage = true;
            spellCheck = 0;
            return;
        }
    }
}

var setTalkSpellCheck = function(type, obj) {
    var param = {
        keyword: keywordParam
    };

    tms.ajaxGetHelper(contextPath + "/api/search/spellCheck", param, null, function(res){
        var code = res.code;
        if(code === 0){
            var spellCheck = res.data.spellCheck;
            if(spellCheck != null && spellCheck != "") {
                keywordParam = spellCheck.suggest;

                if(type == "A") {
                    getTalkAllSearchList(currentPaging, limit, obj);
                } else if(type == "Q") {
                    getOpenTalkListSearchResult(currentPaging, limit, obj);
                } else if(type == "P") {
                    getPollSearchResultList(currentPaging, limit, obj);
                } else if(type == "F") {
                    getQuestionSearchResultList(currentPaging, limit, obj);
                } else if(type == "R") {
                    getTalkReplySearchResultList(currentPaging, limit, obj);
                }
            }
        }
    });
}
var getAutoComplete = function(searchWord) {
    var param = {
        keyword: searchWord,
        limit: 10
    };

    tms.ajaxGetHelper(contextPath + "/api/search/autoComplete", param, null, function(res){
        var code = res.code;
        $(".search_area .datalist").empty();
        if(code === 0){
            var list = res.data.list;
            if(list != null && list.length > 0) {
                $("#autoCompleteTmpl").tmpl(res.data).appendTo(".search_area .datalist");
            }
        }
    });
}

var getRecommendKeywork = function() {
    var param = {
        pageNo: 1,
        limit: 10
    };

    tms.ajaxGetHelper(contextPath + "/api/search/recommendKeyword", param, null, function(res){
        var code = res.code;
        if(code === 0){
            var list1 = res.data.list1;
            var list2 = res.data.list2;
            if(list1 != null && list1.length > 0) {
                $("#recommendTmpl").tmpl(list1).appendTo("#recommend1");
            }
            if(list2 != null && list2.length > 0) {
                $("#recommendTmpl").tmpl(list2).appendTo("#recommend2");
            }
        }
    });
}

var getRecommendKeyworkPortal = function() {
    var param = {
        pageNo: 1,
        limit: 8
    };

    tms.ajaxGetHelper(contextPath + "/api/search/recommendKeyword", param, null, function(res){
        var code = res.code;
        if(code === 0){
            var list1 = res.data.list1;
            var list2 = res.data.list2;
            if(list1 != null && list1.length > 0) {
                $("#recommendTmpl2").tmpl(list1).appendTo("#recommend");
            }
            if(list2 != null && list2.length > 0) {
                $("#recommendTmpl2").tmpl(list2).appendTo("#recommend");
            }
        }
    });
}

//자유톡 댓글 전체보기 이동
var moreContentFreeFn = function(obj, talkNo, from) {
    //클릭 로그
    var rankNo = $(obj).parents("li").children(".rankNo").val();
    freeClickLog.rankNo = rankNo;
    logSearchClick(freeClickLog);

    location.href = contextPath + "/app/question/detail/"+talkNo + "?prev="+from+ "&keyword=" + keywordParam;
 /*   if(common.getDeviceType() == "A"){
        window.EduLinker.loadPage(window.location.protocol + "//" + window.location.host + contextPath + "/app/question/detail/" + talkNo + "?prev="+from+ "&keyword=" + keywordParam, true, false);
    }else if(common.getDeviceType() == "I"){
        location.href = contextPath + "/app/question/detail/"+talkNo + "?prev="+from+ "&keyword=" + keywordParam;
    }else{
        location.href = contextPath + "/app/question/detail/"+talkNo+ "?prev="+from+ "&keyword=" + keywordParam;
    }*/
};

//질문목 댓글 전체보기 이동
var moreContentQuestionFn = function(obj, talkNo, from) {
    //클릭 로그
    var rankNo = $(obj).parents("li").children(".rankNo").val();
    questionClickLog.rankNo = rankNo;
    logSearchClick(questionClickLog);

    if($(location).attr('pathname').indexOf(contextPath + "/page/portal/") != -1) {
        location.href = contextPath + "/page/portal/talk/detail/"+talkNo + "?prev="+from+ "&keyword=" + keywordParam + "&" + location.search.substr(1);
    }else {
        location.href = contextPath + "/app/opentalk/detail/"+talkNo + "?prev="+from+ "&keyword=" + keywordParam;
    }

    /*if(common.getDeviceType() == "A"){
        window.EduLinker.loadPage(window.location.protocol + "//" + window.location.host + contextPath + "/app/opentalk/detail/" + talkNo + "?prev="+from+ "&keyword=" + keywordParam, true, false);
    }else if(common.getDeviceType() == "I"){
        location.href = contextPath + "/app/opentalk/detail/"+talkNo + "?prev="+from+ "&keyword=" + keywordParam;
    }else{
        location.href = contextPath + "/app/opentalk/detail/"+talkNo + "?prev="+from+ "&keyword=" + keywordParam;
    }*/
};

//댓글 전체보기 이동
var moreContentTypeReplyFn = function(obj, talkNo, opentalkNo, pollNo, from) {
    //클릭 로그
    var rankNo = $(obj).parents("li").children(".rankNo").val();
    replyClickLog.rankNo = rankNo;
    logSearchClick(replyClickLog);

    if(opentalkNo == 1) { //질문톡
        moreContentQuestionFn(obj, talkNo, from);
    } else if(opentalkNo == 4) { //자유톡
        moreContentFreeFn(obj, talkNo, from);
    } else if(opentalkNo == 3) { //투표톡
        moveVoteDetail(obj, talkNo, pollNo, from);
    }
};


//투표하기 및 결과보기 페이지 이동 처리
var moveVoteDetail = function(obj, talkNo, pollNo, from) {
    //클릭 로그
    var rankNo = $(obj).parents("li").children(".rankNo").val();
    pollClickLog.rankNo = rankNo;
    logSearchClick(pollClickLog);

    // 비로그인 시 로그인창 띄움
    if(tms.isEmpty(userToken)){
        if(common.getDeviceType() == "A"){
            window.EduLinker.login();
        }else if(common.getDeviceType() == "I"){
            webkit.messageHandlers.callbackHandler.postMessage("login");
        }
        return;
    }

    location.href = contextPath + "/app/vote/prev?pollNo=" + pollNo + "&talkNo=" + talkNo + "&prev="+from+ "&keyword=" + keywordParam;
    // 기존에 값으로 판별하였으나, 어려워서 버튼 텍스트에 따라 판별하는 것으로 변경함
  /*  if(common.getDeviceType() == "A"){
        window.EduLinker.loadPage(window.location.protocol + "//" + window.location.host + contextPath + "/app/vote/prev?pollNo=" + pollNo + "&talkNo=" + talkNo + "?prev="+from+ "&keyword=" + keywordParam , true, false);
    }else if(common.getDeviceType() == "I"){
        location.href = contextPath + "/app/vote/prev?pollNo=" + pollNo + "&talkNo=" + talkNo + "&prev="+from+ "&keyword=" + keywordParam;
    }else{
        location.href = contextPath + "/app/vote/prev?pollNo=" + pollNo + "&talkNo=" + talkNo + "?prev="+from+ "&keyword=" + keywordParam;
    }*/
};

// 앱스플라이 애트리뷰션
function callAppsFlyer(viewParam) {
    if(common.getDeviceType() == "A"){
        window.app.recordEvent('google', 'Contact', '{\"location\":\"'+ viewParam +'\"}');
        window.app.recordEvent('facebook', 'Contact', '{\"location\":\"' + viewParam + '\"}');
        window.app.recordEvent('appsflyer', 'Contact', '{\"location\":\"'+ viewParam +'"}');
    }else if(common.getDeviceType() == "I"){
        webkit.messageHandlers.event.postMessage("google+Contact+{\"location\":\""+ viewParam +"\"}");
        webkit.messageHandlers.event.postMessage("facebook+Contact+{\"location\":\""+ viewParam +"\"}");
        webkit.messageHandlers.event.postMessage("appsflyer+Contact+{\"location\":\""+ viewParam +"\"}");
    }
}

// 게시글 프로필 연결
var invokeProfileFn = function (hipId, mentorYn){
    var writerMentorYn = mentorYn;
    var writerHipId = hipId;
    var userMentorYn = '';

    // 매니저 계정의 경우 프로필 연결 X
    if(writerHipId == managerHipId){
        return;
    }

    if(tms.isEmpty(userToken)){
        if(common.getDeviceType() == "A"){
            window.EduLinker.login();
        }else if(common.getDeviceType() == "I"){
            webkit.messageHandlers.callbackHandler.postMessage("login");
        }
    }else{
        inventoryApi.retrieveUserInformationInTheInventory(function(code,data,res){
            if(code === 0){
                userMentorYn = data.mentorYn;
            }
            blockCheck('profile', writerHipId, 'question');
            if (isBlockPofile == "N") {
                if (userMentorYn == writerMentorYn){// 본인인 경우
                    if(userHipId == writerHipId){
                        if(userMentorYn == 'Y'){
                            if(common.getDeviceType() == 'A'){
                                window.EduLinker.mentorProfile(userHipId);
                            }else if(common.getDeviceType() == 'I'){
                                webkit.messageHandlers.edulinker.postMessage("edulinker://mentor_profile?hipID="+userHipId);
                            }
                        }else if(userMentorYn == 'N'){
                            if(common.getDeviceType() == 'A'){
                                window.EduLinker.menteeProfile(userHipId);
                            }else if(common.getDeviceType() == 'I'){
                                webkit.messageHandlers.edulinker.postMessage("edulinker://mentee_profile?hipID="+userHipId);
                            }
                        }
                    }else{
                        $("#alertPopArea").html("");
                        common.openAlertPopup({message:'회원 유형이 같은 경우<br>프로필 열람이 불가합니다.', popupClass:'popup_point_charge_complete'});
                    }
                }else{ // 본인이 아닌 경우
                    if(writerMentorYn == 'Y'){
                        if(common.getDeviceType() == 'A'){
                            window.EduLinker.mentorProfile(writerHipId);
                        }else if(common.getDeviceType() == 'I'){
                            webkit.messageHandlers.edulinker.postMessage("edulinker://mentor_profile?hipID="+writerHipId);
                        }
                    }else if(writerMentorYn == 'N'){
                        if(common.getDeviceType() == 'A'){
                            window.EduLinker.menteeProfile(writerHipId);
                        }else if(common.getDeviceType() == 'I'){
                            webkit.messageHandlers.edulinker.postMessage("edulinker://mentee_profile?hipID="+writerHipId);
                        }
                    }
                }
            }else if(isBlockPofile == "Y"){
                goProfileByBlock(writerHipId, "profile", invokeProfileFn, {writerHipId:writerHipId, writerMentorYn:writerMentorYn}, 'question');
            }
        });
    }
};

// 본문 신고
var moveReport = function (writerHipId, talkNo, reportType){
    if(common.getDeviceType() == "A"){
        window.EduLinker.loadPage(window.location.protocol + "//" + window.location.host + contextPath + "/app/opentalk/report?talkNo="+ talkNo + "&reportType="+reportType+"&writerHipId="+writerHipId+"&prev=true",true,false);
    }else if(common.getDeviceType() == "I"){
        location.href = contextPath + "/app/opentalk/report?talkNo=" + talkNo + "&reportType="+reportType+"&writerHipId="+writerHipId+"&prev=true";
    }
};


var setTextHighlight = function(highlightList, talkContents) {

    if(highlightList != null && highlightList.length > 0) {
        for(var i=0; i<highlightList.length; i++) {
            var targetText = highlightList[i];

            var regex = new RegExp(targetText, "g");
            talkContents = talkContents.replace(regex, "<span class='highlight'>" + targetText + "</span>");
        }
    }

    return talkContents;
}

var moveToRight = function() {
    $('.rank_list ol').animate({
        scrollLeft: 400
    }, 800);
}

var moveToLeft = function() {
    $('.rank_list ol').animate({
        scrollLeft: 0
    }, 600);
}
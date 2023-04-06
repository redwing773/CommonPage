var jsessionid = "";
var freeClickLog = {
    screen: "오픈톡",
    clickScreen: "자유톡",
    index: "자유톡",
    rankNo: 0,
    logSearchId: ""
};
var pollClickLog = {
    screen: "오픈톡",
    clickScreen: "투표톡",
    index: "투표톡",
    rankNo: 0,
    logSearchId: ""
};
var questionClickLog = {
    screen: "오픈톡",
    clickScreen: "질문톡",
    index: "질문톡",
    rankNo: 0,
    logSearchId: ""
};
var replyClickLog = {
    screen: "오픈톡",
    clickScreen: "댓글",
    index: "댓글",
    rankNo: 0,
    logSearchId: ""
};
function logSearchList(hitYn, searchType) {
    // var url = contextPath +"/api/search/log";
    // var memNo = "";
    // if(hipId) {
    //     memNo = hipId;
    // } else {
    //     memNo = jsessionid;
    // }
    //
    // var screenNm = "";
    // if(searchType == "Q") { //질문톡
    //     screenNm = "질문톡";
    // } else if(searchType == "F") { // 자유톡
    //     screenNm = "자유톡";
    // } else if(searchType == "P") { //투표톡
    //     screenNm = "투표톡";
    // } else if(searchType == "R") { //댓글
    //     screenNm = "댓글";
    // }
    //
    // var params = {
    //     keyword: $("#searchKeyword").val()
    //     , mem_no : memNo
    //     , platform : osType
    //     , screen : screenNm
    //     , user_agent: navigator.userAgent.toLowerCase()
    //     , ip : ipAddress
    //     , hit_yn : hitYn
    // };
    //
    // tms.ajaxGetHelper(url, JSON.stringify(params), null, function(res) {
    //
    //     if(res.code == 0) {
    //         var data = res.data;
    //         if(searchType == "Q") { //질문톡
    //             questionClickLog.logSearchId = data.log_id;
    //         } else if(searchType == "F") { // 자유톡
    //             freeClickLog.logSearchId = data.log_id;
    //         } else if(searchType == "P") { //투표톡
    //             pollClickLog.logSearchId = data.log_id;
    //         } else if(searchType == "R") { //댓글
    //             replyClickLog.logSearchId = data.log_id;
    //         }
    //     }
    // });
}

function logSearchClick(clickObj) {
    if(clickObj.logSearchId == null || clickObj.logSearchId == "") {
        return false;
    }
    var url = contextPath + "/api/search/log/click";
    var memNo = "";
    if(hipId) {
        memNo = hipId;
    } else {
        memNo = jsessionid;
    }
    var params = {
        keyword: $("#searchKeyword").val()
        , log_search_id : clickObj.logSearchId
        , mem_no : memNo
        , index : clickObj.index
        , platform : osType
        , screen : clickObj.screen
        , click_screen : clickObj.clickScreen
        , user_agent: navigator.userAgent.toLowerCase()
        , ip : ipAddress
        , rank_no : clickObj.rankNo
    };

    tms.ajaxPostHelper(url, JSON.stringify(params), null, function(res) {
        console.log("logSearchClick res#########", res)
    });

}
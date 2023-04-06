var linkerApi = (function ($, win, doc) {
    /**
     * @description 멘토 목록 조회
     * @param start 시작 번호, listTypeCd 멘토링, 과외 구분
     * @param callback(code, data, res)
     **/
    var retrieveMentorList = function (start, listTypeCd, callback) {
        options = {urlChk:false};
        tms.ajaxGetHelper(properties.apiHost()+"/auth/svc/retrieveMentorList", {start: start, listTypeCd: listTypeCd}, options, function (res) {
            var code = res.resultCode;
            var data = (code === 0) ? res.result.mentorList : '';

            if ( typeof callback === "function" ) {
                console.log(res);
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 공지사항 조회
     * @param pageNo 페이지 번호
     * @param callback(code, data, res)
     **/
    var listNotice = function (pageNo, callback) {
        tms.ajaxGetHelper(properties.apiHost()+"/inventory/svc/listNotice?pageNo=" + pageNo, null, null, function(res){
            var code = res.resultCode;
            var data = (code === 0) ? res.result.noticeList : '';

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 공지사항 상세조회
     * @param noticeNo 공지사항 번호
     * @param callback(code, data, res)
     **/
    var getNoticeInfo = function (noticeNo, callback) {
        tms.ajaxGetHelper(properties.apiHost()+"/inventory/svc/getNoticeInfo", {noticeNo: noticeNo}, null, function(res){
            var code = res.resultCode;
            var data = (code === 0) ? res.result.noticeInfo : '';

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 우편함 조회
     * @param pageNo 페이지 번호
     * @param callback(code, data, res)
     **/
    var listPostBox = function (param, callback) {
        var defaults = {pageNo: ''};
        tms.ajaxPostHelper(properties.apiHost()+"/inventory/svc/listPostBox", JSON.stringify(returnParam(param, defaults)), null, function(res){
            var code = res.resultCode;
            var data = (code === 0) ? res.result.postBoxList : '';

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 우편함 상세조회
     * @param postBoxNo 우편함 번호
     * @param callback(code, data, res)
     **/
    var getPostBox = function (param, callback) {
        var defaults = {postBoxNo: ''};
        tms.ajaxPostHelper(properties.apiHost()+"/inventory/svc/getPostBox", JSON.stringify(returnParam(param, defaults)), null, function(res){
            var code = res.resultCode;
            var data = (code === 0) ? res.result.postBoxInfo : '';

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 우편함 안읽음 개수
     * @param callback(code, data, res)
     **/
    var unreadCountPostBox = function (callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/inventory/svc/unreadCountPostBox", null, null, function(res){
            var code = res.resultCode;
            var data = (code === 0) ? res.result.unreadCount : '';

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 우편함 읽음 처리
     * @param postBoxNo 우편함 번호
     * @param callback(code, res)
     **/
    var readPostBox = function (param, callback) {
        var defaults = {postBoxNo: ''};
        tms.ajaxPostHelper(properties.apiHost()+"/inventory/svc/readPostBox", JSON.stringify(returnParam(param, defaults)), null, function(res){
            var code = res.resultCode;

            if ( typeof callback === "function" ) {
                callback(code, res);
            }
        });
    };

    /**
     * @description 우편함 삭제
     * @param postBoxNo 우편함 번호
     * @param callback(code, res)
     **/
    var removePostBox = function (param, callback) {
        var defaults = {postBoxNo: ''};
        tms.ajaxPostHelper(properties.apiHost()+"/inventory/svc/removePostBox", JSON.stringify(returnParam(param, defaults)), null, function(res){
            var code = res.resultCode;

            if ( typeof callback === "function" ) {
                callback(code, res);
            }
        });
    };
    
    /**
     * 멘티의 행동데이터 저장
     * @param actionCategory, actionType, actionLogs, description
     * @param callback(code, res)
     * */
    var addActionLog = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/addActionLog", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		
    		if(typeof callback === "function"){
    			callback(code, res);
    		}
    	});
    }
    
    /**
     * 마켓 리뷰상태 조회
     * @param callback
     * */
    var getMarketReview = function(callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/getMarketReview", null, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.marketReview : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 마켓리뷰 상태 등록
     * @param param
     * @param callback
     * */
    var addMarketReview = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/addMarketReview", JSON.stringify(param), null, function(res) {
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.marketReview : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 이벤트 참여가능 여부 조회
     * @param callback
     * */
    var canJoinDailyEvent = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/canJoinDailyEvent", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.joinEvent : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
/*    
      이벤트를 참여한다
     @param callback
 */
    var joinDailyEvent = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/joinDailyEvent", JSON.stringify(param), null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * 이벤트를 참여한다 _ 회원가입시 생기부 열람이벤트 참여
     * @param callback
     * */
    var joinDailyEventForResiter = function(callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/registerEventCheck", null, null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    
    /**
     * 스페셜 패키지 상점 유저 행동로그 저장
     * @param param
     * @param callback
     * */
    var addActionLogShop = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/addActionLogShop", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		
    		if(typeof callback === "function"){
    			callback(code, res);
    		}
    	});
    }
    
    /**
     * 랭킹리스트 조회
     * @param param
     * @param callback
     * */
    var rankingList = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/rankingList", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 랭킹 유저리스트 조회 
     * @param param
     * @param param
     * */
    var rankingAccountList = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/rankingAccountList", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.rankingAccountList : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 모지 이벤트 홈배너 클릭시 이동 브릿지
     * @param param
     * @param param
     * */
    var addBannerLog = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/addBannerLog", param, {async:false}, null);
    }


    var returnParam = function(param, defaults){
        param = param || {};
        for (var prop in defaults)  {
            param[prop] = typeof param[prop] !== 'undefined' ? param[prop] : defaults[prop];
        }
        return param;
    };

    return {
        retrieveMentorList: retrieveMentorList,
        listNotice: listNotice,
        getNoticeInfo: getNoticeInfo,
        listPostBox: listPostBox,
        getPostBox: getPostBox,
        unreadCountPostBox: unreadCountPostBox,
        readPostBox: readPostBox,
        removePostBox: removePostBox,
        addActionLog: addActionLog,
        getMarketReview: getMarketReview,
        addMarketReview: addMarketReview,
        canJoinDailyEvent: canJoinDailyEvent,
        joinDailyEvent:joinDailyEvent,
        joinDailyEventForResiter:joinDailyEventForResiter,
        addActionLogShop:addActionLogShop,
        rankingList:rankingList,
        rankingAccountList:rankingAccountList,
        addBannerLog:addBannerLog
    }

}(jQuery, window, document));
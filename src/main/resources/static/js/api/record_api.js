var recordApi = (function ($, win, doc) {

    /**
     * @description 멘토가 제출한 생활기록부 파일의 내용을 출력
     * @param params
     * @param callback(code, data, res)
     **/
    var retrieveMentorSchoolRecordForMentorView = function (params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/sr/svc/v2/retrieveMentorSchoolRecordForMentorView", JSON.stringify(params), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0) ? res.result : null;

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 멘토가 제출한 자기소개서 내용을 출력
     * @param params
     * @param callback(code, data, res)
     **/
    var getMentorSelfReport = function (params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/sr/svc/getMentorSelfReport", JSON.stringify(params), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0) ? res.result : null;

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 멘토가 제출한 자기소개서 리스트를 조회
     * @param params
     * @param callback(code, data, res)
     **/
    var getMentorSelfReportList = function(params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/sr/svc/getMentorSelfReportList", JSON.stringify(params), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0) ? res.result : null;

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });

    }

    /**
     * @description 구매여부 조회
     * @param params
     * @param callback(code, data, res)
     **/
    var isPurchaseItem = function(params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/consult/svc/isPurchaseItem", JSON.stringify(params), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0) ? res.result : null;

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });

    }

    /**
     * @description 사용자의 구매정보를 조회
     * @param params
     * @param callback(code, data, res)
     **/
    var purchaseInfo = function(params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/consult/svc/purchaseInfo", JSON.stringify(params), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0) ? res.result : null;

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });

    }

    /**
     * @description 아이템 구매 (아이템)
     * @param params
     * @param callback(code, data, res)
     **/
    var useInventoryItemOfContents = function(params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/consult/svc/useInventoryItemOfContents", JSON.stringify(params), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0) ? res.result : null;

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });

    }

    /**
     * @description 아이템 구매(캐시)
     * @param params
     * @param callback(code, data, res)
     **/
    var purchaseItemOfContents = function(params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/consult/svc/purchaseItemOfContents", JSON.stringify(params), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0) ? res.result : null;

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });

    }

    /**
     * @description 자기소개서의 항목별로 확인
     * @param params
     * @param callback(code, data, res)
     **/
    var getOneMentorSelfReport = function(params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/sr/svc/getOneMentorSelfReport", JSON.stringify(params), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0) ? res.result : null;

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });

    }
    
    
    /**
     * 검색 조건에 따라 검색된 생기부 목록 조회
     * @param param
     * @param callback(code, data, res)
     * */
   var retrieveSchoolRecordList = function (param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveSchoolRecordList",  param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result.schoolRecordList : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }
    
    /**
     * 추천 생기부 목록 조회
     * @param param
     * @param callback(code, data, res)
     * */
    var getDisplaySet = function(param, callback){
        var defaults = {setId: 'home_set_3'}
        tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/getDisplaySet", returnParam(param, defaults), null,function(res) {
            var code = res.resultCode;
            var data = res.result.schoolRecordList;

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }
    
    /**
     * 생기부리스트 추천
     * @param universityPartyNoList
     * @param callback(code, data, res)
     * */
    var recommendSchoolRecord = function(param, option, callback){
    	tms.ajaxGetHelper(properties.apiHost()+"/consult/svc/recommendSchoolRecord", param, option, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
                callback(code, data, res);
            }
    	});
    }
    
    /**
     * 생기부 리스트 추천
     * @param callback
     * */
    var recommendSchoolRecordv2 = function(callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/v2/recommendSchoolRecord", null, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }


    var returnParam = function(param, defaults){
        param = param || {};
        for (var prop in defaults)  {
            param[prop] = typeof param[prop] !== 'undefined' ? param[prop] : defaults[prop];
        }
        return param;
    };

    return {
        retrieveMentorSchoolRecordForMentorView: retrieveMentorSchoolRecordForMentorView,
        getMentorSelfReport: getMentorSelfReport,
        getMentorSelfReportList: getMentorSelfReportList,
        isPurchaseItem: isPurchaseItem,
        purchaseInfo: purchaseInfo,
        useInventoryItemOfContents: useInventoryItemOfContents,
        purchaseItemOfContents: purchaseItemOfContents,
        getOneMentorSelfReport: getOneMentorSelfReport,
        retrieveSchoolRecordList:retrieveSchoolRecordList,
        getDisplaySet:getDisplaySet,
        recommendSchoolRecord:recommendSchoolRecord,
        recommendSchoolRecordv2:recommendSchoolRecordv2
    }

}(jQuery, window, document));
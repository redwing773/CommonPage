var portaltalkApi = (function ($, win, doc) {

    /**
     * @description 질문톡 작성 가능 여부 조회
     * @param callback(code, data, res)
     **/
    var canJoinPortalDailyEvent = function (param, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/etoos/canJoinDailyEvent", param, null, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result.joinEvent : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 임시 모지토큰 확인 
     * @param callback(code)
     **/
    var retrieveAuthorValue = function (param, option, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/etoos/retrieveAuthorValue", param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';
            
            if(typeof callback === "function") {
            	callback(code, data);
            }
        });
    }

    /**
     * @description 질문가능 룰 확인
     * @param callback(code)
     **/
    var retrieveMeasure = function (param, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/etoos/retrieveMeasure", param, null, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
                callback(code, data);
            }
        });
    }

    return {
        canJoinPortalDailyEvent: canJoinPortalDailyEvent,
    	retrieveAuthorValue: retrieveAuthorValue,
        retrieveMeasure: retrieveMeasure
    }
}(jQuery, window, document));



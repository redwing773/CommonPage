var mojiApi = (function ($, win, doc) {

    /**
     * @description 질문톡 작성 가능 여부 조회
     * @param callback(code, data, res)
     **/
    var canJoinMojiDailyEvent = function (param, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/canJoinMojiDailyEvent", param, null, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result.joinEvent : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 질문톡 작성 완료
     * @param callback(code)
     **/
    var joinMojiDailyEvent = function (param, option, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/joinMojiDailyEvent", param, option, function (res) {
            var code = res.resultCode;

            if(typeof callback === "function") {
                callback(code);
            }
        });
    }

    /**
     * @description 첫 질문 여부 확인, 두번이상 질문이라면 관심학교 관심계열 추출
     * @param callback(code, data, res)
     **/
    var mojiMatchingRequestInfo = function (param, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/mojiMatchingRequestInfo", param, null, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
            	callback(code, data, res);
            }
        });
    }
    
    /**
     * @description 관심 대학, 관심 계열 insert
     * @param callback(code)
     **/
    var mojiMatchingRequestInsert = function (param, option, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/mojiMatchingRequestInsert", param, option, function (res) {
            var code = res.resultCode;
            
            if(typeof callback === "function") {
            	callback(code);
            }
        });
    }
    
    /**
     * @description 임시 모지토큰 확인 
     * @param callback(code)
     **/
    var retrieveAuthorValue = function (param, option, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/retrieveAuthorValue", param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';
            
            if(typeof callback === "function") {
            	callback(code, data);
            }
        });
    }
    
    /**
     * @description 금칙어 작성 여부 확인
     * @param callback(code)
     **/
    var findBadWord = function (param, option, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/findBadWord", param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';
            
            if(typeof callback === "function") {
            	callback(code, data);
            }
        });
    }
    
    return {
    	canJoinMojiDailyEvent: canJoinMojiDailyEvent,
    	joinMojiDailyEvent: joinMojiDailyEvent,
    	mojiMatchingRequestInfo: mojiMatchingRequestInfo,
    	mojiMatchingRequestInsert: mojiMatchingRequestInsert,
    	retrieveAuthorValue: retrieveAuthorValue,
    	findBadWord: findBadWord
    }
}(jQuery, window, document));



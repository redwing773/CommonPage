var withdrawApi = (function ($, win, doc) {
    /**
     * @description 출금신청 규칙 정보
     * @param no 페이지 번호
     * @param callback(code, data, res)
     **/
    var withdrawRule = function (param, callback) {
        var defaults = {infoSeq:1};
        tms.ajaxGetHelper(contextPath + "/api/out/pay/rule", returnParam(param, defaults), null, function(res){
            var code = res.code;
            var data = (code === 0) ? res.data : '';

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 출금신청
     * @param no 페이지 번호
     * @param callback(code, data, res)
     **/
    var insertWithdraw = function (param, callback) {
        var defaults = {accountSeq:'', accountNm:'', bankCd:'', accountNumber:'', chargeAmt: '', applyAmt:''};
        tms.ajaxPostHelper(contextPath + "/api/out/pay", JSON.stringify(returnParam(param, defaults)), null, function(res){
            var code = res.code;

            if ( typeof callback === "function" ) {
                callback(code, res);
            }
        });
    };

    /**
     * @description 출금신청 목록 조회
     * @param no 페이지 번호
     * @param callback(code, data, res)
     **/
    var listWithdraw = function (param, callback) {
        var defaults = {cntPerPage: '10', currentPage:'1', searchMonth: "", orderType: "A"};
        tms.ajaxGetHelper(contextPath + "/api/out/pay/list", returnParam(param, defaults), null, function(res){
            var code = res.code;
            var data = (code === 0 || code === 102) ? res.data : '';

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 출금신청 상세 조회
     * @param no 페이지 번호
     * @param callback(code, data, res)
     **/
    var withdrawInfo = function (param, callback) {
        var defaults = {payingSeq: ''};
        tms.ajaxGetHelper(contextPath + "/api/out/pay", returnParam(param, defaults), null, function(res){
            var code = res.code;
            var data = (code === 0) ? res.data : '';

            if ( typeof callback === "function" ) {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 누적 출금금액 조회
     * @param no 페이지 번호
     * @param callback(code, data, res)
     **/
    var totalAmount = function (callback) {
    	tms.ajaxGetHelper(contextPath + "/api/out/pay/total", null, null, function(res){
            var code = res.code;
            if ( code === 0 ) {
                var data = tms.isNotEmpty(res.data) ? res.data.totalApplyAmt : '';

                if (typeof callback === "function") {
                    callback(code, data, res);
                }
            }
        });
    };

    /**
     * @description 출금 횟수 조회
     * @param param
     * @param callback(code, data, res)
     **/
    var applyLimitPeriod = function (param, callback ) {
        tms.ajaxGetHelper(contextPath + "/api/out/pay/apply/cnt", param, null, function(res) {
            var code = res.code;
            if ( code === 0 ) {
               var data = res.data.applyTotalCnt;

               if ( typeof callback === "function" ) {
                   callback(code, data, res);
               }
            }
        });
    }

    /**
     * @description 출금잔액 업데이트
     * @param param
     * @param callback(code)
     **/
    var balanceUpdate = function( param, callback ) {
        var defaults = {payingSeq:'', applyUuid:'', balanceAmt:''};
        tms.ajaxPutHelper(contextPath + "/api/out/pay/balance", JSON.stringify(returnParam(param, defaults)), null, function(res) {
           var code = res.code;

            if ( typeof callback === "function" ) {
                callback(code);
            }
        });
    }

    var returnParam = function(param, defaults){
        param = param || {};
        for (var prop in defaults)  {
            param[prop] = typeof param[prop] !== 'undefined' ? param[prop] : defaults[prop];
        }
        return param;
    }

    /**
     * @description 출금 계좌 정보 저장
     * @param callback(code, data, res)
     **/
    var insertBankAccount = function (param, callback) {
        tms.ajaxPostHelper(contextPath + "/api/out/pay/bank", JSON.stringify(param), null, function(res){
            var code = res.code;
            if ( typeof callback === "function" ) {
                callback(code, res);
            }
        });
    };

    /**
     * @description 출금 계좌 정보 조회
     * @param callback(code, data, res)
     **/
    var getBankAccount = function (callback) {
        tms.ajaxGetHelper(contextPath + "/api/out/pay/bank", null, null, function(res){
            var code = res.code;
            if ( typeof callback === "function" ) {
                callback(code, res);
            }
        });
    };

    return {
        withdrawRule: withdrawRule
        , insertWithdraw: insertWithdraw
        , listWithdraw: listWithdraw
        , withdrawInfo: withdrawInfo
        , totalAmount: totalAmount
        , applyLimitPeriod: applyLimitPeriod
        , balanceUpdate:balanceUpdate
        , insertBankAccount: insertBankAccount
        , getBankAccount: getBankAccount
    }

}(jQuery, window, document));
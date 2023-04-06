var inventoryApi = (function ($, win, doc) {
    /**
     * @description 인벤토리-???
     * @param callback(code, data, res)
     **/
    /*var insertInventory = function (param, callback) {
        var defaults = {itemId: '', itemMsg: '', itemAmt: '', transactionId: '', serviceType: '', expireDt: '', status: '', option: '', cashData: '', extraData: '', targetAccountNo: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/inventory/svc/insertInventory", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result.inventoryInfo:'';
            if(typeof callback == "function") {
                callback(code, data, res);
            }
        });
    };*/

    /**
     * @description 인벤토리-아이템 수량 조회
     * @param callback(code, data, res)
     **/
    var inventoryNumber = function (param, callback) {
        var defaults = {inventoryType: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/inventory/svc/inventoryNumber", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result.inventory:'';
            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 인벤토리-아이템 목록 조회
     * @param callback(code, data, res)
     **/
    var listInventory = function (param, callback) {
        var defaults = {pageNo: '', limit: '', inventoryType: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/inventory/svc/listInventory", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result.inventoryList:'';
            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 인벤토리-아이템 상세 조회
     * @param callback(code, data, res)
     **/
    var getInventory = function (param, callback) {
        var defaults = {inventoryNo: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/inventory/svc/getInventory", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result.inventoryInfo:'';
            if(typeof  callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 인벤토리-아이템 상세 조회 by itemId
     * @param callback(code, data, res)
     **/
    /*var getInventoryByItemId = function (param, callback) {
        var defaults = {itemId: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/inventory/svc/getInventoryByItemId", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result.inventoryInfo:'';
            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };*/

    /**
     * @description 인벤토리-아이템 삭제
     * @param callback(code, data, res)
     **/
    /*var removeInventory = function (param, callback) {
        var defaults = {inventoryNo: '', status: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/inventory/svc/removeInventory", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            if(typeof  callback === "function") {
                callback(code, res);
            }
        });
    };*/

    /**
     * @description 인벤토리-아이템 사용
     * @param callback(code, data, res)
     **/
    /*var useInventory = function (param, callback) {
        var defaults = {inventoryNo: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/inventory/svc/useInventory", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    };*/

    /**
     * @description 인벤토리-아이템 사용(사용 가능한 아이템)
     * @param callback(code, data, res)
     **/
    /*var getAvailableWithUseInventory = function (param, callback) {
        var defaults = {itemId: ''};
        tms.ajaxPostHelper(properties.apiHost() + "inventory/svc/getAvailableWithUseInventory", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    };*/

    /**
     * @description 인벤토리-쿠폰 등록
     * @param callback(code, data, res)
     **/
    var useCoupon = function (param, callback) {
        var defaults = {couponId: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/coupon/svc/useCoupon", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    };

    var produceCoupon = function(param, callback) {
        var defaults = {couponPin: '', type: '', title: '', rewardMsg: '', issueCount: '', limitCount: '', beginDt: '', expireDt: '', item: ''}
        tms.ajaxPostHelper(properties.apiHost() + "/coupon/svr/produceCoupon" + JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    };

    /**
     * @description 인벤토리에 내에서 사용자의 기본 정보를 불러온다.
     * @param param
     * @param callback(code, data, res)
     **/
    var retrieveUserInformationInTheInventory = function(callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/svc/retrieveUserInformationInTheInventory", null, {urlChk:false}, function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result.userInfo:'';

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 모지 구매자 전용 쿠폰 등록
     * @param param
     * @param callback(code, data, res)
     **/
    var validateMojiCoupon = function(param, callback){
        tms.ajaxPostHelper(properties.apiHost()+"/edu/svc/validateMojiCoupon", JSON.stringify(param), null, function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result:'';

            if(typeof callback === "function"){
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
        /*insertInventory: insertInventory*/
        inventoryNumber: inventoryNumber
        , listInventory: listInventory
        , getInventory: getInventory
        /*, getInventoryByItemId: getInventoryByItemId
        , removeInventory: removeInventory
        , useInventory: useInventory
        , getAvailableWithUseInventory: getAvailableWithUseInventory*/
        , useCoupon: useCoupon
        , produceCoupon: produceCoupon
        , retrieveUserInformationInTheInventory: retrieveUserInformationInTheInventory
        , validateMojiCoupon: validateMojiCoupon

    }
}(jQuery, window, document));
var codeApi = (function ($, win, doc) {

    /**
     * @description 각종 코드 조회
     * @param param
     * @return callback(code, data, res)
     **/
    var getRetrieveCd = function(param, callback){
        options = {urlChk:false};
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveCd", param, options,function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result.codeList:'';

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };

    var getRetrieveCd2 = function(param, callback){
        options = {async:false, urlChk:false};
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveCd", param, options,function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result.codeList:'';

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };

    var retrieveArea = function(callback) {
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveArea", null, null,function(res){
            var code = res.resultCode;
            var data = (code === 0) ? res.result : '';

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 학교 목록
     * @param param 닉네임
     * @param callback(code, data, res)
     **/
    var retrieveSchool = function(param, callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveSchool", param, null, function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result.schoolList:'';

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });

    };

    var getContentsSaleInfo = function(param, callback){
        tms.ajaxGetHelper(properties.apiHost()+"/sr/svc/getContentsSaleInfo", param, null,function(res){
            var code = res.resultCode;
            var data = (code === 0) ? res.result : '';

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };


    return {
        getRetrieveCd: getRetrieveCd
        , getRetrieveCd2: getRetrieveCd2
        , retrieveArea: retrieveArea
        , retrieveSchool: retrieveSchool
        , getContentsSaleInfo: getContentsSaleInfo
    }
}(jQuery, window, document));
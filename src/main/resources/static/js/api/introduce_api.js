var selfIntroApi = (function ($, win, doc) {

    /**
     * @description 입시멘토링 수시 전형 조회
     * @param callback(code, data, res)
     **/
    var getMentorAdmissionList = function (param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/getMentorAdmissionList", param, option,function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result.admissionList : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    var returnParam = function(param, defaults){
        param = param || {};
        for (var prop in defaults)  {
            param[prop] = typeof param[prop] !== 'undefined' ? param[prop] : defaults[prop];
        }
        return param;
    };

    return {
        getMentorAdmissionList: getMentorAdmissionList
    }
}(jQuery, window, document));



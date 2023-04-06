var membershipApi = (function ($, win, doc) {

    /**
     * @description 회원가입
     * @param callback(code, data, res)
     **/
    var register = function(param, callback){
        tms.ajaxPostHelper(properties.apiHost()+"/auth/svc/register", JSON.stringify(param), null, function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result:res.resultText;

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 회원가입
     * @param callback(code, data, res)
     **/
    var retrieveUid = function(param, callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveUid", param, null, function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result:'';

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 회원가입 약관
     * @param callback(code, data, res)
     **/
    var retrieveTermsList = function(callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveTerms", null, null, function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result.termsList:'';

            if(typeof callback === "function"){
                callback(code, data, res);
            }

        });
    };

    /**
     * @description 회원가입 약관 상세
     * @param no 약관 고유 번호
     * @param callback(code, data, res)
     **/
    var retrieveTerms = function(no, callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveTerms", {termsNo: no}, {async:false}, function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result.termsContent:'';

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 프로필 이미지 업로드
     * @param file 프로필 이미지 파일
     * @param callback(code, res)
     **/
    var registerProfile = function(file, callback){
        var param = new FormData();
        param.append('file1', file);
        tms.ajaxMulitpartHelper(properties.apiHost()+"/auth/svc/registerProfile", param, null, function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result.resourceUrl:'';

            if(typeof callback === "function"){
                callback(code, data, res);
            }

        });
    }

    /**
     * @description 메일 중복 체크
     * @param email 아이디(메일주소)
     * @param callback(code, data, res)
     **/
    var retrieveEmail = function(param, callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveEmail", param, null, function(res){
            var code = res.resultCode;
            var data = (code === 0 && res.result.use === 0) ? true : false;

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 닉네임 중복 체크
     * @param nickname 닉네임
     * @param callback(code, data, res)
     **/
    var retrieveNickname = function(param, callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveNickname", param, null, function(res){
            var code = res.resultCode;
            var data = (code === 0 && res.result.use === 0) ? true : false;

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

    /**
     * @description 휴대폰 인증코드 발송
     * @param param
     * @param callback(code, res)
     **/
    var sendSecretCode = function(param, callback){
        var defaults = {phoneNumber: ''};
        tms.ajaxPostHelper(properties.apiHost()+"/auth/svc/sendSecretCode", JSON.stringify(returnParam(param, defaults)), null, function(res){
            var code = res.resultCode;
            var msg = res.resultText;

            if(typeof callback === "function"){
                callback(code, msg, res);
            }
        });

    }

    /**
     * @description 휴대폰 인증코드 재발송
     * @param param
     * @param callback(code, res)
     **/
    var resendSecretCode = function(param, callback){
        var defaults = {phoneNumber: ''};
        tms.ajaxPostHelper(properties.apiHost()+"/auth/svc/resendSecretCode", JSON.stringify(returnParam(param, defaults)), null, function(res){
            var code = res.resultCode;
            var msg = res.resultText;

            if(typeof callback === "function"){
                callback(code, msg, res);
            }
        });

    }

    /**
     * 내 휴대폰 번호로 SMS 문자 발송
     * @param param
     * @param callback
     */
    var sendSecretCodeForMine = function(param, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/auth/svc/sendSecretCodeForMine", JSON.stringify(param), null, function(res){
            var code = res.resultCode;
            var msg = res.resultText;

            if(typeof callback === "function"){
                callback(code, msg, res);
            }
        });
    }

    /**
     * SMS 문자 인증
     * @param params
     * @param callback
     */
    var confirmSecretCode = function(params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/auth/svc/confirmSecretCode", JSON.stringify(params), null, function(res){
            var code = res.resultCode;

            if(typeof callback === "function"){
                callback(code, res);
            }
        });
    }

    /**
     * SMS 문자 인증 - 내 휴대폰 번호
     * @param params
     * @param callback
     */
    var confirmSecretCodeForMine = function(params, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/auth/svc/confirmSecretCodeForMine", JSON.stringify(params), null, function(res){
            var code = res.resultCode;

            if(typeof callback === "function"){
                callback(code, res);
            }
        });

    }

    /**
     * @description 인증 후 계정정보 조회
     * @param param
     * @param callback(code, data, res)
     **/
    var retrieveAccount = function(param, callback){
        // var defaults = {phoneNumber: '', smsConfirmCode: '', emailId: ''};
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveAccount", param, null, function(res){
            var code = res.resultCode;
            var data = (code === 0)?res.result.emailIdList:'';
            var msg = res.resultText

            if(typeof callback === "function"){
                callback(code, data, msg, res);
            }
        });

    }

    /**
     * @description 비밀번호 변경
     * @param param
     * @param callback(code, res)
     **/
    var updatePassword = function(param, callback){
        var defaults = {emailId: '', password: '', phoneNumber: '', smsConfirmCode: ''};

        tms.ajaxPostHelper(properties.apiHost()+"/auth/api/updatePassword", JSON.stringify(returnParam(param, defaults)), null, function(res){
            var code = res.resultCode;

            if(typeof callback === "function"){
                callback(code, res);
            }
        });

    }


    /**
     * @description 로그인 API
     * @param param
     * @param callback(code, res)
     **/
    const login = (param, callback) => {
        const defaults = {accountType: '', emailId: '', pushKey: ''};
        tms.ajaxPostHelper(properties.apiHost()+"/auth/svc/login",JSON.stringify(returnParam(param, defaults)), null, function(res){
            const code = res.resultCode;

            if(typeof callback === "function"){
                callback(code, res);
            }
        });
    }

    /**
     * @description 학생증 & 재학증명서 불러오기
     * @param param
     * @param callback(code, res)
     **/
    var retrieveCertified = function(callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/svc/retrieveCertified", null, null, function(res){
            var code = res.resultCode;

            if(typeof callback === "function"){
                callback(code, res);
            }
        });
    };

    /**
     * @description 학생증 & 재학증명서 등록
     * @param param
     * @param callback(code, res)
     **/
    var registerCertified = function(file, callback){
        var param = new FormData();
        param.append('file1', file);
        tms.ajaxMulitpartHelper(properties.apiHost()+"/auth/svc/registerCertified", param, null, function(res){
            var code = res.resultCode;

            if(typeof callback === "function"){
                callback(code, res);
            }
        });
    };

    /**
     * @description 멘토의 멘토링 조회
     * @param param
     * @param callback(code, res)
     **/
    var retrieveAcademicBackground = function(callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/svc/retrieveAcademicBackground", null, null, function(res){
            var code = res.resultCode;
            var data = res.result;

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 멘토의 멘토링 조회
     * @param param
     * @param callback(code, res)
     **/
    var retrieveMentorMentoring = function(param, callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/svc/retrieveMentorMentoring", param, null, function(res){
            var code = res.resultCode;
            var data = res.result;

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 지역검색 API
     * @param param
     * @param callback(code, res)
     **/
    var retrieveArea = function(callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/api/retrieveArea", null, null, function(res){
            var code = res.resultCode;
            var data = res.result.areaList;

            if(typeof callback === "function"){
                callback(code, data);
            }
        });
    }

    /**
     * @description 멘토 과외내역 확인
     * @param param
     * @param callback(code, res)
     **/
    var retrieveMentorLesson = function(param, callback){
        tms.ajaxGetHelper(properties.apiHost()+"/auth/svc/retrieveMentorLesson", param, null, function(res){
            var code = res.resultCode;
            var data = res.result;

            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 멘토 필수 정보 등록
     * @param param
     * @param callback(code, res)
     **/
    var additionalRegister = function(param, callback){
        tms.ajaxPostHelper(properties.apiHost()+"/auth/svc/additionalRegister", JSON.stringify(param), null, function(res){
            var code = res.resultCode;
            if(typeof callback === "function"){
                callback(code, res);
            }
        });
    }

    /**
     * @description 구매여부 확인 (생기부, 자소서)
     * @param param
     * @param callback(code, res)
     **/
    var isPurchaseItem = function(param, callback){
        tms.ajaxPostHelper(properties.apiHost()+"/consult/svc/isPurchaseItem", JSON.stringify(param), null, function(res){
            var code = res.resultCode;
            if(typeof callback === "function"){
                callback(code, res);
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

    return {
        register: register,
        retrieveTermsList: retrieveTermsList,
        retrieveTerms: retrieveTerms,
        registerProfile: registerProfile,
        retrieveEmail: retrieveEmail,
        retrieveNickname: retrieveNickname,
        retrieveSchool: retrieveSchool,
        sendSecretCode: sendSecretCode,
        resendSecretCode: resendSecretCode,
        confirmSecretCode: confirmSecretCode,
        sendSecretCodeForMine: sendSecretCodeForMine,
        confirmSecretCodeForMine: confirmSecretCodeForMine,
        retrieveAccount: retrieveAccount,
        updatePassword: updatePassword,
        login: login,
        retrieveCertified: retrieveCertified,
        registerCertified: registerCertified,
        retrieveAcademicBackground: retrieveAcademicBackground,
        retrieveMentorMentoring: retrieveMentorMentoring,
        retrieveArea: retrieveArea,
        retrieveMentorLesson: retrieveMentorLesson,
        additionalRegister: additionalRegister,
        retrieveUid: retrieveUid,
        isPurchaseItem: isPurchaseItem
    }
}(jQuery, window, document));
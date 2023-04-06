var myPageApi = (function ($, win, doc) {

    var updateMenteeInformationInTheMyInfo = function (param, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/updateMenteeInformationInTheMyInfo", JSON.stringify(param), null, function (res) {
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    };

    /**
     * @description 멘티 정보 조회
     * @param callback(code, data, res)
     **/
    var retrieveMenteeInformation = function (param, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMenteeInformation", param, null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result:'';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };
    
    /**
     * @description 프로필사진
     * @param callback(code, data, res)
     **/
    var retrieveProfile = function (callback) {
      tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveProfile", null, null, function (res) {
         var code = res.resultCode;
         var data = (code === 0)?res.result.destUrl:'';

         if(typeof callback === "function") {
             callback(code, data, res);
         }
      });
    };

    /**
     * @description 학생증 및 재학증명서
     * @param callback(code, data, res)
     **/
    var retrieveCertified = function (callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveCertified", null, null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result.destUrl:'';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 학생증 및 재학증명서
     * @param callback(code, res)
     **/
    var registerCertified = function (file, callback) {
        var param = new FormData();
        param.append("file1", file);
        tms.ajaxMulitpartHelper(properties.apiHost() + "/auth/svc/registerCertified", param, null, function (res) {
           var code = res.resultCode;
           var data = (code === 0)?res.result.resourceUrl:'';

           if(typeof callback === "function") {
               callback(code, data, res);
           }
        });
    }


    /**
     * @description 입력상태
     * @param callback(code, data, res)
     **/
    var retrieveMentorStatus = function (callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMentorStatus", null, {urlChk:false}, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result:'';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 멘토 학력
     * @param callback(code, data, res)
     **/
    var uploadMentorSchoolRecord = function (param, callback) {
        var defaults = {file1: '', schoolRecordPass: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/sr/svc/uploadMentorSchoolRecord", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result.schoolRecordTmpPath:'';
            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 멘토 생활기록부
     * @param callback(code, data, res)
     **/
    var updateMentorSchoolRecord = function (param, callback) {
        var defaults = {schoolRecordTmpPath: '', schoolRecordPath: '', schoolRecordPass: '', numberPages: '', numberAward: '', serviceTimes: '', numberBooks: '', lastSchoolRecord: ''};
        tms.ajaxPostHelper(properties.apiHost() + "/sr/svc/updateMentorSchoolRecord", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    };

    /**
     * @description 멘토 생활기록부 정보 받아오기
     * @param callback(code, data, res)
     **/
    var retrieveMentorSchoolRecord = function (callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/sr/svc/retrieveMentorSchoolRecord", null, null, function (res) {
            var code = res.resultCode;
            var data = res.result;

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 학원 정보 조회
     * @param callback(code, data, res)
     **/
    var retrieveAcademy = function (param, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/api/retrieveAcademy", param, null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result.academyList:'';

            if (typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 멘토 학원 정보
     * @param callback(code, data, res)
     **/
    var retrieveMentorAcademy = function(callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMentorAcademy", null, null, function (res) {
            var code = res.resultCode;
            var data = (code === 0)?res.result.academyList:'';

            if (typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 멘토 학원 정보 등록
     * @param callback(code, data, res)
     **/
    var additionalRegister = function(param, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/additionalRegister", JSON.stringify(param), null, function (res) {
            var code = res.resultCode;

            if (typeof callback === "function") {
                callback(code, res);
            }
        });
    };

    /**
     * @description 생활기록부 내역 확인
     * @param callback(code, data, res)
     **/
    var retrieveOneMentorSchoolRecord = function(param, callback) {
        var defaults = {schoolRecordCd: '' }
        tms.ajaxPostHelper(properties.apiHost() + "/sr/svc/retrieveOneMentorSchoolRecord", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;

            if (typeof callback === "function") {
                callback(code, res);
            }
        });
    };

    /**
     * @description 멘토 학력정보 조회
     * @param callback(code, data, res)
     **/
    var retrieveAcademicBackground = function (callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveAcademicBackground", null, null, function (res) {
            var code = res.resultCode;
            var data = res.result;

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    };

    /**
     * @description 멘토 학력정보 업데이트
     * @param callback(code, data, res)
     **/
    var updateAcademicBackground = function(param, callback) {
        var defaults = {majorNm: '',  universityPartyNo:0, universityPartyNo:0, departmentLineCd:0, departmentLineCd:0, studentId: '', schoolPartyNo: 0}
        tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/updateAcademicBackground", JSON.stringify(returnParam(param, defaults)), null, function (res) {
            var code = res.resultCode;

            if (typeof callback === "function") {
                callback(code, res);
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

    var registerSchoolRecordWithFile = function(param, option, callback) {
        tms.ajaxMulitpartHelper(properties.apiHost()+"/sr/svc/registerSchoolRecordWithFile", param, option, function(res){
            var code = res.resultCode;

            if (typeof callback === "function") {
                callback(code, res);
            }
        });
    };

    var registerSchoolRecordWithoutFile = function(param, option, callback) {
        tms.ajaxPostHelper(properties.apiHost()+"/sr/svc/registerSchoolRecordWithoutFile", JSON.stringify(param), option, function(res){
            var code = res.resultCode;

            if (typeof callback === "function") {
                callback(code, res);
            }
        });
    };
    
    // 멘토 판매설정 정보 조회
    var getMentorSaleInfo = function(callback){
    	tms.ajaxGetHelper(properties.apiHost()+"/sr/svc/getMentorSaleInfo", null, null, function(res){
    		var code = res.resultCode;
    		var data = res.result;
 
    		if(typeof callback === "function"){
    			callback(code, data, res);
    		}
    	});
    }
    
    // 멘토 맛보기여부 정보 저장
    var updateMentorSamplingYn = function(param, callback){
    	tms.ajaxPostHelper(properties.apiHost()+"/sr/svc/updateMentorSrSamplingYn", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		var res = res.resultText;
    		
    		if(typeof callback === "function"){
    			callback(code, res);
    		}
    	});
    }
    
    // 멘토 생기부 프리미엄 전시판매설정 정보 저장
    var updateMentorSrPremiumDisplayYn = function(param, callback){
    	tms.ajaxPostHelper(properties.apiHost()+"/sr/svc/updateMentorSrPremiumDisplayYn", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		var res = res.resultText;
    		
    		if(typeof callback === "function"){
    			callback(code, res);
    		}
    	});
    }
    
    // 사용자 추천인 저장
    var registerRecommendedPerson = function (param, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/registerRecommendedPerson", JSON.stringify(param), null, function(res){
            var code = res.resultCode;
            if(typeof callback === "function"){
                callback(code, res);
            }
        });
    }

    // 사용자 추천인 조회
    var retrieveRecommendedPerson = function(callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveRecommendedPerson", null, null, function(res){
            var code = res.resultCode;
            var data = (code === 0) ? res.result.recommendedPerson : '';
            if(typeof callback === "function"){
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 멘티 기본정보 조회
     * @param callback(code, data, res)
     **/
    var retrieveMenteeProfile = function (param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMenteeProfile",  param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }
    
    /**
     * @description 패키지 판매용
     * @param callback(code, data, res)
     **/
    var retrieveOneMentorSchoolRecord2 = function(param, option, callback) {
        var defaults = {schoolRecordCd: '' }
        tms.ajaxPostHelper(properties.apiHost() + "/sr/svc/retrieveOneMentorSchoolRecord", JSON.stringify(returnParam(param, defaults)), option, function (res) {
            var code = res.resultCode;
            var data = res.result;

            if (typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }
    
    /**
     * @description 내정보에서 멘티기본정보조회
     * @param callback(code, data, res);
     * */
    var retrieveMenteeInformationV2 = function(callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/v2/retrieveMenteeInformation", null, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * @description 내정보에서 멘티 기본정보 수정
     * @param param
     * @param callback(code, data, res);
     * */
    var updateMenteeInformationInTheMyInfoV2 = function(param, option, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/v2/updateMenteeInformationInTheMyInfo", JSON.stringify(param), option, function(res){
    		if(typeof callback === "function") {
    			callback(res);
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
        updateMenteeInformationInTheMyInfo: updateMenteeInformationInTheMyInfo,
        retrieveMenteeInformation: retrieveMenteeInformation,
        retrieveProfile: retrieveProfile,
        retrieveMentorStatus: retrieveMentorStatus,
        uploadMentorSchoolRecord: uploadMentorSchoolRecord,
        retrieveCertified: retrieveCertified,
        registerCertified: registerCertified,
        updateMentorSchoolRecord: updateMentorSchoolRecord,
        retrieveAcademicBackground: retrieveAcademicBackground,
        retrieveAcademy: retrieveAcademy,
        retrieveMentorAcademy: retrieveMentorAcademy,
        additionalRegister: additionalRegister,
        retrieveMentorSchoolRecord: retrieveMentorSchoolRecord,
        registerSchoolRecordWithFile: registerSchoolRecordWithFile,
        registerSchoolRecordWithoutFile: registerSchoolRecordWithoutFile,
        retrieveOneMentorSchoolRecord: retrieveOneMentorSchoolRecord,
        updateAcademicBackground: updateAcademicBackground,
        retrieveSchool: retrieveSchool,
        getMentorSaleInfo: getMentorSaleInfo,
        updateMentorSamplingYn: updateMentorSamplingYn,
        updateMentorSrPremiumDisplayYn: updateMentorSrPremiumDisplayYn,
        registerRecommendedPerson: registerRecommendedPerson,
        retrieveRecommendedPerson: retrieveRecommendedPerson,
        retrieveMenteeProfile: retrieveMenteeProfile,
        retrieveOneMentorSchoolRecord2:retrieveOneMentorSchoolRecord2,
        retrieveMenteeInformationV2:retrieveMenteeInformationV2,
        updateMenteeInformationInTheMyInfoV2:updateMenteeInformationInTheMyInfoV2
    }
}(jQuery, window, document));
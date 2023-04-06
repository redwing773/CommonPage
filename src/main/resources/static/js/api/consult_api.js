var consultApi = (function ($, win, doc) {

    /**
     * @description 메인 칼럼 목록 조회
     * @param callback(code, data, res)
     **/
    var getChannelList = function (param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/channelList", param, option,function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result.channelList : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 칼럼 질문 조회
     * @param callback(code, data, res)
     **/
    var getQnaList = function (param, option, callback) {
        tms.ajaxGetHelper(contextPath + "/api/mentalk/qnaList", param, option,function (res) {
            var code = res.code;
            var data = ( code === 0) ? res.data.list : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    var viewChannel = function (param, option, callback) {
        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/viewChannel", JSON.stringify(param), option, function (res) {
            var code = res.resultCode;

            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * @description 질문 리스트 조회
     * @param callback(code, res)
     **/
    var getQuestionList = function(param, callback){
        var defaults = {channelNo: '', page: '1', limit: '10'}
        tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/questionLists", returnParam(param, defaults), null,function (res) {
            var code = res.resultCode;
            var data = res.result.questionList;

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 멘토 내 칼럼 목록 조회
     * @param callback(code, data, res)
     **/
    var getMyList = function (param, callback) {
        tms.ajaxGetHelper(contextPath + "/api/mentalk/list", param, null, function (res) {
            var code = res.code;
            var data = ( code === 0) ? res.data.list : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 멘토 내 칼럼 상세 조회
     * @param callback(code, data, res)
     **/
    var getColumnDetail = function (param, callback) {
        tms.ajaxGetHelper(contextPath + "/api/mentalk", param, null, function (res) {
            var code = res.code;
            var info = ( code === 0) ? res.data.info : '';
            var list = ( code === 0) ? res.data.qna : '';

            if(typeof callback === "function") {
                callback(code, info, list);
            }
        });
    }

    /**
     * @description 멘토 내 칼럼 상세 조회 중 멘토 학력 조회
     * @param callback(code, data, res)
     **/
    var retrieveAcademicBackground = function (param, callback) {
        var option = {headers:{'authorization':authorization,
            'appVersion' : appVersion,
            'hipId':hipId,
            'osType' : osType,
            'deviceId' : deviceId,
            'apiToken': apiToken}};
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveAcademicBackground", param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 멘토 목록 조회
     * @param callback(code, data, res)
     **/
    var retrieveMentorList = function (param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMentorList",  param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }
    
    /**
     * @description 멘티 목록 조회
     * @param callback(code, data, res)
     **/
    var retrieveMenteeList = function (param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMenteeList",  param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 멘토 기본정보 조회
     * @param callback(code, data, res)
     **/
    var retrieveMentorProfile = function (param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMentorProfile",  param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 멘토 멘토링 조회
     * @param callback(code, data, res)
     **/
    var retrieveMentorMentoringForMentee = function (param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMentorMentoringForMentee",  param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 멘토 과외내역 조회
     * @param callback(code, data, res)
     **/
    var retrieveMentorLessonForMentee = function (param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMentorLessonForMentee",  param, option, function (res) {
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * 닉네임으로 검색하기
     * @param param
     * @param callback
     */
    var getSearchListByNickname = function(param, option, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/getSearchListByNickname", param, option, function(res){
            var code = res.resultCode;
            var data = ( code === 0) ? res.result : '';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    var awsFileUpload = function (param, callback) {
        tms.ajaxMulitpartHelper(contextPath +"/api/file/aws/upload", param, null, function (res) {
            var code = res.code;
            var data = (code === 0)?res.data:'';

            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * @description 멘토컬럼 저장
     * @param callback(code, data, res)
     **/
    var registerQna = function (param, callback) {
        tms.ajaxPostHelper(contextPath +"/api/mentalk", JSON.stringify(param), null, function (res) {
            /*var code = res.returnCode;
            var data = ( code === 0) ? res.result.mentorBackgroundList : '';
*/
            if(typeof callback === "function") {
                callback(res);
            }
        });
    }

    /**
     * @description 멘토컬럼 상태 임시저장
     * @param callback(code, data, res)
     **/
    var statusQnaWriting = function (param, callback) {
        tms.ajaxPostHelper(contextPath +"/api/mentalk/feedback/status/writing", JSON.stringify(param), null, function (res) {

            if(typeof callback === "function") {
                callback(res);
            }
        });
    }

    /**
     * @description 멘토컬럼 상태 제출
     * @param callback(code, data, res)
     **/
    var statusQnaChecking = function (param, callback) {
        tms.ajaxPostHelper(contextPath +"/api/mentalk/feedback/status/checking", JSON.stringify(param), null, function (res) {

            if(typeof callback === "function") {
                callback(res);
            }
        });
    }

    /**
     * @description 멘토칼럼 피드백 조회
     * @param callback(code, data, res)
     **/
    var getFeedback = function (param, callback) {
        tms.ajaxGetHelper(contextPath +"/api/mentalk/feedback/list", param, null, function (res) {
            if(typeof callback === "function") {
                callback(res);
            }
        });
    }

    /**
     * @description 멘토칼럼 상태 확인
     * @param callback(code, data, res)
     **/
    var getStatusMentalk = function (param, callback) {
        tms.ajaxGetHelper(contextPath +"/api/mentalk/feedback/status/list", param, null, function (res) {
            if(typeof callback === "function") {
                callback(res);
            }
        });
    }

    /**
     * 멘토칼럼 학교 목록 및 테마 목록 조회
     * @param param
     * @param callback
     */
    var channelSearchCondition = function (param, callback) {
        tms.ajaxGetHelper(properties.apiHost() +"/consult/svc/v2/channelSearchCondition", param, null, function (res) {
            if(typeof callback === "function") {
                callback(res);
            }
        });
    }

    var searchChannel = function(param, callback) {
        tms.ajaxGetHelper(properties.apiHost() +"/consult/svc/searchChannel", param, null, function (res) {
            if(typeof callback === "function") {
                callback(res);
            }
        });
    }
    
    /**
     * 멘토칼럼 상세 및 오픈톡(멘티->멘토)에서 채팅창 연결
     * @param param
     * @param callback
     * */
    var requestOpentalk = function(param, options, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/requestOpentalk", JSON.stringify(param), options, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : "";
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    		
    	});
    }
    
    /**
     * 오픈톡(멘토->멘티)에서 채팅창 연결
     * @param param
     * @param callback
     * */
    var proposeOpentalk = function(param, options, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/proposeOpentalk", JSON.stringify(param), options, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : "";
    		
    		if(typeof callback === "function"){
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 멘티가 질문 올리면 행동로그를 바탕으로 매칭
     * @param param
     * @param callback
     * */
    var matchingWithRequestMentoring = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/matchingWithRequestMentoring", JSON.stringify(param), null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * 투표 목록 조회
     * @param param
     * @param callback
     * */
    var pollList = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/pollList", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.pollList : '';
    		
    		if(typeof callback === "function"){
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 투표 질문항목 조회
     * @param param
     * @param callback
     * */
    var pollQuestion = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/pollQuestion", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 투표 결과정보 조회
     * @param param
     * @param callback
     * */
    var pollResult = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/pollResult", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 투표하기
     * @param
     * @param callback
     * */
    var poll = function(param, callback){
    	tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/poll" , JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		
    		if(typeof callback === "function") {
    			callback(code, res);
    		}
    	});
    }
    
    /**
     * 투표 검색조건/키워드 검색
     * @param param
     * @param callback
     * */
    var pollSearchCondition = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/edu/svc/pollSearchCondition", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 오픈톡 질문 등록 시 포인트 등록 가능여부 조회(하루 2번까지 가능)
     * @param callback
     * */
    var isPossibleRegistPoint = function(callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/isPossibleRegistPoint", null, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.talkInfo : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 오픈톡 답변 채택
     * @param param
     * @param callback
     * */
    var adoptAnswer = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/adoptAnswer", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		
    		if(typeof callback === "function") {
    			callback(code, res);
    		}
    	});
    }
    
    /**
     * 나의 오픈톡(댓글) 리스트 조회
     * @param param
     * @param callback
     * */
    var myOpentalk = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/myOpentalk", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.myOpentalkList : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 프리미엄 상점 배너 타겟 추가
     * @param param
     * @param callback
     * */
    var addBannerTarget = function(param, callback){
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/addBannerTarget", JSON.stringify(param), null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * 멘티가 멘토링을 요청한다
     * @param param
     * @param callback
     * */
    var requestMantomanV2 = function(param, option, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/v2/requestMantoman", JSON.stringify(param), option, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.question : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 홈 배너리스트 조회
     * @param param
     * @param callback
     * */
    var getBannerList = function(callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/getBannerList", null, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.bannerList : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 즐겨찾기 조회
     * @param param
     * @param callback
     * */
    var getBookmark = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/getBookmark", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 멘토칼럼, 게시판에서 즐겨찾기를 함
     * @param param
     * @param callback
     * */
    var bookmark = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/bookmark", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		
    		if(typeof callback === "function") {
    			callback(code, res);
    		}
    	});
    }
    
    /**
     * 즐겨찾기 리스트 조회
     * @param param
     * @param callback
     * */
    var bookmarkList = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/bookmarkList", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.opentalkList : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 멘토칼럼(오픈톡)을 검색
     * @param param
     * @param callback
     * */
    var searchOpentalk = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/searchOpentalk", param, null, function(res){
    		 if(typeof callback === "function") {
                 callback(res);
             }
    	});
    }

    /**
     * 멘토칼럼(오픈톡)을 검색
     * @param param
     * @param callback
     * */
    var searchOpentalkPortal = function(param, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/consult/etoos/searchOpentalk", param, null, function(res){
            if(typeof callback === "function") {
                callback(res);
            }
        });
    }

    var getMentalkDetail = function(param, callback) {
    	tms.ajaxGetHelper(contextPath + "/api/mentalk/detail", param, null, function(res){
    		var code = res.code;
    		var data = (code ===  0) ? res.data.list : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	})
    }
    
    
    /**
     * 보이스 컬럼 음원파일 업로드
     * @param param
     * @param callback
     * */
    var registerVoice = function(param, callback) {
    	tms.ajaxMulitpartHelper(properties.apiHost() + "/consult/svc/registerVoice", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 보이스 컬럼 파일 URL와 정보 저장
     * @param param
     * @param callback
     * */
    var writeVoiceColumn = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/writeVoiceColumn", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.resultText : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 보이스 컬럼 오디오파일 삭제
     * @param param
     * @param callback
     * */
    var deleteVoiceFile = function(param, callback){
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/deleteVoiceFile", param, null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * 보이스 컬럼 상세페이지
     * @param param
     * @param callback
     * */
    var voiceDetail = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/voiceDetail", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.voiceColumnInfo : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }

    /**
     * 보이스 컬럼 삭제 가능 여부
     * @param param
     * @param callback
     * */
    var voiceColumnDeletableCheck = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/voiceColumnDeletableCheck", param, null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * 보이스 컬럼 작성 가능 여부 (멘토당 하루 1번 작성 가능)
     * @param param
     * @param callback
     * */
    var voiceColumnUploadRecipientCheck = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/voiceColumnUploadRecipientCheck", null, null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * 보이스 컬럼 플레이 로그 삽입
     * @param param
     * @param callback
     * */
    var voiceColumnPlayUserCheck = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/voiceColumnPlayUserCheck", param, null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * 오늘, 리스트 출력
     * @param param
     * @param callback
     * */
    var getTodayList = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/getTodayList", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.list : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);
    		}
    	});
    }
    
    /**
     * 오늘, 같은 학년의 오늘 활동 리스트 출력
     * @param param
     * @param callback
     * */
    var getTodaySameGradeActivity = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/getTodaySameGradeActivity", param, null, function(res){
    		var code = res.resultCode;
    		var data = (code === 0) ? res.result.grade : '';
    		
    		if(typeof callback === "function") {
    			callback(code, data, res);    		
    		}
    	});
    }
    
    /**
     * 후원이 되는 보이스컬럼 삭제시, 다른 칼럼으로 후원을 이전
     * @param param
     * @param callback
     * */
    var alterDonateVoiceColumn = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/alterDonateVoiceColumn", param, null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * 멘토소개페이지, 해당 멘토의 후기
     * @param param
     * @param callback
     * */
    var retrieveMentorReview = function(param, callback) {
    	tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveMentorReview", param, null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    
    /**
     * 멘토소개페이지, 해당 멘토가 작성한 opentalk
     * @param param
     * @param callback
     * */
    var writeMentorReview = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/writeMentorReview", JSON.stringify(param), null, function(res){
    		if(typeof callback === "function") {
    			callback(res);
    		}
    	});
    }
    
    /**
     * 모지 답변 채택 처리
     * @param param
     * @param callback
     * */
    var adoptMojiAnswer = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/adoptMojiAnswer", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		
    		if(typeof callback === "function") {
    			callback(code, res);
    		}
    	});
    }
    
    /**
     * 모지 답변 채택 처리
     * @param param
     * @param callback
     * */
    var reportOpentalk = function(param, callback) {
    	tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/reportOpentalk", JSON.stringify(param), null, function(res){
    		var code = res.resultCode;
    		
    		if(typeof callback === "function") {
    			callback(code, res);
    		}
    	});
    }

    /**
     * 전문가멘토의 질문톡 리스트를 조회한다.
     * @param param
     * @param callback
     * */
    var retrieveExpertOpentalk = function(param, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveExpertOpentalk", param, null, function(res){
            var code = res.resultCode;
            var data = res.result.expertOpentalkList;
            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * 전문가멘토의 질문톡 리스트를 조회한다. (모지용)
     * @param param
     * @param callback
     * */
    var retrieveExpertOpentalkForMoji = function(param, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/retrieveExpertOpentalkForMoji", param, null, function(res){
            var code = res.resultCode;
            var data = res.result.expertOpentalkList;
            if(typeof callback === "function") {
                callback(code, data, res);
            }
        });
    }

    /**
     * 전문가멘토의 질문톡 클릭시 로그삽입
     * @param param
     * @param callback
     * */
    var addExpertOpentalkLog = function(param, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/auth/svc/addExpertOpentalkLog", param, null, function(res){
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * 모지 사전 구매 구입여부 확인
     * @param grade
     * @param option
     * @param callback
     * */
    var mojiPurchaseCheck = function(grade, option, callback) {

        if (grade === 0 || grade === 1 || grade === 2) {
            tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/lower/check", null, option, function(res){
                var code = res.resultCode;
                if(typeof callback === "function") {
                    callback(code, res);
                }
            });
        } else {
            tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/check", null, option, function(res){
                var code = res.resultCode;
                console.log(res)

                console.log(typeof callback === "function")
                if(typeof callback === "function") {
                    callback(code, res);
                }
            });
        }

    }

    /**
     * 모지 사전 구매 잔여 수량 조회
     * @param grade
     * @param callback
     * */
    var mojiPurchaseCount = function(callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/count", null, {async: false}, function(res){
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }
    const mojiPurchaseReportCount = (callback) => {
        tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/lower/count", null, {async: false}, function(res){
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * 모지 사전 구매완료시, 사전 구매 잔여 수량 차감한다.
     * */
    var mojiPurchaseCountDec = function(option) {
        var defaults = {amount: 1}
        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/moji/count/decrease", JSON.stringify(returnParam(null, defaults)), option, null);
    }

    /**
     * 모지 사전 구매완료시, 문자 발송
     * */
    var mojiPurchaseSendSms = function(grade, option) {
        // send sms code
        const LOWER = "lower";
        const HIGHER = "higher";

        let gradeCode = '';
        if (grade === 3 || grade === '3') {
            gradeCode = HIGHER
        } else {
            gradeCode = LOWER
        }
        tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/sms/send?grade=" + gradeCode, null, option, null);
    }

    /**
     * 모지 사전 구매완료시, 3000P 충전
     * */
    var mojiPurchaseChargeCoin = function(option) {
        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/moji/coin/charge", null, option, null);
    }

    /**
     * 모지 리포트 작성
     * */
    var mojiRequestReport = function(param, grade, callback) {
        if (grade === 0 || grade === 1 || grade === 2) {
            tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/moji/request/lower/report", JSON.stringify(param), { showLoding: true }, function(res){
                var code = res.resultCode;
                if(typeof callback === "function") {
                    callback(code, res);
                }
            });
        } else {
            tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/moji/request/v2/report", JSON.stringify(param), { showLoding: true }, function(res){
                var code = res.resultCode;
                if(typeof callback === "function") {
                    callback(code, res);
                }
            });
        }

    }

    /**
     * 모지 사전구매 페이지 유저 학년 정보 조회
     * */
    var mojiReportGrade = function(callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/report/grade", null, null, function(res){
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * 모지 리포트 작성 가능 횟수
     * */
    var mojiReportCount = function(grade, param, callback) {
        if (grade === 0 || grade === 1 || grade === 2) {
            tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/report/lower/count", param, null, function (res) {
                var code = res.resultCode;
                if (typeof callback === "function") {
                    callback(code, res);
                }
            });
        } else {
            tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/report/count", param, null, function(res){
                var code = res.resultCode;
                if(typeof callback === "function") {
                    callback(code, res);
                }
            });
        }
    }

    /**
     * 해당 회원의 진단리포트 리스트 조회
     * */
    var mojiReportList = function(callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/report/list", null, null, function(res){
            var code = res.resultCode;
            if(typeof callback === "function") {
                callback(code, res);
            }
        });
    }

    /**
     * 모지 진단리포트용 학교목록 조회
     * */
    var mojiRetrieveSchool = function(param, callback) {
        tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/moji/retrieve/school", param, null, function(res){
            var code = res.resultCode;
            var data = res.result.schoolList;
            if(typeof callback === "function") {
                callback(code, data);
            }
        });
    }

    /**
     *
     */
    const mojiIncrease = (param, callback) => {
        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/moji/lower/increase", JSON.stringify(param), null, function(res){
            console.log(res);
            var code = res.resultCode;
            if(typeof callback === "function") {
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

    return {
        getChannelList: getChannelList,
        getQnaList: getQnaList,
        getQuestionList: getQuestionList,
        getMyList: getMyList,
        getColumnDetail: getColumnDetail,
        retrieveAcademicBackground: retrieveAcademicBackground,
        registerQna: registerQna, //칼럼저장
        statusQnaWriting: statusQnaWriting, //상태변경 임시저장
        statusQnaChecking: statusQnaChecking, //상태변경 제출
        getFeedback: getFeedback,
        getStatusMentalk: getStatusMentalk,
        retrieveMentorList: retrieveMentorList,
        retrieveMenteeList: retrieveMenteeList,
        retrieveMentorProfile: retrieveMentorProfile,
        retrieveMentorMentoringForMentee: retrieveMentorMentoringForMentee,
        retrieveMentorLessonForMentee: retrieveMentorLessonForMentee,
        getSearchListByNickname: getSearchListByNickname,
        awsFileUpload: awsFileUpload,
        channelSearchCondition: channelSearchCondition,
        searchChannel: searchChannel,
        viewChannel: viewChannel,
        requestOpentalk: requestOpentalk,
        proposeOpentalk: proposeOpentalk,
        matchingWithRequestMentoring: matchingWithRequestMentoring,
        pollList: pollList,
        pollQuestion: pollQuestion,
        pollResult: pollResult,
        poll:poll,
        pollSearchCondition:pollSearchCondition,
        isPossibleRegistPoint:isPossibleRegistPoint,
        adoptAnswer:adoptAnswer,
        myOpentalk:myOpentalk,
        addBannerTarget:addBannerTarget,
        requestMantomanV2:requestMantomanV2,
        getBannerList:getBannerList,
        getBookmark:getBookmark,
        bookmark:bookmark,
        bookmarkList:bookmarkList,
        searchOpentalk:searchOpentalk,
        searchOpentalkPortal:searchOpentalkPortal,
        getMentalkDetail:getMentalkDetail,
        registerVoice:registerVoice,
        writeVoiceColumn:writeVoiceColumn,
        deleteVoiceFile:deleteVoiceFile,
        voiceColumnUploadRecipientCheck:voiceColumnUploadRecipientCheck,
        voiceColumnDeletableCheck:voiceColumnDeletableCheck,
        voiceDetail:voiceDetail,
        voiceColumnPlayUserCheck:voiceColumnPlayUserCheck,
        getTodayList:getTodayList,
        getTodaySameGradeActivity:getTodaySameGradeActivity,
        alterDonateVoiceColumn:alterDonateVoiceColumn,
        retrieveMentorReview:retrieveMentorReview,
        writeMentorReview:writeMentorReview,
        adoptMojiAnswer:adoptMojiAnswer,
        reportOpentalk:reportOpentalk,
        retrieveExpertOpentalk:retrieveExpertOpentalk,
        addExpertOpentalkLog:addExpertOpentalkLog,
        retrieveExpertOpentalkForMoji:retrieveExpertOpentalkForMoji,
        mojiPurchaseCheck:mojiPurchaseCheck,
        mojiPurchaseCount:mojiPurchaseCount,
        mojiPurchaseCountDec:mojiPurchaseCountDec,
        mojiPurchaseSendSms:mojiPurchaseSendSms,
        mojiPurchaseChargeCoin:mojiPurchaseChargeCoin,
        mojiRequestReport:mojiRequestReport,
        mojiReportGrade:mojiReportGrade,
        mojiReportCount:mojiReportCount,
        mojiReportList:mojiReportList,
        mojiRetrieveSchool:mojiRetrieveSchool,
        mojiIncrease:mojiIncrease
    }
}(jQuery, window, document));



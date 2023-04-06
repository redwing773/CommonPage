// 문의하기,제안하기 처리
var getConnectChat = function(targetHipId, compareMentorYn) {
    if(tms.isEmpty(userToken)){
        if(common.getDeviceType() == "A"){
            window.EduLinker.login();
        }else if(common.getDeviceType() == "I"){
            webkit.messageHandlers.callbackHandler.postMessage("login");
        }
    }else{
        getConnectChatBefore(targetHipId, compareMentorYn);
        if (isBlockPofile == 'N') {
            if (compareMentorYn == "Y") {
                // 문의하기
                requestOpentalk(targetHipId);

                // 앱스플라이 애트리뷰션
                var viewParam = '멘티_톡';
               callAppsFlyer(viewParam);
            } else if (compareMentorYn == "N") {
                // 제안하기
                proposeOpentalk(targetHipId);

                // 앱스플라이 애트리뷰션
                var viewParam = '멘토_톡';
                callAppsFlyer(viewParam);
            }
        }
    }
};


// 문의하기
var requestOpentalk = function(targetHipId) {
    var msgObj = {
        title: "멘토와의 채팅을 시작합니다."
        ,contents: "확인 시 채팅방이 오픈되며<br>멘토와 자유롭게 대화가 가능합니다."
        ,btnNm: "확인"
    };

    common.openConfirmPopupBeforeChat(msgObj, function(){
        var param = {
            targetHipId : targetHipId
        };

        if( typeof(consultType) != 'undefined' ) {
            param.consultType = consultType;
        }

        var options = {
            showLoding: true
        };

        consultApi.requestOpentalk(param, options, function(code, data, res){
            if(code === 0){
                var channelNo = data.question.channelNo;
                var channelUrl = data.question.channelUrl;
                var mentorHipId = targetHipId;

                if(common.getDeviceType() == "A"){
                    window.location.href = "edulinker://talk?channel_no="+channelNo+"&channel_url="+channelUrl+"&mentor_no="+mentorHipId;
                }else if(common.getDeviceType() == "I"){
                    webkit.messageHandlers.edulinker.postMessage("edulinker://talk?channel_no="+channelNo+"&channel_url="+channelUrl+"&mentor_no="+mentorHipId);
                }
            }else{
                var msg = res.resultText;
                $("#alertPopArea").html("");
                common.openAlertPopup({message:msg, popupClass:'popup_point_charge_complete'});
            }
        });
    });
};

// 제안하기
var proposeOpentalk = function(targetHipId) {
    if(common.getDeviceType() == 'A'){
        window.EduLinker.menteeProfile(targetHipId);
    }else if(common.getDeviceType() == 'I'){
        webkit.messageHandlers.edulinker.postMessage("edulinker://mentee_profile?hipID="+targetHipId);
    }
    /*
    var param = {
        targetHipId : targetHipId
        , consultType : consultType
    };

    var options = {
        showLoding: true
    };

    consultApi.proposeOpentalk(param, options, function(code, data, res){
        if(code === 0){
            var channelNo = data.question.channelNo;
            var channelUrl = data.question.channelUrl;
            var mentorHipId = userHipId; // '제안하기'에서는 본인의 hipId를 넘겨준다

            if(common.getDeviceType() == "A"){
                window.location.href = "edulinker://talk?channel_no="+channelNo+"&channel_url="+channelUrl+"&mentor_no="+mentorHipId;
            }else if(common.getDeviceType() == "I"){
                webkit.messageHandlers.edulinker.postMessage("edulinker://talk?channel_no="+channelNo+"&channel_url="+channelUrl+"&mentor_no="+mentorHipId);
            }
        }else{
            var msg = res.resultText;
            $("#alertPopArea").html("");
            common.openAlertPopup({message:msg, popupClass:'popup_point_charge_complete'});
        }
    });
    */
};
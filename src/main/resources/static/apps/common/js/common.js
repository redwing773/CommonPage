if (!String.prototype.startsWith) {
    String.prototype.startsWith = function(searchString, position) {
        position = position || 0;
        return this.indexOf(searchString, position) === position;
    };
}

var common = (function ($, win, doc) {
    var openAlertPopup = function(msgObj, fnAction) {
        $("#popAlert").tmpl(msgObj).appendTo("#alertPopArea");
        Layer_OPEN(".pop_alert");

        if(typeof fnAction == "function"){
            $(".pop_alert .btn_box a").bind("click", function(){
                fnAction();
                $(this).unbind();
            });
        }
    };

    var openConfirmPopup = function(msgObj, fnAction) {
        $("#alertPopArea").html("");
        $("#popConfirm").tmpl({message: msgObj}).appendTo("#alertPopArea");
        $(".popup_out").addClass("open");

        if(typeof fnAction == "function"){
            $(".popup_out .btn_box a.gray").bind("click", function(){
                fnAction();
                $(".popup_out").removeClass("open");
                $(this).unbind();
            });
        }
    };
    
    var openConfirmPopup2 = function(msgObj, fnAction) {
        $("#alertPopArea").html("");
        $("#popConfirm3").tmpl({message: msgObj}).appendTo("#alertPopArea");
        $(".popup_out").addClass("open");

        if(typeof fnAction == "function"){
            $(".popup_out .btn_box a.yes").bind("click", function(){
                fnAction();
                $(".popup_out").removeClass("open");
                $(this).unbind();
            });
        }
    };
    
    var openConfirmPopup3 = function(msgObj, fnAction, fnAction2) {
        $("#alertPopArea").html("");
        $("#popConfirm4").tmpl({message: msgObj}).appendTo("#alertPopArea");
        $(".popup_out").addClass("open");

        if(typeof fnAction == "function"){
            $(".popup_out .btn_box a.yes").bind("click", function(){
                fnAction();
                $(".popup_out").removeClass("open");
                $(this).unbind();
            });
            $(".popup_out .btn_box a.no").bind("click", function(){
            	fnAction2();
            	Layer_CLOSE('.popup_out');
            });
        }
    };

    var openConfirmPopupNew = function(msgObj, fnAction, fnAction2) {
        $("#alertPopArea").html("");
        $("#popConfirmNew").tmpl(msgObj).appendTo("#alertPopArea");
        $(".popup_out").addClass("open");

        if(typeof fnAction == "function"){
            $(".popup_out .btn_box a.yes").bind("click", function(){
                fnAction();
                $(".popup_out").removeClass("open");
                $(this).unbind();
            });
            $(".popup_out .btn_box a.no").bind("click", function(){
                if(typeof fnAction2 == "function"){
                    fnAction2();
                }
                Layer_CLOSE('.popup_out');
            });
        }
    };

    var openConfirmPopupBeforeChat = function(msgObj, fnAction, fnAction2) {
        $("#alertPopArea").html("");
        $("#popBeforeChat").tmpl(msgObj).appendTo("#alertPopArea");
        $(".popBeforeChat").addClass("open");

        if(typeof fnAction == "function"){
            $(".popBeforeChat_btn_box a.yes").bind("click", function(){
                fnAction();
                $(".popBeforeChat").removeClass("open");
                $(this).unbind();
            });
            $(".popBeforeChat_btn_box a.no").bind("click", function(){
                if(typeof fnAction2 == "function"){
                    fnAction2();
                }
                Layer_CLOSE('.popBeforeChat');
            });
        }
    };
    
    var openActionPopup = function(msgObj, fnAction){
    	$("#alertPopArea").html("");
    	$("#popCancel").tmpl(msgObj).appendTo("#alertPopArea");
    	$(".popup_out").addClass("open");	
    	
    	if(typeof fnAction == "function"){
            $(".popup_out .btn_box a.gray").bind("click", function(){
                fnAction();
                $(".popup_out").removeClass("open");
                $(this).unbind();
            });
        }
    };
    
    var openCancelPopup = function(msgObj, fnAction){
    	$("#alertPopArea").html("");
    	$("#popCancel2").tmpl(msgObj).appendTo("#alertPopArea");
    	$(".popup_out").addClass("open");	
    	
    	if(typeof fnAction == "function"){
            $(".popup_out .btn_box a.gray").bind("click", function(){
                fnAction();
                $(".popup_out").removeClass("open");
                $(this).unbind();
            });
        }
    };
    
    var openCheckPopup = function(msgObj, fnAction){
    	$("#alertPopArea").html("");
    	$("#popConfirm2").tmpl(msgObj).appendTo("#alertPopArea");
    	$(".popup_out").addClass("open");	
    	
    	if(typeof fnAction == "function"){
            $(".popup_out .btn_box a.confirm").bind("click", function(){
                fnAction();
                $(".popup_out").removeClass("open");
                $(this).unbind();
            });
        }
    };
    
    var openClosePopup = function(msgObj, fnAction){
    	$("#alertPopArea").html("");
    	$("#popConfirm2").tmpl(msgObj).appendTo("#alertPopArea");
    	$(".popup_out").addClass("open");	
    	
    	if(typeof fnAction == "function"){
            $(".popup_out .btn_box a.gray").bind("click", function(){
                fnAction();
                $(".popup_out").removeClass("open");
                $(this).unbind();
            });
        }
    	
    	$(".popup_out .btn_box a.confirm").on("click", function(){
    		$(".popup_out").removeClass("open");
    	});
    }
    
    var dateFormat = function(date, format){
        return tms.isNotEmpty(date)? moment.utc(date).local().format(format) : "";
    };

    var dateUnixFormat = function(date, format){
        return tms.isNotEmpty(date)?moment.unix(date).tz('Asia/Seoul').format(format) : "";
    };

    var getDeviceType = function() {
        var agent = navigator.userAgent.toLowerCase();
        if (agent.indexOf('android') > -1) {
            //안드로이드 일때 처리
            return "A";
        } else if (agent.indexOf("iphone") > -1 || agent.indexOf("ipad")> -1 || agent.indexOf("ipod") > -1) {
            //IOS 일때 처리
            return "I";
        } else {
            //아이폰, 안드로이드 외 처리
            return "P";
        }
    };
    
    var createUuid = function () {
    	return 'xxxxxxxxxxxx4xxxyxxxxxxxx'.replace(/[xy]/g, function(c) {
    		var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
			return v.toString(16);
    	});
    };

	var compareVersion = function(compareVer , currentVer) {
		var res = true; // 버전 비교 결과값으로 사용할 변수
		var compareVal = compareVer.split("."); // 버전값 배열 처리
		var currentVal = currentVer.split(".");
		
		var len = Math.max(compareVal.length, currentVal.length);

		for(var i=0; i<len; i++){
			compareVer = compareVal[i] ? parseInt(compareVal[i], 10) : 0;
			currentVer = currentVal[i] ? parseInt(currentVal[i], 10) : 0;
			
			if(compareVer > currentVer) { // 서버 > 현재 버전
				res = false; // 서버 버전이 더 클 경우 버튼 노출
				break;
			}
			
			if(compareVer < currentVer){
				res = true;
				break;
			}
		}
		return res;
	};
	
	var validTitle = function(value) {
		if(value == "" || value == null || value == undefined){
			common.openAlertPopup({message:'제목을 입력해 주세요.', popupClass:'popup_point_charge_complete'});
			return -1;
		}else{
			return 0;	
		}
	};
	
	var validContent = function(value) {
		if(value == "" || value == null || value == undefined){			
			common.openAlertPopup({message:'내용을 입력해 주세요.', popupClass:'popup_point_charge_complete'});
			return -1;
		}else{
			return 0;	
		}
	};

	var validHipId = function (value) {
		if(value == ""){
			common.openAlertPopup({message:'올바른 사용자가 아닙니다.<br>다시 확인해 주세요.', popupClass:'popup_point_charge_complete'});
			return -1;
		}else{
			return 0;
		}
	};

    var urlInfo = {
        useItem: contextPath + "/app/item/use",
        endItem: contextPath + "/app/item/end",
        inventory: contextPath + "/app/inventory", //인벤토리 메인
        payment: contextPath + "/app/point/purchase", //포인트 결제
        paymentItem: contextPath + "/app/point/payment", //포인트 결제 상품 목록
        pointList: contextPath + "/app/point/list",
        withdrawMain: contextPath + "/app/withdraw/main",
        withdrawList: contextPath + "/app/withdraw/list",
        withdrawApply: contextPath + "/app/withdraw/apply",
        withdrawDetail: contextPath + "/app/withdraw/detail",
        withdrawBank: contextPath + "/app/withdraw/bank",
        withdrawPoint: contextPath + "/app/withdraw/point",
        mypage: "edulinker://myinfo_manage", //내정보수정
        record: contextPath + "/app/mypage/record",
        introducePop: contextPath + "/app/mypage/introducePop", //자기소개서 팝업
        opentalkList: contextPath + "/app/opentalk/list", //오픈톡 리스트 - hr
        useCoupon: contextPath + "/app/coupon/use", // 사용 가능 쿠폰 목록
        endCoupon: contextPath + "/app/coupon/end", // 사용한 쿠폰 목록
        mentoring: "edulinker://mentoring", // 쿠폰상세에서 이동
        parent: contextPath + "/app/point/parent", // '부모님께 충전요청'
        requestPayment: contextPath + "/app/point/requestPayment", // 메세지 발송 페이지
        payment2: contextPath + "/app/point/purchase2", // '부모님께 충전요청' 결제
        postList: contextPath + "/app/post/list",
        shopCategory: contextPath + "/app/shop/category",
        shopList : contextPath + "/app/shop/list",
        shopDetail : contextPath + "/app/shop/detail",
        recommend : contextPath + "/app/mypage/recommend" // 친구추천

    };

    var userInfo = {
        nickname: '',
        mentorYn: '',
        email: '',
        isLogin: false
    };

    var message = {
        defaultErr: {message: "오류가 발생했습니다. 잠시 후 다시 시도해주세요.", popupClass:"popup_point_charge_complete"}
    };

    return {
        openAlertPopup: openAlertPopup,
        openConfirmPopup: openConfirmPopup,
        openActionPopup: openActionPopup,
        openCancelPopup: openCancelPopup,
        openCheckPopup: openCheckPopup,
        openClosePopup: openClosePopup,
        dateFormat: dateFormat,
        dateUnixFormat: dateUnixFormat,
        getDeviceType: getDeviceType,
        urlInfo: urlInfo,
        message: message,
        userInfo: userInfo,
        createUuid: createUuid,
        compareVersion:compareVersion,
        validTitle:validTitle,
        validContent:validContent,
        validHipId:validHipId,
        openConfirmPopup2:openConfirmPopup2,
        openConfirmPopup3:openConfirmPopup3,
        openConfirmPopupNew:openConfirmPopupNew,
        openConfirmPopupBeforeChat:openConfirmPopupBeforeChat
    }
}(jQuery, window, document));

$(function () {
    dataLayer.push({'conMedia': 'APP'});
});
/*
if(common.getDeviceType() == "I") {
    window.webkit.messageHandlers.jsonCallbackHandler.postMessage(JSON.stringify({action: 'getHeader'}));
} else if(common.getDeviceType() == "A") {
    window.EduLinker.getHeader();
}

var updateHeader = function(jsonString) {
    //JSON.parse(jsonString).Authorization
    //쿠키 굽고 새로고침 필요
};
*/

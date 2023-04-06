$(function () {
    $("#moveMyInfo").on("click", function () {
        location.href = common.urlInfo.myPageMyInfo;
    });

    $("#moveAcademyBg").on("click", function () {
        location.href = common.urlInfo.myPageAcademicBg;
    });

    $("#moveWithdraw").on("click", function () {
        location.href = common.urlInfo.withdrawPoint; // 앱과 맞추기 위해 widthdrawMain에서 withdrawPoint로 변경
    });

    $("#moveInventory").on("click", function () {
        location.href = common.urlInfo.inventory;
    });

    $("#moveCustomerCenter").on("click", function () {
        location.href = common.urlInfo.faq;
    });

    $("#serviceGuide").on("click", function(){
        location.href = common.urlInfo.guide;
    });

    $("#menteeInfo").on("click", function(){
        location.href = common.urlInfo.menteeInfo;
    });
    
    $("#moveCoupon").on("click",function(){
    	location.href = common.urlInfo.useCoupon; // 쿠폰함 이동
    });
    
    $("#movePoint").on("click",function(){
    	location.href = common.urlInfo.pointList; // 멘티 - 보유 포인트 목록 이동
    });
    
    $("#movePayment").on("click",function(){
    	location.href = common.urlInfo.paymentItem; // 멘티 - 충전하기
    });
    
    $("#movePost").on("click",function(){
    	location.href = common.urlInfo.postList;
    });
    
    $("#moveNotice").on("click",function(){
    	location.href = common.urlInfo.notice;
    });
    
    $("#moveRecommend").on("click",function(){
    	location.href = common.urlInfo.recommend;
    });
    
    $("#moveSetting").on("click",function(){
    	location.href = common.urlInfo.password;
    });
    
    $("#moveSaleInfo").on("click",function(){
    	location.href = common.urlInfo.saleInfo;
    });
    
    $("#moveAdmin").on("click", function(){
    	location.href = common.urlInfo.connectLog;
    });

    $("#moveMembership").on("click", function() {
        var accessTokenInter = tms.getCookie("accessTokenInter");
        window.open(properties.membershipAuthDomain()+"/mypage/gate/home?clientId="+properties.membershipClientId()+"&returnURL="+ properties.membershipMypageReturnUrl() + "&accessToken=" + accessTokenInter, '통합회원', 'width=500, height=900, resizable=no');
    });
});

var mypageCallback = function(userRes){
    var lnbInfo = common.userInfo;
    var mentorYn = lnbInfo.mentorYn;
    var nickname = lnbInfo.nickname;
    var mobileNumber = lnbInfo.mobileNumber;
    var email = lnbInfo.email;

    if(mentorYn != "Y"){
        $("[data-type=mento]").remove();
        if(typeof mobileNumber == "undefined" && tms.isEmpty(email)) {
            $("#moveRecommend").remove();
        }
    } else {
        $("[data-type=mentee]").remove();
    }
    if(nickname != "링커매니저" && nickname != "zzinny" && nickname != "심술좋아"){
    	$("[data-type=admin]").remove();
    }
    var integratedMemberYn = tms.getCookie("integratedMemberYn");
    if(integratedMemberYn != "Y") {
        $("[data-type=integration]").remove();
    }

    myPageApi.retrieveMentorStatus(function (code, data, res) { //생기부 여부 확인
        var code = res.resultCode;
        if(code === 0){
            data.isRecord = data.schoolRecord;
        }
        var destUrl = userRes.result.destUrl;
        if(tms.isNotEmpty(destUrl)){
            lnbInfo.profileImg = "<img src='"+destUrl+"' />";
        }
        $(".side_bar .profile_box").append($("#lnbTmpl").tmpl(lnbInfo));
        
        if(mentorYn == 'N'){
        	$(".side_bar .profile_box").css("padding-bottom","0px");
        }

        var pointParam = {
            service_id : "LINKER",
            coin_id : (mentorYn == "Y")?"LINKER_MENTO_CASH":"LINKER_MENTI_CASH"
        };

        tms.ajaxGetHelper(properties.apiHostShop() + "/coin/" + properties.apiVersionShop + "/Balance", pointParam,null,function (res) {
            var code = res.response_code;
            var data = (code === 0)?res.value.coin_amount:'';

            var $lnbObj = $(".profile_box .linker_money");
            $lnbObj.find(".ico_point").text("보유포인트");
            $lnbObj.find(".money").text(tms.setComma(data));
        });

    });

}
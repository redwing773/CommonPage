/**
 * @description 간소화 회원의 별도 처리를 위한 로직입니다
 * @date 2022-11-15
 *
* */

var simpleUser = (function ($, win, doc) {
    //프로필입력 안내 팝업
    var openSimpleUserProfileGuidePopup = function() {
        const _message = "링커앱에서 프로필 작성 후<br/>포인트를 충전하실 수 있습니다.";
        common.openAlertPopup(_message, function(){
            location.href = "/";
        });
    }

    var isSimpleUser = function(){
        return common.userInfo.isLogin && tms.isEmpty(common.userInfo.mobileNumber) && tms.isEmpty(common.userInfo.email);
    }

    var hideMenuToPoint = function(){
        if(isSimpleUser()) {
            $(".jq_simple_user_hide").remove();
        }
    }

    return {
        openSimpleUserProfileGuidePopup:openSimpleUserProfileGuidePopup,
        isSimpleUser:isSimpleUser,
        hideMenuToPoint:hideMenuToPoint,
    }
}(jQuery, window, document));

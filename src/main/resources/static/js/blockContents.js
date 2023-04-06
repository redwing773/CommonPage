var isBlockContents = "N";

$(function () {
    $(window).click(function(e) {
        if ($('.blockContents').hasClass("on") && !$(e.target).hasClass("block") && !$(e.target).hasClass("unBlock") && !$(e.target).hasClass("no") && !$(e.target).hasClass("drop_bar")){
            $('.drop_content').hide();
            $('.blockContents').removeClass("on");
        }
    });

    $(document).on("click", ".blockContents .drop_bar", function(){
        var $this = $(this);
        clickDropbar($this);
    });

    /* 일부IOS기기 동적 클릭 이벤트 감지못하여, 클릭 이벤트 추가 */
    $(".fl_rr.blockContents .drop_bar").on("click", function(e){
        e.stopPropagation(); //중복 클릭 방지
        var $this = $(this);
        clickDropbar($this);
    });
});

var clickDropbar = function($this){
    if(tms.isEmpty(userToken)){
        if(common.getDeviceType() == "A"){
            window.EduLinker.login();
        }else if(common.getDeviceType() == "I"){
            webkit.messageHandlers.callbackHandler.postMessage("login");
        }
    }else {
        if(common.getDeviceType() == "I"){
            if (common.compareVersion("1.4.1", currentVer) == false) {
                $("a").remove(".block, .unBlock");
            }
        }else if(common.getDeviceType() == "A"){
            if (common.compareVersion("1.4.0", currentVer) == false) {
                $("a").remove(".block, .unBlock");
            }
        }

        var thisId = $this.attr('id');
        var blockContents = $this.closest('.blockContents');
        var hipId = "";

        if (thisId.indexOf("contents") >= 0){
            hipId = $this.attr('id').split("contents")[1];
            isBlock(blockContents, "contents", hipId);
        }else if(thisId.indexOf("reply") >= 0) {
            hipId = $this.attr('id').split("reply")[1];
            isBlock(blockContents, "reply", hipId);
        }
    }
};

var blockList = function(from){
    tms.ajaxGetHelper(properties.apiHost() + "/consult/svc/blockList", null, null, function (res) {
        var code = res.resultCode;
        if(code === 0){
            var data = res.result.blockContentList;
            data.forEach(function(element){
                var blockType = element.blockType;
                var blockCk = element.isBlock;
                var hipId = element.hipId;
                if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                    if (blockCk && !(blockType == "profile")) {
                        $(".blockReply" + hipId).hide();
                        $(".blockReplyImg" + hipId).show();
                        $(".blockContentsText" + hipId).hide();
                        $(".blockContentsImg" + hipId).show();
                        $(".blockReply" + hipId).prevAll("button").hide();
                    }
                }
            });
        }
    });
}

var isBlock = function(obj, type, hipId, no){
    tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/isBlock", JSON.stringify({type:"contents|reply", hipId: hipId}), null, function (res) {
        var code = res.resultCode;
        var data = res.result;
        if(code === 0){
            var isBlock = data.isBlock;
            if (obj){
                var block = $(obj).find('.block');
                var unBlock = $(obj).find('.unBlock');
                var drop_content = $(obj).find('.drop_content');

                if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                    if (isBlock) {
                        //차단된 컨텐츠일때
                        $(block).hide();
                        $(unBlock).show();
                    } else {
                        //차단되지 않은 컨텐츠일때
                        $(unBlock).hide();
                        $(block).show();
                    }
                }

                //클릭시 드롭바 동작상태 변경
                if ($(obj).hasClass("on")) {
                    $(drop_content).hide();
                    $(obj).removeClass("on");
                } else {
                    $(drop_content).show();
                    $(obj).addClass("on");
                }
            }else {
                if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                    if (isBlock) {
                        doUnblockColum(type, hipId, no);
                    }
                }
            }
        }
    });
}

var block = function(obj, type, hipId, no, from){
    var blockContents = $(obj).closest('.blockContents');
    var drop_content = $(blockContents).find('.drop_content');

    var msgObj = {
        title: "차단"
        ,contents: "사용자의 게시글/댓글을<br>차단하시겠습니까?"
        ,subContents: "차단 시 모든 글은 숨김 처리 됩니다."
        ,btnNm: "차단"
    };

    common.openConfirmPopupNew(msgObj, function(){
        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/block", JSON.stringify({type:type, hipId: hipId, targetId: no}), null, function (res) {
            var code = res.resultCode;
            if(code == 0) {
                if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                    if( typeof(blockYn) != 'undefined' ) {
                        blockYn = "Y";
                    }
                    showToast("차단이 완료되었습니다.");
                    $(drop_content).hide();
                    $(blockContents).removeClass("on");

                    if (from == "columContent" || from == "columReply") {
                        closeWeb();
                    } else {
                        $(".blockContentsText" + hipId).hide();
                        $(".blockContentsImg" + hipId).show();
                        $(".blockReply" + hipId).hide();
                        $(".blockReplyImg" + hipId).show();
                        $(".blockReply" + hipId).prevAll("button").hide();
                    }
                    blockEvent(type);
                }
            }
        });
    });
};

var unBlock = function(obj, type, hipId, no){

    var blockContents = $(obj).closest('.blockContents');
    var drop_content = $(blockContents).find('.drop_content');

    var msgObj = {
        title: "차단해제"
        ,contents: "차단 해제하시겠습니까?"
        ,subContents: "해제 시 사용자의<br>모든 작성글을 확인할 수 있습니다."
        ,btnNm: "차단해제"
    };

    common.openConfirmPopupNew(msgObj, function(){
        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/unblock", JSON.stringify({type:"contents|reply", hipId: hipId, targetId: no}), null, function (res) {
            var code = res.resultCode;
            if(code === 0){
                if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                    if( typeof(blockYn) != 'undefined' ) {
                        blockYn = "Y";
                    }
                    showToast("차단이 해제 되었습니다.");

                    $(drop_content).hide();
                    $(blockContents).removeClass("on");

                    $(".blockContentsImg" + hipId).hide();
                    $(".blockContentsText" + hipId).show();
                    $(".blockReplyImg" + hipId).hide();
                    $(".blockReply" + hipId).show();
                    $(".blockReply" + hipId).prevAll("button").show();

                    blockEvent(type);
                }
            }
        });
    });
};

var blockCheck = function(type, hipId, from){
    tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/isBlock", JSON.stringify({type:type, hipId: hipId}), {async:false}, function (res) {
        var code = res.resultCode;
        var data = res.result;
        if(code === 0){
            if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                var isBlock = data.isBlock;
                if (isBlock) {
                    if( typeof(isBlockPofile) != 'undefined' ) {
                        isBlockPofile = "Y";
                    }
                    isBlockContents = "Y";
                } else {
                    if( typeof(isBlockPofile) != 'undefined' ) {
                        isBlockPofile = "N";
                    }
                    isBlockContents = "N";
                }
            }else {
                if( typeof(isBlockPofile) != 'undefined' ) {
                    isBlockPofile = "N";
                }
                isBlockContents = "N";
            }
        }
    });
};

var goProfileByBlock = function(writerHipId, type, reFunc, param, from){
    console.log("goProfileByBlock");
    var msgObj = {
        title: "차단된 멘토입니다."
        ,contents: "차단된 멘토의 프로필은 열람할 수 없으며<br>해제 후 확인 가능합니다.<br>해제하시겠습니까?"
        ,btnNm: "차단해제"
    };
    common.openConfirmPopupNew(msgObj, function(){
        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/unblock", JSON.stringify({type:type, hipId: writerHipId}), {async:false}, function (res) {
            var code = res.resultCode;
            if(code === 0){
                if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                    showToast("차단이 해제 되었습니다.");
                }

                if (from == 'colum'){
                    reFunc(param.replyHipid, param.statusCd, param.replyMentorYn);
                }else if(from == 'vote'){
                    reFunc(param.obj, param.statusCd, param.replyMentorYn);
                }else if(from == 'rank'){
                    moveProfile(param.mentorHipId);
                }else if(from == 'opentalk' || from == 'question'){
                    reFunc(param.writerHipId, param.writerMentorYn);
                }else if(from == 'opentalkReply' || from == 'questionReply'){
                    reFunc(param.obj, param.statusCd, param.replyMentorYn);
                }else if(from == 'opentalkDetail' || from == 'questionDetail'){
                    reFunc(param.writerMentorYn, param.writerHipId);
                }else if(from == 'opentalkDetailReply' || from == 'questionDetailReply'){
                    reFunc(param.obj, param.statusCd, param.replyMentorYn);
                }else if(from == 'special'){
                    reFunc(param.isPurchase, param.mentorHipId, param.productNo);
                }else {
                    reFunc();
                }
            }
        });
    });
}

var moveProfile = function(mentorHipId){
    if(mentorHipId == userHipId){ // 본인 프로필 열람 가능하게 처리
        if(common.getDeviceType() == 'A'){
            window.EduLinker.mentorProfile(mentorHipId);
        }else if(common.getDeviceType() == 'I'){
            webkit.messageHandlers.edulinker.postMessage("edulinker://mentor_profile?hipID="+mentorHipId);
        }
    }else{
        if(userMentorYn == 'Y'){
            $("#alertPopArea").html("");
            common.openAlertPopup({message:'회원 유형이 같은 경우<br>프로필 열람이 불가합니다.', popupClass:'popup_point_charge_complete'});
        }else{
            if(common.getDeviceType() == 'A'){
                window.EduLinker.mentorProfile(mentorHipId);
            }else if(common.getDeviceType() == 'I'){
                webkit.messageHandlers.edulinker.postMessage("edulinker://mentor_profile?hipID="+mentorHipId);
            }
        }
    }
}

var goContentsByBlock = function(writerHipId, type, reFunc){
    //마이톡에서만 사용됨.
    var msgObj = {
        title: "차단된 작성글입니다."
        ,contents: "차단한 사용자가 작성한 글은 열람할 수 없으며,<br>차단 해제시 확인 가능합니다.<br>해제하시겠습니까?"
        ,btnNm: "차단해제"
    };
    common.openConfirmPopupNew(msgObj, function(){
        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/unblock", JSON.stringify({type:type, hipId: writerHipId}), {async:false}, function (res) {
            var code = res.resultCode;
            if(code === 0){
                if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                    showToast("차단이 해제 되었습니다.");
                }
                if (typeof reFunc == 'function') {
                    reFunc();
                }

                blockEvent(type);
            }
        });
    });
}


var closeWeb = function(){
    if(common.getDeviceType() == "I") {
        webkit.messageHandlers.callbackHandler.postMessage("closeWeb");
    } else if(common.getDeviceType() == "A") {
        window.EduLinker.closeWeb();
    }
}

var showToast = function(text){
    if(common.getDeviceType() == "I"  && common.compareVersion("1.4.1", currentVer) == true) {
        window.webkit.messageHandlers.jsonCallbackHandler.postMessage(JSON.stringify({action: 'showToast', message: text}));
    } else if(common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) {
        window.EduLinker.showToast(text);
    }
}

var blockEvent = function(type){
    if(common.getDeviceType() == "I"  && common.compareVersion("1.4.1", currentVer) == true) {
        window.webkit.messageHandlers.jsonCallbackHandler.postMessage(JSON.stringify({action: 'blockEvent'}));
    } else if(common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) {
        window.EduLinker.blockEvent(type);
    }
}

var doUnblockColum = function(type, hipId, no){
    var msgObj = {
        title: "차단된 작성글입니다."
        ,contents: "차단한 사용자가 작성한 글은 열람할 수 없으며,<br>차단 해제시 확인 가능합니다.<br>해제하시겠습니까?"
        ,btnNm: "차단해제"
    };

    common.openConfirmPopupNew(msgObj, function(){
        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/unblock", JSON.stringify({type:"contents|reply", hipId: hipId, targetId: no}), null, function (res) {
            var code = res.resultCode;
            if(code === 0){
                if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                    showToast("차단이 해제 되었습니다.");

                    $(".blockContentsImg" + hipId).hide();
                    $(".blockContentsText" + hipId).show();
                    $(".blockReplyImg" + hipId).hide();
                    $(".blockReply" + hipId).show();

                    blockEvent(type);
                }
            }
        });
    }, function (){
        closeWeb();
    });
}

var getConnectChatBefore = function(hipId, mentorYn){
    tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/isBlock", JSON.stringify({type:"profile", hipId: hipId}), {async:false}, function (res) {
        var code = res.resultCode;
        var data = res.result;
        isBlockPofile = 'Y';
        if(code === 0){
            var isBlock = data.isBlock;
            if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                if(isBlock){
                    var msgObj = {
                        title: "차단된 멘토입니다."
                        ,contents: "차단된 멘토의 프로필은 열람할 수 없으며<br>해제 후 확인 가능합니다.<br>해제하시겠습니까?"
                        ,btnNm: "차단해제"
                    };

                    common.openConfirmPopupNew(msgObj, function () {
                        tms.ajaxPostHelper(properties.apiHost() + "/consult/svc/unblock", JSON.stringify({type: "profile", hipId: hipId}), {async: false}, function (res) {
                            var code = res.resultCode;
                            if(code === 0){
                                if ((common.getDeviceType() == "A" && common.compareVersion("1.4.0", currentVer) == true) || (common.getDeviceType() == "I" && common.compareVersion("1.4.1", currentVer) == true)) {
                                    showToast("차단이 해제 되었습니다.");
                                }
                                getConnectChat(hipId, mentorYn);
                            }
                        });
                    });
                }else{
                    isBlockPofile = 'N';
                }
            }else{
                isBlockPofile = 'N';
            }
        }
    });
}

function makeBlockBtnReply(hipId, talkNo, replyNo, from){
    var blockBtn = '<span class="blockContentsSpan">';
    blockBtn += '<div class="blockContents">';
    blockBtn += '<div class="drop_bar" id="reply'+hipId+'"><img class="moreBlock" src="'+contextPath+'/apps/images/ic_more.png"></div>';
    blockBtn += '<div style="display: none;" class="drop_content">';
    blockBtn += '<a href="javascript:void(0);" onClick="moveReportReply(\''+hipId+'\','+talkNo+', '+replyNo+');">신고하기</a>';
    if (from == 'columReply'){
        blockBtn += '<a style="display: none;" class="block" onclick="block(this, \'reply\', \''+hipId+'\', '+replyNo+', \'columReply\')">차단하기</a>';
    }else{
        blockBtn += '<a style="display: none;" class="block" onclick="block(this, \'reply\', \''+hipId+'\', '+replyNo+', \'reply\')">차단하기</a>';
    }
    blockBtn += '<a style="display: none;" class="unBlock" onclick="unBlock(this, \'reply\', \''+hipId+'\', '+replyNo+')">차단해제</a>';
    blockBtn += '</div></div></span>';
    return blockBtn;
}

function makeBlockBtnArea(){
    var blockBtn = '<span class="blockContentsSpan">';
    blockBtn += '<div class="blockContents">';
    blockBtn += '</div></span>';
    return blockBtn;
}

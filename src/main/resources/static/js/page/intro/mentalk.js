var path = "/page/index";         // Path
var ongoingNo = 1;      // 진행중인 칼럼의 현재 페이지
var scheduledNo = 1;    // 예정된 칼럼의 현재 페이지
var finishedNo = 1;     // 완료된 칼럼의 현재 페이지
var limit = 30;          // 한 페이지당 보여줄 페이지 수 (칼럼 리스트)
var page = 0;           // 멘토 리스트의 현재 페이지
var tabIdx = 1;         // App 현재 slick 페이지

// 검색 옵션
var param = {
    admissionType : [],
    hasSchoolRecord : false,
    hasSelfReport : false,
    lessonAreaCdList : [],
    nickNm : '',
    departmentLineCdList : []
};

$(function() {
    path = $(location).attr('pathname');
    // GNB Setting (Web)
    if((path.indexOf(contextPath + "/page") !== -1 || path === contextPath + "/") || path === contextPath + "/page/index"){
        //if(path === contextPath + "/page/index"){
        list();
        $(".mo_header .title").text("멘토칼럼");

        if(path.indexOf(contextPath + "/page/intro/mentoring") !== -1){
            //$(window).unbind().bind("scroll", function(){
            $(window).bind("scroll", function(){
                var $this = $(this);
                if($this.scrollTop() + $this.height() + 66 > $(document).height()){
                    page+=32;
                    getMentorList(page, "MENTORING", "#mentoringList");
                }
            });
            $(".mo_header .title").text("멘토링");
        }else if(path.indexOf(contextPath + "/page/intro/lesson") !== -1){
            //$(window).unbind().bind("scroll", function(){
            $(window).bind("scroll", function(){
                var $this = $(this);
                if($this.scrollTop() + $this.height() + 66 > $(document).height()){
                    page+=32;
                    getMentorList(page, "LESSON", "#lessonList");
                }
            });
            $(".mo_header .title").text("과외");
        }

    }

    $(document).on("click", ".rwd_popup_mentoring.open", function(e) {
        if($(e.target).hasClass("rwd_popup_mentoring")){
            Layer_CLOSE(".rwd_popup_mentoring");
        }
    });

    //멘토칼럼 검색 라디오 버튼 클릭 이벤트
    $(document).on("click", "input[name='admissionTypeCd'], input[name='universityPartyNo'], input[name='mentalkCategoryNo']", function(e) {
        $(".btn_show").removeClass("on");

        var searchNm = $(this).closest("label").find("span").text();

        var admissionTypeCd = $("input[name='admissionTypeCd']:checked").val();
        var universityPartyNo = $("input[name='universityPartyNo']:checked").val();
        var mentalkCategoryNo = $("input[name='mentalkCategoryNo']:checked").val();

        var radioBtnName = $(this).attr("name");
        var idx = $(".rwd_selectbox .btn_select.on").data("idx");
        $(".item_area .selected").each(function() {
            var tab = $(this).data("tab");
            if(idx == tab) {
                if(radioBtnName == "admissionTypeCd" || radioBtnName == "universityPartyNo") {
                    if(tms.isEmpty(admissionTypeCd) && tms.isEmpty(universityPartyNo)) {
                        $(this).find(".txt").show();
                        $(this).find("[data-cd='AD']").hide();
                        $(this).find("[data-cd='UN']").hide();
                    } else {
                        $(this).find(".txt").hide();
                        if(radioBtnName == "admissionTypeCd") {
                            if(tms.isEmpty(admissionTypeCd)) {
                                $(this).find("[data-cd='AD']").hide();
                            } else {
                                $(this).find("[data-cd='AD']").show();
                                $(this).find("[data-cd='AD'] span").text(searchNm);
                            }
                        }

                        if(radioBtnName == "universityPartyNo") {
                            if(tms.isEmpty(universityPartyNo)) {
                                $(this).find("[data-cd='UN']").hide();
                            } else {
                                $(this).find("[data-cd='UN']").show();
                                $(this).find("[data-cd='UN'] span").text(searchNm);
                            }
                        }
                    }
                } else if(radioBtnName == "mentalkCategoryNo") {
                    if(tms.isEmpty(mentalkCategoryNo)) {
                        $(this).find(".txt").show();
                        $(this).find("[data-cd='CA']").hide();
                    } else {
                        $(this).find(".txt").hide();
                        $(this).find("[data-cd='CA']").show();
                        $(this).find("[data-cd='CA'] span").text(searchNm);
                    }

                    //멘토칼럼 목록 검색
                    $(".rwd_dropdown").removeClass("open");
                    mentalkSearchChannel();

                }
                $(this).show();
            } else {
                $(this).hide();
            }
        });


    });

    //멘토칼럼 검색 전체초기화
    $(document).on("click", "#btnMentalkInit", function() {
        $("input:radio[name='admissionTypeCd']").prop("checked", false);
        $("input:radio[name='universityPartyNo']").prop("checked", false);

        $(".item_area").find("[data-cd='AD'] span").text("");
        $(".item_area").find("[data-cd='UN'] span").text("");

        $(".item_area").find("[data-cd='AD']").hide();
        $(".item_area").find("[data-cd='UN']").hide();
        $(".item_area").find("[data-tab='1'] .txt").show();

        //멘토칼럼 목록 검색
        $(".rwd_dropdown").removeClass("open");
        mentalkSearchChannel();

    });

    //멘토칼럼 검색 적용하기
    $(document).on("click", "#btnMentalkApply", function() {
        //멘토칼럼 목록 검색
        $(".rwd_dropdown").removeClass("open");
        mentalkSearchChannel();

    });

    //멘토칼럼 검색 탭 클릭 이벤트
    $(document).on("click", ".rwd_selectbox .btn_select", function() {
        checkHeight();
        var idx = $(this).data("idx");
        $(".rwd_selectbox .btn_select").each(function() {
            $(this).removeClass("on");
        });
        $(this).addClass("on");

        $(".rwd_dropdown [data-tab]").each(function() {
            var tab = $(this).data("tab");
            if(idx == tab) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
        if(idx == 0) {
            $("input:radio[name='admissionTypeCd']").prop("checked", false);
            $("input:radio[name='universityPartyNo']").prop("checked", false);
            $("input:radio[name='mentalkCategoryNo']").prop("checked", false);

            $(".item_area").find("[data-cd='AD'] span").text("");
            $(".item_area").find("[data-cd='UN'] span").text("");
            $(".item_area").find("[data-cd='CA'] span").text("");

            $(".item_area").find("[data-cd='AD']").hide();
            $(".item_area").find("[data-cd='UN']").hide();
            $(".item_area").find("[data-cd='CA']").hide();
            $(".item_area").find(".txt").show();

            $(".rwd_dropdown").removeClass("open");
        } else {
            $(".rwd_dropdown").addClass("open");
        }

        //선택한 데이터 영역 컨트롤
        $(".item_area .selected").each(function() {
            var tab = $(this).data("tab");
            if(idx == tab) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        //멘토칼럼 목록 검색
        mentalkSearchChannel();
    });
});

var mentalkSearchChannel = function() {
    $("#ongoingList").empty();
    ongoingNo = 1;
    searchChannel(ongoingNo, limit, "#ongoingList");
}

var buy = function(){
    $("#alertPopArea").html("");
    common.openAlertPopup({message: "회원가입을 하셔야 이용할 수 있습니다.<br>하단에 멘토/멘티 회원가입 버튼을 클릭해 주세요", popupClass :"popup_point_charge_complete"});
}

var channelSearchCondition = function () {
    consultApi.channelSearchCondition(null, function(res) {
        if(res.resultCode == 0) {
            var mentalkAdmissionList = res.result.mentalkAdmissionList;
            if(mentalkAdmissionList != null && mentalkAdmissionList.length > 0) {
                $("#mentalkAdmissionListTmpl").tmpl(mentalkAdmissionList).appendTo("#admissionTypeList");
            }

            var mentalkUniversityList = res.result.mentalkUniversityList;
            if(mentalkUniversityList != null && mentalkUniversityList.length > 0) {
                $("#mentalkUniversityListTmpl").tmpl(mentalkUniversityList).appendTo("#universityPartyList");
            }

            var mentalkCategoryList = res.result.mentalkCategoryList;
            if(mentalkCategoryList != null && mentalkCategoryList.length > 0) {
                $("#mentalkCategoryListTmpl").tmpl(mentalkCategoryList).appendTo("#mentalkCategoryList");
            }

            if(path.indexOf(contextPath + "/app") < 0) {
                // 진행된 칼럼
                $(".rwd_selectbox .btn_select.on").trigger("click");
            }
        }
    });
}

var list = function(){
    /*칼럼 리스트 호출*/
    if(path === contextPath +"/" || path.indexOf(contextPath + "/app") !== -1){
    //if(path === contextPath +"/page/index" || path.indexOf(contextPath + "/app") !== -1){
        //채널 학교 및 테마 목록 조회
        channelSearchCondition();

        // 진행된 칼럼
        //$("#ongoingList").empty();
        //getChannelList(2, ongoingNo, limit, "#ongoingList");
        //searchChannel(ongoingNo, limit, "#ongoingList");
        /*$("#ongoingMore").unbind().bind("click", function(){
            getChannelList(2, ++ongoingNo, limit, "#ongoingList");
        });*/

        /*// 예정된 칼럼
        $("#scheduledList").empty();
        getChannelList(1, scheduledNo, limit, "#scheduledList");
        $("#scheduledMore").unbind().bind("click", function(){
            getChannelList(1, ++scheduledNo, limit, "#scheduledList");
        });

        // 종료된 칼럼
        $("#finishedList").empty();
        getChannelList(3, finishedNo, limit, "#finishedList");//종료
        $("#finishedMore").unbind().bind("click", function(){
            getChannelList(1, ++finishedNo, limit, "#finishedList");
        });*/
    }
    /*멘토 리스트 (멘토링)*/
    if(path.indexOf(contextPath + "/page/intro/mentoring") !== -1 && path.indexOf(contextPath + "/app") == -1){
        $("#mentoringList").empty();
        getMentorList(page, "MENTORING", "#mentoringList");
    }
    /*멘토 리스트 (과외)*/
    if(path.indexOf(contextPath + "/page/intro/lesson") !== -1 && path.indexOf(contextPath + "/app") == -1){
        $("#lessonList").empty();
        getMentorList(page, "LESSON", "#lessonList");
    }
}

// 칼럼 리스트 Function
var getChannelList = function(period, page, limit, obj) {
    consultApi.getChannelList({category:"1", period:period, feedback:1, page:page, limit:limit}, {async:false}, function(code, data, res) {
        if (code === 0) {
            var channelList = data.map(function (obj) {
                obj.startDate = common.dateFormat(obj.startDate, 'MM.DD');
                obj.endDate = common.dateFormat(obj.endDate, 'MM.DD');
                return obj;
            });

            // 존재하지 않으면 Section 삭제
            if(page === 1 && channelList.length < 1){
                $(obj).closest("section").hide();
            }

            // 더보기 숨기기
            if(channelList.length < limit) {
                $(obj).parent(".list").next().hide();
            }

            $("#mentalkListTmpl").tmpl(channelList).appendTo(obj);

            // QnA 활성화
            $(obj).find(".mentalkList").unbind().bind("click", function(){
                var title = $(this).children(".tit").text();
                $(".rwd_popup_phone").addClass("open").find("p.name").text(title);
                getChannelQna($(this).data("no"), title, $(this).find(".photo img").attr("src"));
            });
        }
    });
}

var searchChannel = function(page, limit, obj) {
    var admissionTypeCd;
    var universityPartyNo;
    var mentalkCategoryNo;
    var idx = $(".rwd_selectbox .btn_select.on").data("idx");
    if(idx == 1) {
        admissionTypeCd = $("input[name='admissionTypeCd']:checked").val();
        universityPartyNo = $("input[name='universityPartyNo']:checked").val();
    } else if(idx == 2) {
        mentalkCategoryNo = $("input[name='mentalkCategoryNo']:checked").val();
    }
    
    var params = {
    	page:page
        , limit:limit
        , universityPartyNoList: universityPartyNo
        , admissionTypeCdList: admissionTypeCd
        , mentalkCategoryNoList: mentalkCategoryNo
    };
    
    consultApi.searchOpentalk(params, function(res) {
        var code = res.resultCode;
        var data = res.result.mentalkColumnList;
        // console.log(data);

        if (code === 0) {
            if(data != null && data.length > 0) {
                $("#mentalkListTmpl2").tmpl(data).appendTo(obj);
                mentalkNextPage = true;
                ongoingNo++;

                // 멘토칼럼 상세
                $(obj).find(".mentalkList").unbind().bind("click", function(){
                	var talkNo = $(this).data("no");
                	getMentalkDetail(talkNo, $(this));
                });

                if(path.indexOf("/app/intro/list") !== -1){
                    //var lst_height = Number(tms.isNotEmpty($("div.list_mentoring").css("height")) ? $("div.list_mentoring").css("height").split("px")[0] : 0);
                    var lst_height = $("#ongoingList").height() + 180;
                    $(".slider_list > div.slick-list").css("height", lst_height + "px");
                }
            } else {
                mentalkNextPage = false;
                if(page == 1) {
                    $("#searchNoDataTmpl").tmpl().appendTo(obj);
                }
            }
        } else {
            mentalkNextPage = false;
            if(page == 1) {
                $("#searchNoDataTmpl").tmpl().appendTo(obj);
            }
        }
    });
}

// 칼럼 상세 보기(0225 추가)
var getMentalkDetail = function(talkNo, $this) {
	$(".rwd_popup_phone .cont").html("");
    consultApi.getMentalkDetail({talkNo:talkNo}, function(code, data, res){
    	if(code === 0){
    		var list = data[0];
    		
            $("#mentalkDetailPopupTmpl").tmpl(list).appendTo(".rwd_popup_phone .cont");
            $(".rwd_popup_phone").addClass("open");
            $(".rwd_popup_phone").show();

            $(".propose").on("click", function(){
            	Layer_OPEN(".popup_app");
            });
            addViewCnt(hipId, talkNo, $this);
    	}
    });
}

// 조회수 증가 : 본인이 아닌 경우에만 조회 수 증가 처리
var addViewCnt = function(userHipId, talkNo, $this) {
    var compareHipId = $(".mentalk_profile .nickname").data("no");
    if(compareHipId != userHipId){
        $.ajax({
            type : 'GET',
            url : contextPath + '/app/column/add/' + talkNo,
            data : {'talkNo' : talkNo},
            success : function(res){
                console.log('addViewCnt success');
                $this.find(".mentalkStatus .count").text(res);
            },error: function(){
                console.log('addViewCnt fail');
            }
        });
    }
};

// 칼럼 QnA Function
var getChannelQna = function(channel, title, profileResourceUri) {
    $(".rwd_popup_phone .cont").html("");
    consultApi.getQnaList({channelNo: channel}, null, function(code, data, res) {
        if(code === 0){
            var idx = 1;
            var qnaList = data.map(function(obj){
                obj.no = idx++;
                obj.createDate = common.dateUnixFormat(obj.createDate, "hh:mm A");
                obj.profileResourceUri = profileResourceUri;
                return obj;
            });
            $(".rwd_popup_phone").show();
            $("#mentalkQnaPopupTmpl").tmpl(qnaList).appendTo(".rwd_popup_phone .cont");

            var viewParams = {
                channelNo: channel
            };
            //멘토칼럼 View 카운트 증가
            consultApi.viewChannel(viewParams, null, function(code, res) {
                if(code == 0) {
                }
            });
        }
    });
}

// 멘토 리스트 Function (Mentoring, Lession)
var getMentorList = function(page, listType, obj, option){
    if(tms.isNotEmpty(option)) {
        // 전역변수 설정
        param.admissionType = tms.isNotEmpty(option.admissionType) ? option.admissionType : [];
        param.hasSchoolRecord = tms.isNotEmpty(option.hasSchoolRecord);
        param.hasSelfReport = tms.isNotEmpty(option.hasSelfReport);
        param.lessonAreaCdList = tms.isNotEmpty(option.lessonAreaCdList) ? option.lessonAreaCdList : [];
        param.nickname = tms.isNotEmpty(option.nickname) ? option.nickname : '';
        param.departmentLineCdList = tms.isNotEmpty(option.departmentLineCdList) ? option.departmentLineCdList : [];
        param.lessonDayCdList = tms.isNotEmpty(option.lessonDayCdList) ? option.lessonDayCdList : [];
        param.subjectNoList = tms.isNotEmpty(option.subjectNoList) ? option.subjectNoList : [];
        param.universityPartyNoList = tms.isNotEmpty(option.universityPartyNoList) ? option.universityPartyNoList : [];
    }

    var params = {
        start:page,
        listTypeCd:listType,
        admissionTypeCdList: param.admissionType,
        hasSchoolRecord: param.hasSchoolRecord,
        hasSelfReport: param.hasSelfReport,
        lessonAreaCdList: param.lessonAreaCdList,
        nickname: param.nickname,
        departmentLineCdList: param.departmentLineCdList,
        lessonDayCdList: param.lessonDayCdList,
        subjectNoList: param.subjectNoList,
        universityPartyNoList: param.universityPartyNoList
    };

    consultApi.retrieveMentorList(params, {async:false},function(code, data, res){
        if(code === 0){
            if(tms.isEmpty(data) || data.mentorList.length < 1) {
                if(page == 0) {
                    if(params.listTypeCd == "MENTORING") {
                        $("#searchNoDataTmpl").tmpl().appendTo("#mentoringList");
                    } else if(params.listTypeCd == "LESSON") {
                        $("#searchNoDataTmpl").tmpl().appendTo("#lessonList");
                    }
                }
                //$(window).unbind();
                return;
            }

            var mentorList = data.mentorList.map(function(obj){
                obj.listType = listType;
                // 프로필 사진 에러 처리
                var resourceUri = obj.resourceUri;

                if(resourceUri && resourceUri.startsWith('/profile')){
                	obj.resourceUri = "https://d3520qxzbk1an7.cloudfront.net" + resourceUri;
                }else if(typeof resourceUri == "undefined" || tms.isEmpty(resourceUri)) {
                    obj.resourceUri = "https://d3520qxzbk1an7.cloudfront.net/profile/defaultImg.png";
                }

                obj.deviceType = common.getDeviceType();
                obj.headerDeviceType = headerDeviceType;
                return obj;
            });
            
            $("#mentorListTmpl").tmpl(mentorList).appendTo(obj);
            $(".rwd_popup_mentoring").show();

            $(".mentorList").unbind().bind("click", function(){
                $(".rwd_popup_mentoring").addClass("open");
                var hipId = $(this).data("no");
                getMentorProfile(hipId, listType);
                getMentorInfo(hipId);
            });
            
            if(path.indexOf(contextPath + "/app") !== -1 && listType === "MENTORING"){
                var lst_height = Number(tms.isNotEmpty($("div.list_mentoring").css("height")) ? $("div.list_mentoring").css("height").split("px")[0] : 0);
                $(".slider_list > div.slick-list").css("height", lst_height + 30 + "px");
            }else if(path.indexOf(contextPath +  "/app") !== -1 && listType === "LESSON"){
                var lst_height = Number(tms.isNotEmpty($("div.list_lesson").css("height")) ? $("div.list_lesson").css("height").split("px")[0] : 0);
                $(".slider_list > div.slick-list").css("height", lst_height + 30 + "px");
            }

            if(tms.isNotEmpty(headerDeviceType) && common.getDeviceType() != "P") {
                $(".mentorList .lazyload").lazyload();
            }
        }
    });
}

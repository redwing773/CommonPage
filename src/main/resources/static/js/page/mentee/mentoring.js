var path = "/";         // Path
var ongoingNo = 1;      // 진행중인 칼럼의 현재 페이지
var limit = 30;          // 한 페이지당 보여줄 페이지 수 (칼럼 리스트)
var currentPage = 0;           // 멘토 리스트의 현재 페이지
var mentoringNextPage = true;
var lessonNextPage = true;
var SEARCH_TYPE = "";

// 검색 옵션
var searchParam = {
    mentoringCdList : [],
    menteeCdList : [],
    lessonAreaCdList: [],
    subjectCdList : [],
    nickNm : ''
};

$(function() {
    var footerHeight = $("#rwd_footer").height() + 150;
    path = $(location).attr('pathname');
    if(path.indexOf(contextPath + "/page/mentee/mentoring") !== -1){
        SEARCH_TYPE = "MENTORING";
        getMenteeList(0, SEARCH_TYPE, "#mentoringList");
        //$(window).unbind().bind("scroll", function(){
        $(window).bind("scroll", function(){
            var $this = $(this);
            if (mentoringNextPage && $this.scrollTop() + footerHeight >= $(document).height() - $this.height()) {
                currentPage += 32;
                mentoringNextPage = false;
                getMenteeList(currentPage, "MENTORING", "#mentoringList");
            }
        });
        $(".mo_header .title").text("멘토링");
    }else if(path.indexOf(contextPath + "/page/mentee/lesson") !== -1){
        SEARCH_TYPE = "LESSON";
        getMenteeList(0, SEARCH_TYPE, "#lessonList");
        //$(window).unbind().bind("scroll", function(){
        $(window).bind("scroll", function(){
            var $this = $(this);
            if (lessonNextPage && $this.scrollTop() + footerHeight >= $(document).height() - $this.height()) {
                currentPage += 32;
                lessonNextPage = false;
                getMenteeList(currentPage, "LESSON", "#lessonList");
            }
        });
        $(".mo_header .title").text("과외");
    }


    $(document).on("click", ".rwd_popup_mentoring.open", function(e) {
        if($(e.target).hasClass("rwd_popup_mentoring")){
            Layer_CLOSE(".rwd_popup_mentoring");
        }
    });

});

// 멘토 리스트 Function (Mentoring, Lession)
var getMenteeList = function(paramPage, listType, obj, option){
    if(tms.isNotEmpty(option)) {
        // 전역변수 설정
        /*param.admissionType = tms.isNotEmpty(option.admissionType) ? option.admissionType : [];
        param.hasSchoolRecord = tms.isNotEmpty(option.hasSchoolRecord);
        param.hasSelfReport = tms.isNotEmpty(option.hasSelfReport);
        param.lessonAreaCdList = tms.isNotEmpty(option.lessonAreaCdList) ? option.lessonAreaCdList : [];
        param.nickname = tms.isNotEmpty(option.nickname) ? option.nickname : '';
        param.departmentLineCdList = tms.isNotEmpty(option.departmentLineCdList) ? option.departmentLineCdList : [];
        param.lessonDayCdList = tms.isNotEmpty(option.lessonDayCdList) ? option.lessonDayCdList : [];
        param.subjectNoList = tms.isNotEmpty(option.subjectNoList) ? option.subjectNoList : [];
        param.universityPartyNoList = tms.isNotEmpty(option.universityPartyNoList) ? option.universityPartyNoList : [];*/
    }

    var params = {
        start:paramPage,
        listTypeCd:listType,
        subjectCdList: searchParam.subjectCdList,
        mentoringCdList: searchParam.mentoringCdList,
        menteeCdList: searchParam.menteeCdList,
        lessonAreaCdList: searchParam.lessonAreaCdList,
        nickname: searchParam.nickname
    };

    if(paramPage == 0) {
        $(obj).html("");
    }

    consultApi.retrieveMenteeList(params, null, function(code, data, res){
        if(code === 0){
            if(tms.isEmpty(data) || data.menteeList.length < 1) {
                if(currentPage == 0) {
                    if(params.listTypeCd == "MENTORING") {
                        $("#searchNoDataTmpl").tmpl().appendTo("#mentoringList");
                    } else if(params.listTypeCd == "LESSON") {
                        $("#searchNoDataTmpl").tmpl().appendTo("#lessonList");
                    }
                }
                //$(window).unbind();
                return;
            }

            var menteeList = data.menteeList.map(function(obj){
                obj.listType = listType;
                var schoolAddress = obj.schoolAddress;
                if(tms.isNotEmpty(schoolAddress)) {
                    var addressArray = schoolAddress.split(" ");
                    if(addressArray != null && addressArray.length > 1) {
                        obj.schoolAddress = addressArray[0] + " " + addressArray[1];
                    }
                }
                return obj;
            });

            $("#mentorListTmpl").tmpl(menteeList).appendTo(obj);

            if(listType == "MENTORING") {
                mentoringNextPage = true;
            } else if(listType == "LESSON") {
                lessonNextPage = true;
            }

            //프로필 상세 팝업
            $(".rwd_popup_mentoring").show();
            $(".mentorList").unbind().bind("click", function(){
                $(".mentee_profile").addClass("open");
                var hipId = $(this).data("no");
                retrieveMenteeProfile(hipId, listType);
                getMenteeInfo(hipId);
            });

        }
    });
}

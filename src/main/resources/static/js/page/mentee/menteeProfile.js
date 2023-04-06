// getMentorProfile의 tabIdx를 위한 변수 선언 200805
var tabIdx = 1;

// 멘토 프로필 조회 Function
var retrieveMenteeProfile = function(hipId, listType){
    $(".mentee_profile .profile_area").html("");
    myPageApi.retrieveMenteeProfile({menteeHipId:hipId, viewTypeCd:listType}, {async:false}, function(code, data, res){
       if(code === 0){
           var profileInfo = data.menteeProfile;
           //profileInfo.listType = listType;
           //$(".rwd_popup_mentoring .profile_area").empty();

           var schoolAddress = profileInfo.schoolAddress;
            if(tms.isNotEmpty(schoolAddress)) {
                var addressArray = schoolAddress.split(" ");
                if(addressArray != null && addressArray.length > 1) {
                    profileInfo.schoolAddress = addressArray[0] + " " + addressArray[1]
                }
            }

           $("#menteePopupProfileTmpl").tmpl(profileInfo).appendTo(".mentee_profile .profile_area");

       }
    });
}


// 원하는 멘토링 및 필요학습과목
var getMenteeInfo = function(hipId){
    $("#consultingList").html("");
    $("#subjecetList").html("");
    codeApi.getRetrieveCd({categoryNo: "2, 3", parentNo: "0"}, function (codeCd, dataCd) {
        if(codeCd == 0) {
            myPageApi.retrieveMenteeInformation({menteeHipId: hipId}, function (code, data) {
                var mentoringList = data.menteeConsultingList;
                var lessonList = data.menteeSubjectList;

                var consultArray = [];
                var subjectArray = [];
                for(var i in mentoringList) {
                    var codeList = dataCd.filter(function(codeObj) {
                        return codeObj.categoryNo == 3 && codeObj.codeNo == mentoringList[i];
                    });
                    consultArray.push(codeList[0]);
                }

                for(var i in lessonList) {
                    var codeList = dataCd.filter(function(codeObj) {
                        return codeObj.categoryNo == 2 && codeObj.codeNo == lessonList[i];
                    });
                    subjectArray.push(codeList[0]);
                }

                //원하는 멘토링
                $("#consultSubjectListTmpl").tmpl(consultArray).appendTo("#consultingList");
                //필요학습 과목
                $("#consultSubjectListTmpl").tmpl(subjectArray).appendTo("#subjecetList");
            });
        }

    });
}
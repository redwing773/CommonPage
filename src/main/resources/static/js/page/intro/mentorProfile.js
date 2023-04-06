// getMentorProfile의 tabIdx를 위한 변수 선언 200805
var tabIdx = 1;

// 멘토 프로필 조회 Function
var getMentorProfile = function(hipId, listType){
    consultApi.retrieveMentorProfile({mentorHipId:hipId, viewTypeCd:listType}, {async:false}, function(code, data, res){
       if(code === 0){
           var profileInfo = data.mentorProfile;
           profileInfo.listType = listType;
           $(".rwd_popup_mentoring .profile_area").empty();
           
           if ($(".connectChatOnToday").length) {
        	   if (profileInfo.enabledMentoring) {
        		   $(".connectChatOnToday").removeClass('disabled');
        		   $(".connectChatOnToday").addClass('active');
        		   $(".connectChatOnToday").attr('href', '#self');
			   }
           }
           if (typeof(mentorName) != 'undefined') {
        	   mentorName = profileInfo.nickname;
           }
           
           if (typeof(userToken) == 'undefined') {
        	   userToken = false;
           }
           
           //생기부 탭 맛보기 노출 여부
           if(profileInfo.srSamplingYn) {
               $(".buy_box .btn_buy .mat").show();
           } else {
               $(".buy_box .btn_buy .mat").hide();
           }
          
           //생기부 및 자소서 탭 노출 여부
           $(".rwd_popup_mentoring .btn_tab").removeClass("btnSize1 btnSize2 btnSize3 btnSize4");
           $(".rwd_popup_mentoring .btn_tab button").each(function() {
                $(this).show();
            });
           chkContentsSelfReport(profileInfo.contentsYn, profileInfo.selfReportYn, hipId, profileInfo.srSamplingYn);

           /* 팝업 열기 */
           $("#mentorPopupProfileTmpl").tmpl(profileInfo).appendTo(".rwd_popup_mentoring .profile_area");

           /* Idx 설정 */
           var idx = 0;
           if(tabIdx == 1) {
               listType = "MENTORING";
           } else if(tabIdx == 2) {
               listType = "LESSON";
           }
           if(listType === "MENTORING") {
               if(profileInfo.contentsYn) {
                   idx = 0;
               } else if(profileInfo.selfReportYn) {
                   idx = 1;
               } else {
                   idx = 2;
               }
           } else if(listType === "LESSON") {
               idx = 3;
           }

           //var idx = listType === "MENTORING" ? 1 : listType === "LESSON" ? 2 : 0;

       //    if(path.indexOf(contextPath + "/app") !== -1){
               //idx = tabIdx;
       //    }
           $(".rwd_popup_mentoring .btn_tab button").removeClass("on").eq(idx).addClass("on");
           $(".rwd_popup_mentoring .tab_cont .conts").removeClass("on").eq(idx).addClass("on");


           /* 팝업 탭 Click Event */
           $(".rwd_popup_mentoring").find(".btn_tab button").unbind().bind("click", function(){
               idx = $(this).index();
               $(".rwd_popup_mentoring .btn_tab button").removeClass("on").eq(idx).addClass("on");
               $(".rwd_popup_mentoring .tab_cont .conts").removeClass("on").eq(idx).addClass("on");
               $(".rwd_popup_mentoring .tab_cont").scrollTop(0);
           });
       }
    });
}

var chkContentsSelfReport = function(contentsYn, selfReportYn, paramHipId, paramSrSamplingYn) {
    if(contentsYn && selfReportYn) {
        //생기부, 자조소 모두 노출
        //생기부 노출
        if(common.userInfo.isLogin) {
            recordForMentorView(paramHipId, paramSrSamplingYn);
        } else {
        	if (userToken && userHipId) {
        		recordForMentorView(paramHipId, paramSrSamplingYn);
        	}else{
	            $(".rwd_popup_mentoring .tab_cont .profile_record .table_box a").unbind().bind("click", function(){
	                Layer_OPEN('.popup_app');
	            });
        	}
        }
    } else if(!contentsYn && !selfReportYn) {
        //생기부, 자소서 모두 미노출
        $(".rwd_popup_mentoring .btn_tab button").each(function() {
            var value = $(this).data("value");
            if(value == "contentsYn" || value == "selfReportYn") {
                $(this).hide();
            }
            $(this).parents(".btn_tab").addClass("btnSize2");
        });
    } else if(!contentsYn) {
        //생기부 미노출
        $(".rwd_popup_mentoring .btn_tab button").each(function() {
            var value = $(this).data("value");
            if(value == "contentsYn") {
                $(this).hide();
            }
            $(this).parents(".btn_tab").addClass("btnSize3");
        });
    } else if(!selfReportYn) {
        //자소서 미노출
        $(".rwd_popup_mentoring .btn_tab button").each(function() {
            var value = $(this).data("value");
            if(value == "selfReportYn") {
                $(this).hide();
            }
            $(this).parents(".btn_tab").addClass("btnSize3");
        });
        //생기부 노출
        if(common.userInfo.isLogin) {
            recordForMentorView(paramHipId, paramSrSamplingYn);
        } else {
        	if (userToken && userHipId) {
        		recordForMentorView(paramHipId, paramSrSamplingYn);
			} else {
				$(".rwd_popup_mentoring .tab_cont .profile_record .table_box a").unbind().bind("click", function(){
					Layer_OPEN('.popup_app');
				});				
			}
        }
    } else {

    }
}

// 멘토 멘토링 & 과외내역 조회 Function
var getMentorInfo = function(hipId){
    codeApi.getRetrieveCd2({categoryNo:"2, 8, 16, 17"},  function(code, data, res){
        var comCode = data;
        consultApi.retrieveMentorMentoringForMentee({mentorHipId:hipId}, {async:false}, function(code, data, res){
            if(code === 0){
                var currently = data.currently;
                var admissionList = data.admissionList;

                var pAcceptance = [];       // 입시유형 부모 공통 코드

                // 멘토링 Mapping
                comCode.forEach(function(item){
                    if(item.categoryNo === 8){
                        pAcceptance.push(item);
                    }

                    if (currently.acceptanceTypeCd === item.codeNo) {
                        currently.acceptance = item.parentNo;
                        currently.acceptance2 = item.codeNm;
                    } else if (currently.departmentLineCd === item.codeNo) {
                        currently.departmentLine = item.codeNm;
                    }

                    if(admissionList.length > 0){
                        admissionList.map(function(admission){
                           if(admission.admissionTypeCd === item.codeNo){
                               admission.acceptance = item.parentNo;
                               admission.acceptance2 = item.codeNm;
                           }else if(admission.departmentLineCd === item.codeNo){
                               admission.departmentLine = item.codeNm;
                           }
                           return admission;
                       });
                    }
                });

                $(".rwd_popup_mentoring .cont_02 .list").empty();
                $(".rwd_popup_mentoring .cont_04 .intro_box").empty();

                pAcceptance.forEach(function(item){
                    if(currently.acceptance === item.codeNo){
                        currently.acceptance = item.codeNm;
                    }

                    if(admissionList.length > 0){
                        admissionList.map(function(admission){
                            if(admission.acceptance === item.codeNo){
                                admission.acceptance = item.codeNm;
                            }
                            return admission;
                        });
                    }
                });
                var currentlyItem = {
                    universityNm: currently.universityNm +" | "+ currently.studentId +"학번",
                    departmentLine: currently.departmentLine,
                    majorNm: currently.majorNm,
                    acceptance: currently.acceptance,
                    acceptance2: currently.acceptance2,
                    // 자소서
                    universityName: currently.universityNm,
                    admissionTypeCd: currently.admissionTypeCd
                };

                // 현재 학력
                $("#mentorPopupMentoringTmpl").tmpl(currentlyItem).appendTo(".rwd_popup_mentoring .cont_02 .list");

                // 자소서
                /*if(currentlyItem.admissionTypeCd === 175 || currentlyItem.admissionTypeCd === 176){
                    var universityName = currentlyItem.universityName.replace("학교", "");
                    var majorNm = currentlyItem.majorNm;
                    var acceptance = currentlyItem.acceptance === "학생부교과" ? "교과" : "학종";
                    $(".rwd_popup_mentoring .cont_04 .intro_box").append("<div class='intro'>"+ universityName +", "+ majorNm + ", "+ acceptance +"</div>");
                }*/

                admissionList.forEach(function(item){
                    $("#mentorPopupMentoringTmpl").tmpl(item).appendTo(".rwd_popup_mentoring .cont_02 .list");
                });

                //자기소개서 학교 목록 조회 로그인 체크
                if(common.userInfo.isLogin || (userToken && userHipId)) {
                    // 등록된 자소서 목록
                    var introParams = {
                        mentorHipId: hipId
                    };
                    recordApi.getMentorSelfReportList(introParams, function(code, data, res) {
                        if(code == 0) {
                            if(data != null) {
                                var list = data.selfReportList;
                                list.forEach(function(introItem){
                                    var universityNm = introItem.universityNm;
                                    var acceptance = introItem.admissionType;
                                    var majorNm = introItem.majorNm;
                                    var selfIntroNo = introItem.selfIntroNo;

                                    $(".rwd_popup_mentoring .cont_04 .intro_box").append("<div class='intro' style='cursor:pointer;' data-selfno='"+selfIntroNo+"'>"+ universityNm +", "+ majorNm + ", "+ acceptance +"</div>");
                                });

                                // 자소서
                                /*if($(".rwd_popup_mentoring .cont_04 .intro_box .intro").length > 0){
                                    $(".rwd_popup_mentoring .cont_04 .intro_box .intro").eq(0).addClass("on");
                                }*/

                                $(".rwd_popup_mentoring .cont_04 .intro_box .intro").unbind().bind("click", function(){
                                    $(".rwd_popup_mentoring .cont_04 .intro_box .intro").each(function() {
                                        $(this).removeClass("on");
                                    });
                                    $(this).addClass("on");

                                    getMentorSelfReport(hipId, $(this).data("selfno"));
                                });

                                $(".rwd_popup_mentoring .cont_04 .intro_box .intro").eq(0).trigger("click");
                            }


                        }

                    });
                } else {
                    // 등록된 자소서 목록
                    var introParams = {
                        hipId: hipId
                    };
                    tms.ajaxGetHelper(contextPath + "/api/selfIntro/intro/mentoring", introParams,  null, function(res){
                        if(res.code === 0){
                            var list = tms.isNotEmpty(res.data) ? res.data.admissionList : null;
                            if(list.length > 0){
                                list.forEach(function(introItem){
                                    var universityNm = introItem.universityNm.replace("학교", "");
                                    var admissionType = introItem.admissionType;
                                    var acceptance = admissionType === "학생부교과" ? "교과" : "학종";
                                    var majorNm = introItem.majorNm;

                                    $(".rwd_popup_mentoring .cont_04 .intro_box").append("<div class='intro' style='cursor:pointer;'>"+ universityNm +", "+ majorNm + ", "+ acceptance +"</div>");
                                });

                                // 자소서
                                if($(".rwd_popup_mentoring .cont_04 .intro_box .intro").length > 0){
                                    $(".rwd_popup_mentoring .cont_04 .intro_box .intro").eq(0).addClass("on");
                                }

                                $(".rwd_popup_mentoring .cont_04 .intro_box .intro").unbind().bind("click", function(){
                                    $(".rwd_popup_mentoring .cont_04 .intro_box .intro").each(function() {
                                        $(this).removeClass("on");
                                    });
                                    $(this).addClass("on");

                                    //getMentorSelfReport(hipId, 0);
                                });

                                $(".rwd_popup_mentoring .tab_cont .profile_selfintro .table_box a").unbind().bind("click", function(){
                                    Layer_OPEN('.popup_app');
                                });
                            }
                        }
                    });
                }
            }
        });

        consultApi.retrieveMentorLessonForMentee({mentorHipId:hipId}, {async:false}, function(code, data, res){
            if(code === 0){
                var pSubject = [];              // 과목 부모 공통 코드
                var subjectList = [];           // 과목
                var dayList = [];               // 요일
                var areaList = [];              // 지역

                $(".rwd_popup_mentoring .cont_03").empty();
                comCode.forEach(function(item){
                    if(item.categoryNo === 2 && item.parentNo === 0){
                        pSubject.push(item);
                    }

                    data.lessonDayList.forEach(function(lessonDay){
                        if(lessonDay === item.codeNo){
                            dayList.push(item);
                        }
                    });

                    data.lessonSubjectList.forEach(function(lessonSubject){
                        if(lessonSubject === item.codeNo){
                            subjectList.push(item);
                        }
                    });
                });

                data.lessonAreaList.forEach(function(item){
                    areaList.push(item.areaNm);
                });

                var lessonParam = {
                    costNm : tms.isNotEmpty(data.lessonInfo.costNm) ? data.lessonInfo.costNm : "",
                    timesNm : tms.isNotEmpty(data.lessonInfo.lessonTimesNm) ? data.lessonInfo.lessonTimesNm : "",
                    hoursNm : tms.isNotEmpty(data.lessonInfo.lessonHoursNm) ? data.lessonInfo.lessonHoursNm + " 1회" : "",
                    teachingStyle : tms.isNotEmpty(data.lessonInfo.teachingStyle) ? data.lessonInfo.teachingStyle : "",
                    areaList : areaList.toString()
                };
                $("#mentorPopupLessonTmpl").tmpl(lessonParam).appendTo(".rwd_popup_mentoring .cont_03");

                $(".rwd_popup_mentoring .cont_03 ul#subjecetList").empty();
                // 부모 과목 추출 및 중복 없애기
                var p = new Set();
                subjectList.forEach(function(item){
                    if(item.parentNo === 0){
                        p.add(item.codeNo);
                    }else{
                        p.add(item.parentNo);
                    }
                });

                // 과목 List 및 parent Element 생성
                p.forEach(function(item){
                    pSubject.forEach(function(subject){
                        if(item === subject.codeNo){
                            $(".rwd_popup_mentoring .cont_03 ul#subjecetList").append("<li data-no="+subject.codeNo+"><span>"+subject.codeNm+"</span><p class='txt_02'></p></li>")
                        }
                    });
                });

                // 과목 child 생성
                $(".rwd_popup_mentoring .cont_03 ul#subjecetList li").each(function(){
                    var no = $(this).data("no");
                    var sub = [];
                    subjectList.forEach(function(subject){
                        if(no === subject.parentNo){
                            sub.push(subject.codeNm);
                        }
                    });
                    if(sub.length > 0){
                        $(this).find("p").text(sub.toString());
                    }
                });

                // 요일 check 초기화
                $("#areaChk").find("td span.on").remove();
                var days = ["월", "화", "수", "목", "금", "토", "일"];
                dayList.forEach(function(item){
                    days.forEach(function(day, idx){
                        if(day === item.codeNm){
                            $(".rwd_popup_mentoring .cont_03 #areaChk").find("tr").eq(item.codeValue==="오전"?0:1)
                                .find("td").eq(idx+1).append("<span class=\"on\"></span>");
                        }
                    });
                });

                // 과외 경력
                data.lessonCareerList.forEach(function(item){
                    if(tms.isNotEmpty(item.startDate) && tms.isNotEmpty(item.endDate)){
                        var date = moment(item.startDate).format("YYYY-MM-DD").toString() + " ~ "
                            + moment(item.endDate).format("YYYY-MM-DD").toString();
                        $(".rwd_popup_mentoring .cont_03 #careerList").append('<p class="date">'+date+'</p>')
                    }
                    $(".rwd_popup_mentoring .cont_03 #careerList").append('<p class="txt">'+item.lessonContent+'</p>')
                });
            }
        });
    });

    //생기부 및 자소서 가격 및 날짜 설정
    codeApi.getContentsSaleInfo(null, function(code, data, res) {
        if(code == 0) {
            //생기부 탭 가격 설정
            $(".rwd_popup_mentoring .tab_cont .cont_01 .table_box").each(function() {
                var boxObj = $(this).find(".buy_box");
                var saleInfoCd = $(boxObj).data("cd");
                if(tms.isNotEmpty(saleInfoCd)) {
                    var saleInfoValue = data[saleInfoCd];
                    if(tms.isNotEmpty(saleInfoValue.price)) {
                        $(this).find(".introPrice").text(tms.setComma(saleInfoValue.price));
                    }
                    $(this).find(".introExpDay").text(saleInfoValue.expDay);
                }
            });

            //자소서 탭 가격 설정
            $(".rwd_popup_mentoring .tab_cont .cont_04 .table_box").each(function() {
                var boxObj = $(this).find(".buy_box");
                var saleInfoCd = $(boxObj).data("cd");
                if(tms.isNotEmpty(saleInfoCd)) {
                    var saleInfoValue = data[saleInfoCd];
                    if(tms.isNotEmpty(saleInfoValue.price)) {
                        $(this).find(".introPrice").text(tms.setComma(saleInfoValue.price));
                    }
                    $(this).find(".introExpDay").text(saleInfoValue.expDay);
                }
            });
        }

    });
}

var recordForMentorView = function(paramHipId, paramSrSamplingYn) {
    var params = {
        mentorHipId:paramHipId
    };
    recordApi.retrieveMentorSchoolRecordForMentorView(params, function(code, data, res) {
        if(code == 0) {
            $(".rwd_popup_mentoring .tab_cont .profile_record .table_box").each(function() {
               $(this).show();
            });

            if(data != null) {
                //생기부 컨텐츠 미리보기 설정
                $(".rwd_popup_mentoring .tab_cont .profile_record .table_box .buy_box3").each(function() {
                    var dataCd = $(this).data("cd");
                    var objRecord = data[dataCd];
                    if(objRecord =! null) {
                        if(data[dataCd].schoolRecordSummary != null) {
                            var iframe = document.getElementById("popFrame");
                            iframe = iframe.contentWindow || ( iframe.contentDocument.document || iframe.contentDocument);

                            iframe.document.open();
                            iframe.document.write(data[dataCd].schoolRecordSummary);
                            iframe.document.close();
                            $(this).html($("#popFrame").contents().find("body").html());
                        } else {
                            $(this).closest(".table_box").hide();
                        }
                    } else {
                        $(this).closest(".table_box").hide();
                    }

                });

                //생기부 구입여부 설정
                $(".rwd_popup_mentoring .tab_cont .profile_record .table_box a").each(function() {
                    var dataCd = $(this).data("cd");
                    $(this).find(".itemNm").show();
                    if(dataCd == "AWARDS" || dataCd == "CAREER" || dataCd == "SERVICE" || dataCd == "READING") {
                        $(this).find(".isPayment").text("구입하기");
                    } else {
                        $(this).find(".isPayment").text("구입");
                    }
                });
                $(".rwd_popup_mentoring .tab_cont .profile_record .table_box a").each(function() {
                    var dataCd = $(this).data("cd");
                    var isPremiumDirectSale = data[dataCd].isPremiumDirectSale;
                    var isPayment = data[dataCd].isPayment;
                    var text = "구입";
                    if(dataCd == "AWARDS" || dataCd == "CAREER" || dataCd == "SERVICE" || dataCd == "READING") {
                        if(isPayment) {
                            text = "구입완료";
                            $(this).find(".itemNm").hide();
                        } else {
                            text = "구입하기";
                        }
                        $(this).find(".isPayment").text(text);
                    } else {
                        if(isPayment) {
                            text = "구입완료";
                        } else {
                            if(isPremiumDirectSale) {
                                text = "구입";
                            } else {
                                text = "구입요청";
                            }
                        }
                        $(this).find(".isPayment").text(text);
                    }

                    //맛보기 체크
                    var isSampling = data[dataCd].isSampling;
                    if(isSampling) {
                        $(this).find(".mat").show();
                    } else {
                        $(this).find(".mat").hide();
                    }
                });

                //생기부 맛보기 컨텐츠 설정
                if(paramSrSamplingYn) {
                    if(data.AWARDS.isSampling) {
                        $(".srsampling_sampling_Y").show();
                        $(".srsampling_sampling_N").hide();
                    } else {
                        $(".srsampling_sampling_Y").hide();
                        $(".srsampling_sampling_N").show();

                        $(".sampling_period").text(data.AWARDS.samplingExpDay);
                    }
                } else {
                    $(".srsampling_sampling_Y").hide();
                    $(".srsampling_sampling_N").hide();
                }

                $(".rwd_popup_mentoring .tab_cont .profile_record .table_box a").unbind().bind("click", function(){
                    var dataCd = $(this).data("cd");
                    isPurchaseItem(this, 3, dataCd, paramHipId, null);
                });
            }
        }
    });
}

var getMentorSelfReport = function(paramHipId, paramSelfIntroNo) {
    var params = {
        mentorHipId: paramHipId,
        selfIntroNo: paramSelfIntroNo
    };
    recordApi.getMentorSelfReport(params, function(code, data, res) {
        if(code == 0) {
            var selfIntroNo = data.selfIntroNo;

            $(".rwd_popup_mentoring .tab_cont .profile_selfintro .table_box").each(function() {
               $(this).show();
            });

            //자소서 컨텐츠 미리보기 설정
            $(".rwd_popup_mentoring .tab_cont .profile_selfintro .table_box .buy_box3").each(function() {
                var dataCd = $(this).data("cd");
                var objIntro = data[dataCd];
                if(objIntro != null) {
                    if(data[dataCd].selfReportSummary != null) {
                        var iframe = document.getElementById("popFrame");
                        iframe = iframe.contentWindow || ( iframe.contentDocument.document || iframe.contentDocument);

                        iframe.document.open();
                        iframe.document.write(data[dataCd].selfReportSummary);
                        iframe.document.close();
                        $(this).html($("#popFrame").contents().find("body").html());
                    } else {
                        $(this).closest(".table_box").hide();
                    }
                } else {
                    $(this).closest(".table_box").hide();
                }
            });

            //자소서 구입여부 설정
            $(".rwd_popup_mentoring .tab_cont .profile_selfintro .table_box a").each(function() {
                $(this).find(".itemNm").show();
                $(this).find(".isPayment").text("구입하기");
            });
            $(".rwd_popup_mentoring .tab_cont .profile_selfintro .table_box a").each(function() {
                var dataCd = $(this).data("cd");
                var obj = data[dataCd];
                if(obj != null) {
                    var isPayment = data[dataCd].isPayment;
                    var text = "구입하기";
                    if(isPayment) {
                        text = "구입완료";
                        $(this).find(".itemNm").hide();
                    } else {
                        text = "구입하기";
                    }
                    $(this).find(".isPayment").text(text);
                }
            });

            $(".rwd_popup_mentoring .tab_cont .profile_selfintro .table_box a").unbind().bind("click", function(){
                var dataCd = $(this).data("cd");
                isPurchaseItem(this, 7, dataCd, paramHipId, selfIntroNo);
            });
        }

    });
}

var isPurchaseItem = function(clickObj, paramType, paramCode, paramHipId, paramIntroNo) {
    if(common.userInfo.isLogin || (userToken && userHipId )) {
        var params = {
            mentorHipId:paramHipId
            , code : paramCode
            , actionType: paramType
            , selfIntroNo: paramIntroNo
            , location : "profile"
        };
        recordApi.isPurchaseItem(params, function(code, data, res) {
            if(code == 0) {
                var purchaseItemInfo = data.purchaseItemInfo;
                if(purchaseItemInfo != null ) {
                    if(purchaseItemInfo.isPurchase) {
                        //생기부 및 자기소개서 팝업 오픈
                        recordOrIntroPopOpen(paramType, paramCode, paramHipId, paramIntroNo);
                    } else {
                        var paramsPurchase = {
                            actionType: paramType
                            , isMentor : false
                            , code : paramCode
                            , mentorHipId:paramHipId
                            , location : "profile"
                        };
                        recordApi.purchaseInfo(paramsPurchase, function(code2, data2, res2) {
                            if(code2 == 0) {
                                var purchaseInfo = data2.purchaseInfo;
                                if(purchaseInfo != null) {
                                    //구매가능 여부 체크
                                    if(purchaseInfo.canPurchaseItem) {
                                        var itemType = purchaseInfo.itemType; //1. 아이템, 2. 캐시, 3.무료
                                        var itemValue = purchaseInfo.itemValue; //0. 무료, 아이템유형1인경우 : 수량, 아이템유형2인경우 : 금액
                                        var itemName = purchaseInfo.itemName;

                                        if(itemType == 1) {
                                            var message = "";
                                            if(itemValue == 0) {
                                                message = "무료 입니다.<br/>확인 하시겠습니까?";
                                            } else {
                                                message = itemName + " " + itemValue + "장이 차감됩니다<br/>사용하시겠습니까?";
                                            }
                                            common.openConfirmPopup(message, function(){
                                                var paramTransactionId = moment(new Date()).format("YYYYMMDDHHmmssSSS") + paramHipId;
                                                var useParams = {
                                                    actionType: paramType
                                                    , code : paramCode
                                                    , mentorHipId: paramHipId
                                                    , transactionId: paramTransactionId
                                                    , selfIntroNo: paramIntroNo
                                                };
                                                recordApi.useInventoryItemOfContents(useParams, function(codeItem, dataItem, resItem) {
                                                    if(codeItem == 0) {
                                                        if(paramCode == "AWARDS" || paramCode == "CAREER" || paramCode == "SERVICE" || paramCode == "READING") {
                                                            $(clickObj).find(".itemNm").hide();
                                                        }
                                                        $(clickObj).find(".isPayment").text("구입완료");
                                                        
                                                        if(String(clickObj).indexOf(contextPath + "/app/today") !== -1){
                                                        	var purchaseMessage = setPurchaseMessageForToday(paramType, dataItem.useInventoryItemInfo.itemExpDay);
                                                        	common.openConfirmPopup(purchaseMessage, function(){
                                                        		//생기부 및 자기소개서 팝업 오픈
                                                        		recordOrIntroPopOpen(paramType, paramCode, paramHipId, paramIntroNo);
                                                        	});    
                                                        }else{
                                                        	var purchaseMessage = setPurchaseMessage(paramType, dataItem.useInventoryItemInfo.itemExpDay);
                                                        	common.openConfirmPopup(purchaseMessage, function(){
                                                        		//생기부 및 자기소개서 팝업 오픈
                                                        		recordOrIntroPopOpen(paramType, paramCode, paramHipId, paramIntroNo);
                                                        	});                                                 	
                                                        }
                                                      
                                                    }
                                                })
                                            });
                                        } else if(itemType == 2) {
                                            var message = "";
                                            if(itemValue == 0) {
                                                message = "무료 입니다.<br/>확인 하시겠습니까?";
                                            } else {
                                                message = itemValue + "포인트가 차감됩니다<br/>사용하시겠습니까?";
                                            }
                                            common.openConfirmPopup(message, function(){
                                                var paramTransactionId = moment(new Date()).format("YYYYMMDDHHmmssSSS") + paramHipId;
                                                var useParams = {
                                                    actionType: paramType
                                                    , code : paramCode
                                                    , mentorHipId: paramHipId
                                                    , transactionId: paramTransactionId
                                                    , selfIntroNo: paramIntroNo
                                                };
                                                recordApi.purchaseItemOfContents(useParams, function(codeItem, dataItem, resItem) {
                                                    if(codeItem == 0) {
                                                        if(paramCode == "AWARDS" || paramCode == "CAREER" || paramCode == "SERVICE" || paramCode == "READING") {
                                                            $(clickObj).find(".itemNm").hide();
                                                        }
                                                        $(clickObj).find(".isPayment").text("구입완료");
                                                        
                                                        if(String(clickObj).indexOf(contextPath + "/app/today") !== -1){
                                                        	var purchaseMessage = setPurchaseMessageForToday(paramType, dataItem.purchaseItemInfo.itemExpDay);
                                                        	common.openConfirmPopup(purchaseMessage, function(){
                                                        		//생기부 및 자기소개서 팝업 오픈
                                                        		recordOrIntroPopOpen(paramType, paramCode, paramHipId, paramIntroNo);
                                                        	});    
                                                        } else{
                                                        	var purchaseMessage = setPurchaseMessage(paramType, dataItem.purchaseItemInfo.itemExpDay);
                                                        	
                                                        	common.openConfirmPopup(purchaseMessage, function(){
                                                        		//생기부 및 자기소개서 팝업 오픈
                                                        		recordOrIntroPopOpen(paramType, paramCode, paramHipId, paramIntroNo);
                                                        	});                                                        	
                                                        }
                                                    }

                                                })
                                            });
                                        } else if(itemType == 3) {
                                            common.openConfirmPopup("무료 입니다.<br/>확인 하시겠습니까?", function(){
                                                //location.href = common.urlInfo.myPageMyInfo;
                                            });
                                        }

                                    } else {
                                        //충전창으로 이동
                                    	location.href = common.urlInfo.paymentItem;
                                    }

                                }
                            }
                        })
                    }
                }
            } else {
                common.openAlertPopup(res.resultText);
            }

        });
    } else {
        Layer_OPEN('.popup_app');
    }

}

var recordOrIntroPopOpen = function(paramType, paramCode, paramHipId, paramIntroNo) {
    if(paramType == 3) {
        //생기부
        var paramsRecord = {
            schoolRecordCd:paramCode
            , mentorHipId: paramHipId
        };
        myPageApi.retrieveOneMentorSchoolRecord(paramsRecord, function(codeRecord, dataRecord){
            if(codeRecord === 0){
                mark.setPopupCont(dataRecord.result.schoolRecordSummary, common.userInfo.nickname);
            }
        });

    } else if(paramType == 7) {
        //자기소개서
        var paramReport = {
            mentorHipId: paramHipId
            , selfReportCd: paramCode
            , selfIntroNo: paramIntroNo
        };
        recordApi.getOneMentorSelfReport(paramReport, function(codeReport, dataReport, resReport) {
            if(codeReport === 0){
                mark.setPopupCont(dataReport.selfReportSummary, common.userInfo.nickname);
            }
        })
    }
}

var setPurchaseMessage = function(paramType, itemExpDay) {
    var message = "";
    if(paramType == 3) {
        //생기부
        message = "정상 처리 되었습니다.<br/>";
        message += itemExpDay + "일간 마이링커 구매내역에서 열람이 가능합니다.<br/>";
        message += common.userInfo.nickname + "님의 멘토링 목적으로만 사용하셔야 합니다.<br/>";
        message += "불법유포 시 개인정보 처리방침에 따라서 민형사상 책임을 질 수 있습니다.";

    } else if(paramType == 7) {
        //자기소개서
        message = "결제가 완료되었습니다." + itemExpDay + "일간 마이링커 구매내역에서 열람이 가능합니다.<br/>";
        message += "등록된 자소서의 저작권은 작성자 멘토에게 있으며, 링커 버시스를 통해서 본인만 열람하셔야 합니다.";
        message += "링커에 등록된 자소서를 불법유출하거나, 상업적으로 이용하는 경우 저작권 침해에 대한 이의제기 또는 손해배상 청구 가능성이 있습니다.<br/>";
        message += "타인의 자소서는 참고 용도로만 사용하여야하고, 실제 사용 시, 대교협 자기소개서 유사도 검사 시스템에 표절로 인식되어 불이익을 받을 수 있습니다.";
    }

    return message;

}

var setPurchaseMessageForToday = function(paramType, itemExpDay) {
    var message = "";
    if(paramType == 3) {
        //생기부
        message = "생활기록부 항목의 결제가 완료되어<br/>";
        message += itemExpDay + "일간 열람할 수 있습니다.<br/><br/>";
        message += "Mobile (Linker App)<br/>PC (www.ilinker.co.kr)<br/>활동 구매내역에서 열람 가능<br/><br/>";
        message += "본인의 멘토링 목적으로 링커에서만 열람 가능합니다.<br/>";
        message += "불법유포 시 개인정보 처리방침에 따라<br/>민형사상 책임을 질 수 있습니다.";

    } else if(paramType == 7) {
        //자기소개서
	   message = "자기소개서 항목의 결제가 완료되어<br/>";
       message += itemExpDay + "일간 열람할 수 있습니다.<br/><br/>";
       message += "Mobile (Linker App)<br/>PC (www.ilinker.co.kr)<br/>활동 구매내역에서 열람 가능<br/><br/>";
       message += "등록된 자소서의 저작권은 작성자 멘토에게 있으며, 링커 서비스를 통해서 본인만 열람하셔야 합니다.<br/>";
       message += "링커에 등록된 자소서를 불법유출하거나, 상업적으로 이용하는 경우 저작권 침해에 대한<br/>";
       message += "이의제기 또는 손해배상 청구<br/>";
       message += "가능성이 있습니다.<br/><br/>";
       message += "타인의 자소서는 참고 용도로만<br/>";
       message += "사용하여야 하며, 실제 사용시,<br/>";
       message += "대교협 자기소개서 유사도 검사 시스템에 표절로 인식되어 불이익을 받을 수 있습니다.<br/>";
    }

    return message;

}
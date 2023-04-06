var nickNm = '';                            // 입력한 닉네임
var nickSearchPage = 0;                     // 닉네임 리스트 페이지
var nickSearchLast = false;                 // 닉네임 리스트 마지막 페이지
var areaVal = -1;                           // 선택한 시도 지역
var minorVal = [];                          // 선택한 시군구 지역

$(function() {

    //멘토링 유형 션택
    $('.btn_mentoringType').unbind().bind('click', function(){
        codeApi.getRetrieveCd({categoryNo: "3", parentNo: "0"}, function (codeCd, dataCdList) {
            //팝업 컨텐츠 초기화
            $(".layer_search_popup .choice_area").html("");
            if(codeCd == 0) {

                //체크박스 처리
                dataCdList.map(function(obj) {
                    var resultCd = searchParam.mentoringCdList.filter(function(cd) {
                        return obj.codeNo == cd;
                    });

                    if(resultCd != null && resultCd.length > 0) {
                        obj.isChecked = true;
                    } else {
                        obj.isChecked = false;
                    }
                    return obj;
                });

                $(".layer_search_popup .title").text("멘토링 유형 선택");
                $(".layer_search_popup .btn_box .btn_cancel").text("전체 초기화");
                if(searchParam.mentoringCdList != null && searchParam.mentoringCdList.length > 0) {
                    $(".layer_search_popup .choice_area").append("<label class=\"select_checkbox mb10\"><input type=\"checkbox\" name=\"mentoringCd\" value=\"\"><em></em><span class=\"style_01\">전체</span></label>");
                } else {
                    $(".layer_search_popup .choice_area").append("<label class=\"select_checkbox mb10\"><input type=\"checkbox\" name=\"mentoringCd\" value=\"\" checked=\"checked\"><em></em><span class=\"style_01\">전체</span></label>");
                }

                $("#mentoringTypeSearchPopupTmpl").tmpl(dataCdList).appendTo(".layer_search_popup .choice_area");

                var cnt = $('.layer_search_popup div.choice_area input[type=checkbox]').length;
                controlHeight(cnt);

                $(".layer_search_popup").addClass("open");

                //전체 초기화 버튼 클릭
                $('.layer_search_popup .btn_box .btn_cancel').unbind().bind('click', function(){
                    $('.layer_search_popup').removeClass('open');
                    //멘토링 유형 체크박스 초기화
                    $(".layer_search_popup .choice_area input:checkbox[name='mentoringCd']").each(function() {
                        var mentoringCdEach = $(this).val();
                        if(tms.isNotEmpty(mentoringCdEach)) {
                            $(this).prop("checked", false);
                        } else {
                            $(this).prop("checked", true);
                        }
                    });

                    searchParam.mentoringCdList = [];
                    getMenteeList(0, SEARCH_TYPE, "#mentoringList");
                });

                //적용하기 버튼 클릭
                $('.layer_search_popup .btn_box .btn_apply').unbind().bind('click', function(){
                    $('.layer_search_popup').removeClass('open');
                    //멘토링 유형 체크박스 초기화
                    var mentoringList = [];
                    $(".layer_search_popup .choice_area input:checkbox[name='mentoringCd']").each(function() {
                        if($(this).is(":checked")) {
                            var mentoringCdEach = $(this).val();
                            if(tms.isNotEmpty(mentoringCdEach)) {
                                mentoringList.push(mentoringCdEach);
                            }
                        }
                    });

                    searchParam.mentoringCdList = mentoringList;
                    getMenteeList(0, SEARCH_TYPE, "#mentoringList");
                });

                //멘토링 유형 체크박스 클릭
                $(".layer_search_popup .choice_area input:checkbox[name='mentoringCd']").unbind().bind("click", function() {
                    var mentoringCd = $(this).val();
                    if(tms.isEmpty(mentoringCd)) {
                        if($(this).is(":checked")) {
                            $(".layer_search_popup .choice_area input:checkbox[name='mentoringCd']").each(function() {
                                var mentoringCdEach = $(this).val();
                                if(tms.isNotEmpty(mentoringCdEach)) {
                                    $(this).prop("checked", false);
                                }
                            });
                        } else {
                            $(this).prop("checked", true);
                        }
                    } else {
                        $(".layer_search_popup .choice_area input:checkbox[name='mentoringCd'][value='']").prop("checked", false);
                    }
                });
            }
        });
    });

    //멘티 유형 선택
    $('.btn_menteeType').unbind().bind('click', function(){
        //팝업 컨텐츠 초기화
        $(".layer_search_popup .choice_area").html("");

        $(".layer_search_popup .title").text("멘티 유형 선택");
        $(".layer_search_popup .btn_box .btn_cancel").text("닫기");
        $("#menteeTypeSearchPopupTmpl").tmpl().appendTo(".layer_search_popup .choice_area");
        //멘티 유형 라디오 버튼 checked
        if(searchParam.menteeCdList != null && searchParam.menteeCdList.length > 0) {
            $(".layer_search_popup .choice_area input:radio[name='menteeCd'][value='"+searchParam.menteeCdList[0]+"']").prop("checked", true);
        } else {
            $(".layer_search_popup .choice_area input:radio[name='menteeCd'][value='']").prop("checked", true);
        }

        var cnt = $('.layer_search_popup div.choice_area input[type=checkbox]').length;
        controlHeight(cnt);

        $(".layer_search_popup").addClass("open");

        //닫기 버튼 클릭
        $('.layer_search_popup .btn_box .btn_cancel').unbind().bind('click', function(){
            searchParam.menteeCdList = [];
            $(".layer_search_popup").removeClass('open');
        });

        //적용하기 버튼 클릭
        $('.layer_search_popup .btn_box .btn_apply').unbind().bind('click', function(){
            searchParam.menteeCdList = [];
            var menteeCd = $(".layer_search_popup .choice_area input[name='menteeCd']:checked").val();
            if(tms.isNotEmpty(menteeCd)) {
                searchParam.menteeCdList.push(menteeCd);
            }

            $(".layer_search_popup").removeClass('open');
            getMenteeList(0, SEARCH_TYPE, "#mentoringList");

        });
    });

    /**
     * 시/도 검색
     */
    $('.btn_major').unbind().bind('click', function(){
        $('.layer_search_popup h2.title').text('시/도 선택');
        $('.layer_search_popup div.choice_area').empty().append('<label class="select_radiobox style_01 mb10"><input type="radio" name="areaType" value="-1"/><em></em><span>시/도 선택</span></label>');

        codeApi.retrieveArea(function(code, data, res){
            if(code === 0){
                // 시도 설정
                data.areaList.forEach(function(item){
                   if(item.parentNo === 0) {
                       $('.layer_search_popup div.choice_area').append('<label class="select_radiobox style_01 mb10"><input type="radio" name="areaType" value="'+item.areaNo+'" /><em></em><span>'+item.areaNm+'</span></label>');
                   }
                });

                var cnt = $('.layer_search_popup div.choice_area input[type=radio]').length;
                controlHeight(cnt);

                // 체크박스 선택
                $('.layer_search_popup .choice_area input[value='+areaVal+']').prop('checked', true);

                // 팝업 확인 버튼 클릭시 동작
                $('.layer_search_popup .btn_box .btn_apply').unbind().bind('click', function(){
                    $('.choice_box .btn_minor span').text('전체');
                    $('.choice_box .btn_major span').text('시/도 선택');
                    areaVal = $('.layer_search_popup .choice_area input[name=areaType]:checked').val();
                    $('.choice_box .btn_major span').text($('.layer_search_popup .choice_area input[name=areaType]:checked').siblings('span').text());

                    // 멘토링 설정
                    searchParam.lessonAreaCdList = areaVal !== "-1" ? [areaVal] : [];

                    // 멘토링 리스트 설정
                    $("#lessonList").empty();
                    getMenteeList(0, SEARCH_TYPE, "#lessonList");
                    $('.layer_search_popup').removeClass('open');
                });

                // 팝업 닫기 버튼 클릭시 동작
                $('.layer_search_popup .btn_box .btn_cancel').text('닫기');
               ` $('.layer_search_popup .btn_box .btn_cancel').unbind().bind('click', function(){
                    $('.layer_search_popup').removeClass('open');
                });`

                $('.layer_search_popup').addClass('open');
            }
        })
    });

    /**
     * 시군구 검색
     */
    $('.btn_minor').unbind().bind('click', function(){
        if(areaVal.toString() == "-1"){
            $('.choice_box .btn_minor span').text('전체');
            return;
        }

        $('.layer_search_popup h2.title').text('시/군/구 선택');
        $('.layer_search_popup div.choice_area').empty();

        codeApi.retrieveArea(function(code, data, res){
            if(code === 0){
                // 시도 설정
                data.areaList.forEach(function(item){
                    if(item.parentNo.toString() === areaVal.toString()) {
                        $('.layer_search_popup div.choice_area').append('<label class="select_checkbox mb10"><input type="checkbox" name="minor" value="'+item.areaNo+'"><em></em><span class="style_01">'+item.areaNm+'</span></label>');
                    }
                });

                var cnt = $('.layer_search_popup div.choice_area input[type=checkbox]').length;
                controlHeight(cnt);

                // 체크박스 설정
                minorVal.forEach(function(item) {
                    $('.layer_search_popup .choice_area input[name=minor]').each(function() {
                        if($(this).val().toString() === item.toString()){
                            $(this).prop('checked', true);
                        }
                    });
                });

                // 체크박스 동작
                $('.layer_search_popup .choice_area input[name=minor]').unbind().bind('click', function(){
                    var $this = $(this);
                    var firstNo = $('.layer_search_popup .choice_area input[name=minor]').eq(0).val();

                    // 전체 클릭시
                    if($this.val() === firstNo && $this.is(":checked")){
                        $('.layer_search_popup .choice_area input[name=minor]').each(function(){
                            if(firstNo !== $(this).val()){
                                $(this).prop('checked', false);
                            }
                        });
                    }else if($this.val() !== firstNo && ($this.is(":checked"))){
                        $('.layer_search_popup .choice_area input[name=minor]').eq(0).prop('checked', false);
                    }

                    if($('.layer_search_popup .choice_area input[name=minor]:checked').length > 6){
                        common.openAlertPopup("6개 이상의 체크박스를 선택할 수 없습니다.", function(){
                            $this.prop('checked', false);
                        });
                    }
                });


                // 팝업 확인 버튼 클릭시 동작
                var choiceMinor = [];
                $('.layer_search_popup .btn_box .btn_apply').unbind().bind('click', function(){
                    minorVal = [];
                    $('.layer_search_popup .choice_area input[name=minor]').each(function() {
                        if($(this).is(':checked')){
                            minorVal.push($(this).val());
                            choiceMinor.push($(this).siblings('span').text());
                        }
                    });

                    if(minorVal.length >= 1){
                        $('.choice_box .btn_minor span').text(choiceMinor.toString());
                    }else{
                        $('.choice_box .btn_minor span').text($('.layer_search_popup .choice_area input[name=minor]').eq(0).siblings('span').text());
                    }

                    // 멘토링 설정
                    searchParam.lessonAreaCdList = minorVal.length > 0 ? minorVal : [areaVal];
                    // 멘토링 리스트 설정
                    $("#lessonList").empty();
                    getMenteeList(0, "LESSON", "#lessonList");
                    $('.layer_search_popup').removeClass('open');
                });

                // 팝업 닫기 버튼 클릭시 동작
                $('.layer_search_popup .btn_box .btn_cancel').text('전체 초기화');
                $('.layer_search_popup .btn_box .btn_cancel').unbind().bind('click', function(){
                    minorVal = [];
                    $('.choice_box .btn_minor span').text($('.layer_search_popup div.choice_area input[name=minor]:eq(0)').siblings('span').text());
                    minorVal.push($('.layer_search_popup div.choice_area input[name=minor]:eq(0)').val());

                    // 멘토링 설정
                    searchParam.lessonAreaCdList = minorVal.length > 0 ? minorVal : [areaVal];
                    // 멘토링 리스트 설정
                    $("#lessonList").empty();
                    getMenteeList(0, "LESSON", "#lessonList");
                    $('.layer_search_popup').removeClass('open');
                });

                $('.layer_search_popup').addClass('open');
            }
        })
    });

    //조건 검색
    $('.btn_choice').unbind().bind('click', function(){
        if(SEARCH_TYPE == "MENTORING") {
            $(".mentoring_search_popup .search_box").val("");
            $(".mentoring_search_popup .condition_menteeList").empty();

            $(".mentoring_search_popup").addClass("open");
        } else if(SEARCH_TYPE == "LESSON") {
            $(".lesson_search_popup .search_box").val("");
            $(".lesson_search_popup .condition_menteeList").empty();

            $('.lesson_search_popup .btn_tab .detail').addClass("on");
            $('.lesson_search_popup .btn_tab .nickname').removeClass("on");
            $(".lesson_search_popup .cont_01").addClass("on");
            $(".lesson_search_popup .cont_02").removeClass("on");

            //필요학습과목
            subjectCdList();
            //멘티유형
            $(".rwd_popup_search.open .menteeCdListArea input[name='menteeCd']").each(function() {
                var menteeCd = $(this).val();
                var resultCd = searchParam.menteeCdList.filter(function(cd) {
                    return menteeCd == cd;
                });
                if(resultCd != null && resultCd.length > 0) {
                    $(this).prop("checked", true);
                } else {
                    $(this).prop("checked", false);
                }
            });

            $(".lesson_search_popup").addClass("open");

            //상세조건 탭 클릭
            $('.lesson_search_popup .btn_tab .detail').unbind().bind('click', function(){
                $(this).addClass("on");
                $('.lesson_search_popup .btn_tab .nickname').removeClass("on");
                $(".lesson_search_popup .cont_01").addClass("on");
                $(".lesson_search_popup .cont_02").removeClass("on");

            });

            //닉네임 검색 탭 클릭
            $('.lesson_search_popup .btn_tab .nickname').unbind().bind('click', function(){
                $(this).addClass("on");
                $('.lesson_search_popup .btn_tab .detail').removeClass("on");
                $(".lesson_search_popup .cont_01").removeClass("on");
                $(".lesson_search_popup .cont_02").addClass("on");

            });
        }

        //닉네임 검색
        $('.rwd_popup_search.open .condition_content .search_btn').unbind().bind('click', function(){
            nickSearchPage = 0;
            nickSearchLast = false;

            $('.rwd_popup_search.open .cont_02 .condition_menteeList').empty();
            getSearchNickNameList();

            $('.rwd_popup_search.open .in_box').unbind().bind('scroll', function(){
                var $this = $(this);
                if($this.scrollTop() + 557 > $('.rwd_popup_search.open .inner_box').height() && !nickSearchLast){
                    nickSearchPage+=36;
                    getSearchNickNameList();
                }
            });

        })

        //전체 초기화
        $('.rwd_popup_search.open .search_clean').unbind().bind('click', function(){
            var objId = "";
            if(SEARCH_TYPE == "MENTORING") {
                objId = "#mentoringList";
            } else if(SEARCH_TYPE == "LESSON") {
                objId = "#lessonList";
            }

            //필요학습 과면 초기화
            searchParam.subjectCdList = [];
            $(".rwd_popup_search.open .subjectCdListArea input[name='menteeCd']").each(function() {
                $(this).prop("checked", false);
            });

            //멘티 유형 초기화
            searchParam.menteeCdList = [];
            $(".rwd_popup_search.open .menteeCdListArea input[name='menteeCd']").each(function() {
                $(this).prop("checked", false);
            });

            $(".rwd_popup_search").removeClass("open");
            getMenteeList(0, SEARCH_TYPE, objId);
        });

        //전체 적용하기
        $('.rwd_popup_search.open .search_ok').unbind().bind('click', function(){
            var objId = "";
            if(SEARCH_TYPE == "MENTORING") {
                objId = "#mentoringList";
            } else if(SEARCH_TYPE == "LESSON") {
                objId = "#lessonList";
            }

            //필요학습 과목 적용
            searchParam.subjectCdList = [];
            $(".rwd_popup_search.open #subjectCdListArea input:checkbox[name='subjectCd']").each(function() {
                if($(this).is(":checked")) {
                    var subjectCd = $(this).val();
                    searchParam.subjectCdList.push(subjectCd);
                }
            });

            //멘티 유형 적용
            searchParam.menteeCdList = [];
            $(".rwd_popup_search.open .menteeCdListArea input:checkbox[name='menteeCd']").each(function() {
                if($(this).is(":checked")) {
                    var subjectCd = $(this).val();
                    searchParam.menteeCdList.push(subjectCd);
                }
            });

            $(".rwd_popup_search").removeClass("open");
            getMenteeList(0, SEARCH_TYPE, objId);

        });


    });


});

var subjectCdList = function() {
    codeApi.getRetrieveCd({categoryNo: "2", parentNo: "0"}, function (codeCd, dataCdList) {
        $("#subjectCdListArea").html("");
        if(codeCd == 0) {
            dataCdList.map(function(obj) {
                var resultCd = searchParam.subjectCdList.filter(function(cd) {
                    return obj.codeNo == cd;
                });

                if(resultCd != null && resultCd.length > 0) {
                    obj.isChecked = true;
                } else {
                    obj.isChecked = false;
                }

                return obj;
            });

            $("#subjectCdListPopupTmpl").tmpl(dataCdList).appendTo("#subjectCdListArea");
        }

        /*if(searchParam.subjectCdList.length > 0) {
            $(".rwd_popup_search.open #subjectCdListArea input:checkbox[name='subjectCd']").each(function() {

            });

        }*/
    });
}

var getSearchNickNameList = function() {
    var param = {
        start : nickSearchPage,
        searchTypeCd : 'MENTEE',
        nickname : $(".rwd_popup_search.open .cont_02 input[name=nickNm]").val()
    };

    consultApi.getSearchListByNickname(param, null, function(code, data, res){
        if(code === 0){
            if(tms.isNotEmpty(data)){
                $("#nickNmSearchTmpl").tmpl(data.searchList).appendTo('.rwd_popup_search.open .cont_02 .condition_menteeList');

                // 클릭 이벤트
                $('.rwd_popup_search.open .cont_02 .condition_menteeList .profile_area').unbind().bind("click", function(){
                    $(".mentee_profile").addClass("open");
                    var hipId = $(this).data("no");
                    retrieveMenteeProfile(hipId, SEARCH_TYPE);
                    getMenteeInfo(hipId);
                });
            }else{
                nickSearchLast = true;
            }
        }
    });
}

var controlHeight = function(cnt) {
    var popHeight = 240;
    var itemHeight = 33;
    if ( cnt > 3 ) {
        var height = ((cnt - 3) * itemHeight) + popHeight;
        if ( height > window.innerHeight ) {
            height = window.innerHeight - 128;
            $('.popup_all .layer_search_popup .in_box::-webkit-scrollbar').css("display", "initial");
        }

        $('.popup_all .layer_search_popup .inner_box').css("height", height+"px");
    }
    else {
        $('.popup_all .layer_search_popup .inner_box').css("height", popHeight + "px");
    }
}
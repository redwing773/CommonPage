var MENTORING_VAL = ['mentorState', 'selfIntro'];    // 멘토링 고유값
var SEARCH_TYPE = 'MENTORING';               // 검색할 타입
var searchTabIdx = 0;                       // 검색 탭 idx
var schoolArr = [];                         // 전체 대학교 목록

var passVal = -1;                           // 선택한 합격유형
var mentoringVal = -1;                      // 선택한 멘토링

var areaVal = -1;                           // 선택한 시도 지역
var minorVal = [];                          // 선택한 시군구 지역

var departmentLineVal = [];                 // 선택한 학과계열 (멘토링)
var universityList = [];                    // 선택한 대학교 (멘토링)

var departmentLineVal_lesson = [];          // 선택한 학과계열 (과외)
var universityList2_lesson = [];            // 선택한 대학교 (과외)
var daysList = [];                          // 선택한 요일 (과외)
var subjectList = [];                       // 선택한 과목 (과외)

// 멘토링
var paramOpt = {
    passVal : [],                           // 합격 유형
    hasSchoolRecord : false,                // 생기부 여부
    hasSelfReport : false,                  // 자소서 여부
    // 상세 조건
    universityPartyNoList : [],
    departmentLineCdList : []
};

// 과외
var paramOpt_lesson = {
    lessonAreaCdList : [],                  // 과외 가능한 지역

    // 상세 조건
    universityPartyNoList : [],
    departmentLineCdList : [],
    lessonDayCdList : [],
    subjectNoList : []
};

var nickNm = '';                            // 입력한 닉네임
var nickSearchPage = 0;                     // 닉네임 리스트 페이지
var nickSearchLast = false;                 // 닉네임 리스트 마지막 페이지


$(function() {
    /**
     * 합격 유형 검색
     */
    $('.btn_pass').unbind().bind('click', function(){
        $('.popup_type h2.title').text('합격유형 선택');
        $('.popup_type div.choice_area').empty().append('<label class="select_radiobox style_01 mb10"><input type="radio" name="passType" value="-1" checked="checked"/><em></em><span>합격유형 전체</span></label>');

        // 합격 유형 공통코드 호출
        codeApi.getRetrieveCd2({categoryNo:"8"},function(code, data, res){
            // Radio 버튼 셋팅
            data.forEach(function(item){
                if(item.parentNo === 0 && item.codeValue === "1"){
                    $('.popup_type div.choice_area').append('<label class="select_radiobox style_01 mb10"><input type="radio" name="passType" value="'+item.codeNo+'"/><em></em><span>'+item.codeNm+'</span></label>')
                }
            });

            var cnt = $('.popup_type div.choice_area input[type=radio]').length;
            controlHeight(cnt);

            // 체크박스 선택
            $('.popup_type .choice_area input[value='+passVal+']').prop('checked', true);
        });

        // 팝업 확인 버튼 클릭시 동작
        $('.popup_type .btn_box .btn_pass_type').unbind().bind('click', function(){
            passVal = $('.popup_type .choice_area input[name=passType]:checked').val();
            $('.choice_box .btn_pass span').text($('.popup_type .choice_area input[name=passType]:checked').siblings('span').text());

            page = 0;

            paramOpt.admissionType = passVal !== "-1" ? [passVal] : null;

            // 멘토링 리스트 설정
            $("#mentoringList").empty();
            getMentorList(page, "MENTORING", "#mentoringList", paramOpt);
            $('.popup_type').removeClass('open');
        });

        // 팝업 닫기 버튼 클릭시 동작
        $('.popup_type .btn_box .btn_cancel').text('닫기');
        $('.popup_type .btn_box .btn_cancel').unbind().bind('click', function(){
            $('.popup_type').removeClass('open');
        });

        $('.popup_type').addClass('open');
    });

    /**
     * 멘토링 검색
     */
    $('.btn_mentoring').unbind().bind('click', function(){
        $('.popup_type h2.title').text('멘토링 선택');
        $('.popup_type div.choice_area').empty().append('<label class="select_radiobox style_01 mb10"><input type="radio" name="mentoringType" value="-1"/><em></em><span>멘토링 전체</span></label>');
        $('.popup_type div.choice_area').append('<label class="select_radiobox style_01 mb10"><input type="radio" name="mentoringType" value="'+MENTORING_VAL[0]+'" /><em></em><span>생기부</span></label>');
        $('.popup_type div.choice_area').append('<label class="select_radiobox style_01 mb10"><input type="radio" name="mentoringType" value="'+MENTORING_VAL[1]+'" /><em></em><span>자소서</span></label>');

        var cnt = $('.popup_type div.choice_area input[type=radio]').length;
        controlHeight(cnt);

        // 체크박스 선택
        $('.popup_type .choice_area input[value='+mentoringVal+']').prop('checked', true);

        // 팝업 확인 버튼 클릭시 동작
        $('.popup_type .btn_box .btn_pass_type').unbind().bind('click', function(){
            mentoringVal = $('.popup_type .choice_area input[name=mentoringType]:checked').val();
            $('.choice_box .btn_mentoring span').text($('.popup_type .choice_area input[name=mentoringType]:checked').siblings('span').text());
            page = 0;

            // 멘토링 설정
            paramOpt.hasSchoolRecord = mentoringVal === MENTORING_VAL[0];
            paramOpt.hasSelfReport = mentoringVal === MENTORING_VAL[1];

            // 멘토링 리스트 설정
            $("#mentoringList").empty();
            getMentorList(page, "MENTORING", "#mentoringList", paramOpt);
            $('.popup_type').removeClass('open');
        });

        // 팝업 닫기 버튼 클릭시 동작
        $('.popup_type .btn_box .btn_cancel').text('닫기');
        $('.popup_type .btn_box .btn_cancel').unbind().bind('click', function(){
            $('.popup_type').removeClass('open');
        });

        $('.popup_type').addClass('open');
    });

    /**
     * 시/도 검색
     */
    $('.btn_major').unbind().bind('click', function(){
        $('.popup_type h2.title').text('시/도 선택');
        $('.popup_type div.choice_area').empty().append('<label class="select_radiobox style_01 mb10"><input type="radio" name="areaType" value="-1"/><em></em><span>시/도 선택</span></label>');

        codeApi.retrieveArea(function(code, data, res){
            if(code === 0){
                // 시도 설정
                data.areaList.forEach(function(item){
                   if(item.parentNo === 0) {
                       $('.popup_type div.choice_area').append('<label class="select_radiobox style_01 mb10"><input type="radio" name="areaType" value="'+item.areaNo+'" /><em></em><span>'+item.areaNm+'</span></label>');
                   }
                });

                var cnt = $('.popup_type div.choice_area input[type=radio]').length;
                controlHeight(cnt);

                // 체크박스 선택
                $('.popup_type .choice_area input[value='+areaVal+']').prop('checked', true);

                // 팝업 확인 버튼 클릭시 동작
                $('.popup_type .btn_box .btn_pass_type').unbind().bind('click', function(){
                    $('.choice_box .btn_minor span').text('전체');
                    $('.choice_box .btn_major span').text('시/도 선택');
                    areaVal = $('.popup_type .choice_area input[name=areaType]:checked').val();
                    $('.choice_box .btn_major span').text($('.popup_type .choice_area input[name=areaType]:checked').siblings('span').text());
                    page = 0;

                    // 멘토링 설정
                    paramOpt_lesson.lessonAreaCdList = areaVal !== "-1" ? [areaVal] : [];

                    // 멘토링 리스트 설정
                    $("#lessonList").empty();
                    getMentorList(page, "LESSON", "#lessonList", paramOpt_lesson);
                    $('.popup_type').removeClass('open');
                });

                // 팝업 닫기 버튼 클릭시 동작
                $('.popup_type .btn_box .btn_cancel').text('닫기');
                $('.popup_type .btn_box .btn_cancel').unbind().bind('click', function(){
                    $('.popup_type').removeClass('open');
                });

                $('.popup_type').addClass('open');
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

        $('.popup_type h2.title').text('시/군/구 선택');
        $('.popup_type div.choice_area').empty();

        codeApi.retrieveArea(function(code, data, res){
            if(code === 0){
                // 시도 설정
                data.areaList.forEach(function(item){
                    if(item.parentNo.toString() === areaVal.toString()) {
                        $('.popup_type div.choice_area').append('<label class="select_checkbox mb10"><input type="checkbox" name="minor" value="'+item.areaNo+'"><em></em><span class="style_01">'+item.areaNm+'</span></label>');
                    }
                });

                /*$('.popup_type div.choice_area input[name=minor]:eq(0)').prop('checked', true);
                $('.popup_type h2.title').text($('.popup_type div.choice_area input[name=minor]:eq(0)').siblings('span').text());*/

                var cnt = $('.popup_type div.choice_area input[type=checkbox]').length;
                controlHeight(cnt);

                // 체크박스 설정
                minorVal.forEach(function(item) {
                    $('.popup_type .choice_area input[name=minor]').each(function() {
                        if($(this).val().toString() === item.toString()){
                            $(this).prop('checked', true);
                        }
                    });
                });

                // 체크박스 동작
                $('.popup_type .choice_area input[name=minor]').unbind().bind('click', function(){
                    var $this = $(this);
                    var firstNo = $('.popup_type .choice_area input[name=minor]').eq(0).val();

                    // 전체 클릭시
                    if($this.val() === firstNo && $this.is(":checked")){
                        $('.popup_type .choice_area input[name=minor]').each(function(){
                            if(firstNo !== $(this).val()){
                                $(this).prop('checked', false);
                            }
                        });
                    }else if($this.val() !== firstNo && ($this.is(":checked"))){
                        $('.popup_type .choice_area input[name=minor]').eq(0).prop('checked', false);
                    }

                    if($('.popup_type .choice_area input[name=minor]:checked').length > 6){
                        common.openAlertPopup("6개 이상의 체크박스를 선택할 수 없습니다.", function(){
                            $this.prop('checked', false);
                        });
                    }
                });


                // 팝업 확인 버튼 클릭시 동작
                var choiceMinor = [];
                $('.popup_type .btn_box .btn_pass_type').unbind().bind('click', function(){
                    minorVal = [];
                    $('.popup_type .choice_area input[name=minor]').each(function() {
                        if($(this).is(':checked')){
                            minorVal.push($(this).val());
                            choiceMinor.push($(this).siblings('span').text());
                        }
                    });

                    if(minorVal.length >= 1){
                        $('.choice_box .btn_minor span').text(choiceMinor.toString());
                    }else{
                        $('.choice_box .btn_minor span').text($('.popup_type .choice_area input[name=minor]').eq(0).siblings('span').text());
                    }
                    page = 0;

                    // 멘토링 설정
                    paramOpt_lesson.lessonAreaCdList = minorVal.length > 0 ? minorVal : [areaVal];
                    // 멘토링 리스트 설정
                    $("#lessonList").empty();
                    getMentorList(page, "LESSON", "#lessonList", paramOpt_lesson);
                    $('.popup_type').removeClass('open');
                });

                // 팝업 닫기 버튼 클릭시 동작
                $('.popup_type .btn_box .btn_cancel').text('전체 초기화');
                $('.popup_type .btn_box .btn_cancel').unbind().bind('click', function(){
                    minorVal = [];
                    $('.choice_box .btn_minor span').text($('.popup_type div.choice_area input[name=minor]:eq(0)').siblings('span').text());
                    minorVal.push($('.popup_type div.choice_area input[name=minor]:eq(0)').val());
                    page = 0;

                    // 멘토링 설정
                    paramOpt_lesson.lessonAreaCdList = minorVal.length > 0 ? minorVal : [areaVal];
                    // 멘토링 리스트 설정
                    $("#lessonList").empty();
                    getMentorList(page, "LESSON", "#lessonList", paramOpt_lesson);
                    $('.popup_type').removeClass('open');
                });

                $('.popup_type').addClass('open');
            }
        })
    });

    /**
     * 상세 조건 검색
     */
    $('.btn_choice').unbind().bind('click', function(){
        $('.rwd_popup_search').show();
        // 멘토링
        var title = '';
        var tmplId = '';
        if(path.indexOf(contextPath + "/intro/mentoring") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 1)) {
            title = '멘토링 상세조건 <span>멘토링 문의를 기다리고 있습니다.</span>';
            tmplId = '#mentoringDetailSearchTmpl';
            SEARCH_TYPE = 'MENTORING';
        }else if(path.indexOf(contextPath + "/intro/lesson") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 2)){
            title = '과외 상세조건 <span>과외 문의를 기다리고 있습니다.</span>';
            tmplId = '#lessonDetailSearchTmpl';
            SEARCH_TYPE = 'LESSON';
        }

        /* 검색 공통 설정 내용 */
        $('#searchTitle').empty().append(title);
        $('.rwd_popup_search .tab_cont .cont_01').empty();
        $('.rwd_popup_search .cont_02 .condition_mentoList').empty();
        $(tmplId).tmpl().appendTo('.rwd_popup_search .tab_cont .cont_01');

        // 대학교 설정
        codeApi.retrieveSchool({searchKey:"", searchCd: 3}, function (code, data) {
            if(code === 0) {
                schoolArr = data;

                // 학교 설정 Event
                $(".rwd_popup_search input[name=school_input]").unbind().bind('keyup', function(){
                    $('.rwd_popup_search .university_search').empty();
                    var $this = $(this);
                    var result = schoolArr.filter(function(item){
                        return tms.isNotEmpty(item.schoolNm) && item.schoolNm.startsWith($this.val());
                    });

                    if(result.length > 0){
                        result.forEach(function(item){
                            $('.rwd_popup_search .university_search').append('<li data-no="'+item.partyNo+'">'+item.schoolNm+'</li>');
                        });
                        $('.rwd_popup_search .university_search li').unbind().bind('click', function(){
                            var $clickObj = $(this);

                            // 관심대학 중복 확인
                            var isChk = true;
                            if($('.rwd_popup_search .university_list span.uni').length > 0) {
                                $('.rwd_popup_search .university_list span.uni').each(function () {
                                    if ($(this).data('schoolno') === $clickObj.data('no')) {
                                        isChk = false;
                                    }
                                });
                            }
                            // 관심 대학 추가
                            if(isChk){
                                $('.rwd_popup_search .university_list').append('<a href="#self"><span class="uni" data-schoolno="'+$(this).data("no")+'">'+$(this).text()+'</span><span class="btn_close" onclick="removeUni($(this))"></span></a>')
                            }
                            $('.rwd_popup_search .university_search').empty();
                            $('.rwd_popup_search input[name=school_input]').val('');
                        });
                    }
                });
            }
        });

        /** 검색 팝업 탭 Event **/
        // 닉네임 검색 탭 클릭
        $('.rwd_popup_search .btn_tab .nickname').unbind().bind('click', function(){
            $('.rwd_popup_search .btn_tab a').removeClass('on');
            $('.rwd_popup_search .tab_cont div').removeClass('on');

            $('.rwd_popup_search .btn_tab .nickname').addClass('on');
            $('.rwd_popup_search .tab_cont .cont_02').addClass('on');
            searchTabIdx = 1;
            $('.search_btn_box').hide();
        });

        // 상세 검색 탭 클릭
        $('.rwd_popup_search .btn_tab .detail').unbind().bind('click', function(){
            $('.rwd_popup_search .btn_tab a').removeClass('on');
            $('.rwd_popup_search .tab_cont div').removeClass('on');

            $('.rwd_popup_search .btn_tab .detail').addClass('on');
            $('.rwd_popup_search .tab_cont .cont_01').addClass('on');
            searchTabIdx = 0;
            $('.search_btn_box').show();
        });

        /** 상세 검색 내용 초기화 **/
        $('.rwd_popup_search #search_clean').unbind().bind('click', function(){
            $('.rwd_popup_search .search_box').val('');
            $('.rwd_popup_search .departmentLineArea input[type=checkbox]').each(function(){
                $(this).prop('checked', false);
            });
            $('.rwd_popup_search #morning td span.on, .rwd_popup_search #afternoon td span.on').each(function(){
                $(this).parent('td').empty();
            });
            $('.rwd_popup_search #condition_subject input[type=checkbox]').each(function() {
                $(this).prop('checked', false);
            });
            $('.rwd_popup_search .university_list').empty();

            //적용하기 버튼 클릭 이벤트
            $(".rwd_popup_search #search_ok").trigger("click");
        });

        /** 닉네임 검색 **/
        $('.rwd_popup_search .cont_02 .search_btn').unbind().bind('click', function(){
            nickSearchPage = 0;
            nickSearchLast = false;

            $('.rwd_popup_search .cont_02 .condition_mentoList').empty();
            getSearchListByNickname();

            $('.rwd_popup_search .in_box').unbind().bind('scroll', function(){
                var $this = $(this);
                if($this.scrollTop() + 557 > $('.rwd_popup_search .inner_box').height() && !nickSearchLast){
                    nickSearchPage+=36;
                    getSearchListByNickname();
                }
            });

        });

        /** 상세 검색하기 **/
        $('.rwd_popup_search #search_ok').unbind().bind('click', function() {
            if(path.indexOf(contextPath + "/intro/mentoring") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 1)){
                departmentLineVal = [];
                universityList = [];
            }else if(path.indexOf(contextPath + "/intro/lesson") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 2)){
                departmentLineVal_lesson = [];
                universityList2_lesson = [];
            }
            page = 0;
            nickNm = '';
            daysList = [];
            subjectList = [];

            if(path.indexOf(contextPath + "/intro/mentoring") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 1)){
                // 학과계열 설정
                $('.rwd_popup_search .departmentLineArea input[name=departmentLine]').each(function () {
                    if ($(this).is(':checked')) {
                        departmentLineVal.push($(this).val());
                    }
                });

                // 관심 대학
                $('.rwd_popup_search .university_list span.uni').each(function(){
                    universityList.push($(this).data('schoolno'));
                });
            }else if(path.indexOf(contextPath + "/intro/lesson") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 2)){
                // 학과계열 설정
                $('.rwd_popup_search .departmentLineArea input[name=departmentLine]').each(function () {
                    if ($(this).is(':checked')) {
                        departmentLineVal_lesson.push($(this).val());
                    }
                });

                // 관심 대학
                $('.rwd_popup_search .university_list span.uni').each(function(){
                    universityList2_lesson.push($(this).data('schoolno'));
                });

                // 과외 가능한 요일
                $('.rwd_popup_search #morning td span.on, .rwd_popup_search #afternoon td span.on').each(function(){
                    daysList.push($(this).parent('td').data('no'));
                });

                // 과목
                $('.rwd_popup_search #condition_subject input[type=checkbox]:checked').each(function(){
                    subjectList.push($(this).val());
                });
            }

            // 멘토링 리스트 설정
            if(path.indexOf(contextPath + "/intro/mentoring") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 1)){
                paramOpt.universityPartyNoList = universityList.length > 0 ? universityList : [];
                paramOpt.departmentLineCdList = departmentLineVal.length > 0 ? departmentLineVal : [];

                $("#mentoringList").empty();
                getMentorList(page, "MENTORING", "#mentoringList", paramOpt);
            // 과외 리스트 설정
            }else if(path.indexOf(contextPath + "/intro/lesson") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 2)){
                paramOpt_lesson.universityPartyNoList = universityList2_lesson.length > 0 ? universityList2_lesson : [];
                paramOpt_lesson.departmentLineCdList = departmentLineVal_lesson.length > 0 ? departmentLineVal_lesson : [];
                paramOpt_lesson.lessonDayCdList = daysList.length > 0 ? daysList : [];
                paramOpt_lesson.subjectNoList = subjectList.length > 0 ? subjectList : [];

                $("#lessonList").empty();
                getMentorList(page, "LESSON", "#lessonList", paramOpt_lesson);
            }
            $('.rwd_popup_search').removeClass('open');
        });

        /** 검색 UI 초기 설정 (값 유지 용) **/
        $('.rwd_popup_search .condition_content input[name=nickNm]').val(nickNm);
        if(path.indexOf(contextPath + "/intro/mentoring") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 1)){
            // 학과계열 설정
            codeApi.getRetrieveCd2({categoryNo:"17"},function(code, data, res){
                if(code === 0){
                    // 학과계열 설정
                    data.forEach(function(item){
                        $(".rwd_popup_search .departmentLineArea").append('<li><label class="checkbox style_01"><input type="checkbox" name="departmentLine" value="'+item.codeNo+'"><span>'+item.codeNm+'</span></label></li>');
                    });

                    // 학과계열 체크박스 초기 설정
                    departmentLineVal.forEach(function(item) {
                        $('.rwd_popup_search .departmentLineArea input[name=departmentLine]').each(function() {
                            if($(this).val().toString() === item.toString()){
                                $(this).prop('checked', true);
                            }
                        });
                    });

                    // 관심대학 초기 설정
                    universityList.forEach(function(item) {
                        schoolArr.forEach(function(school) {
                            if(item === school.partyNo){
                                $('.rwd_popup_search .university_list').append('<a href="#self"><span class="uni" data-schoolno="'+school.partyNo+'">'+school.schoolNm+'</span><span class="btn_close" onclick="removeUni($(this))"></span></a>')
                            }
                        });
                    });
                }
            });
        }else if(path.indexOf(contextPath + "/intro/lesson") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 2)){
            // 학과계열 설정
            codeApi.getRetrieveCd2({categoryNo:"2, 16, 17"},function(code, data, res){
                if(code === 0){
                    var days = ['월', '화', '수', '목', '금', '토', '일'];

                    // 학과계열 설정
                    data.forEach(function(item){
                        if(item.categoryNo === 17){
                            $(".rwd_popup_search .departmentLineArea").append('<li><label class="checkbox style_01"><input type="checkbox" name="departmentLine" value="'+item.codeNo+'"><span>'+item.codeNm+'</span></label></li>');
                        }

                        /* 검색 추가 설정 내용 (과외) */
                        if(path.indexOf(contextPath + "/intro/lesson") !== -1 || (path.indexOf(contextPath + "/app") !== -1 && tabIdx === 2)){
                            if(item.categoryNo === 16 && item.codeValue === '오전'){
                                switch (item.codeNm) {
                                    case days[0]: $('.rwd_popup_search #morning td').eq(1).attr('data-no', item.codeNo); break;
                                    case days[1]: $('.rwd_popup_search #morning td').eq(2).attr('data-no', item.codeNo); break;
                                    case days[2]: $('.rwd_popup_search #morning td').eq(3).attr('data-no', item.codeNo); break;
                                    case days[3]: $('.rwd_popup_search #morning td').eq(4).attr('data-no', item.codeNo); break;
                                    case days[4]: $('.rwd_popup_search #morning td').eq(5).attr('data-no', item.codeNo); break;
                                    case days[5]: $('.rwd_popup_search #morning td').eq(6).attr('data-no', item.codeNo); break;
                                    case days[6]: $('.rwd_popup_search #morning td').eq(7).attr('data-no', item.codeNo); break;
                                }
                            }else if(item.categoryNo === 16 && item.codeValue === '오후'){
                                switch (item.codeNm) {
                                    case days[0]: $('.rwd_popup_search #afternoon td').eq(1).attr('data-no', item.codeNo); break;
                                    case days[1]: $('.rwd_popup_search #afternoon td').eq(2).attr('data-no', item.codeNo); break;
                                    case days[2]: $('.rwd_popup_search #afternoon td').eq(3).attr('data-no', item.codeNo); break;
                                    case days[3]: $('.rwd_popup_search #afternoon td').eq(4).attr('data-no', item.codeNo); break;
                                    case days[4]: $('.rwd_popup_search #afternoon td').eq(5).attr('data-no', item.codeNo); break;
                                    case days[5]: $('.rwd_popup_search #afternoon td').eq(6).attr('data-no', item.codeNo); break;
                                    case days[6]: $('.rwd_popup_search #afternoon td').eq(7).attr('data-no', item.codeNo); break;
                                }
                            }

                            // 부모 과목 설정
                            if(item.categoryNo === 2 && item.parentNo === 0){
                                $(".rwd_popup_search #condition_subject").append('<div class="condition_content" data-subjectNo="'+item.codeNo+'"><div class="txt">'+item.codeNm+'</div><ul></ul></div>')
                            }

                            // 자식 과목 설정
                            if(item.categoryNo === 2 && item.parentNo !== 0){
                                $(".rwd_popup_search #condition_subject .condition_content").each(function() {
                                    if($(this).data('subjectno') === item.parentNo){
                                        $(this).find('ul').append('<li><label class="checkbox style_01"><input type="checkbox" name="subject" value="'+item.codeNo+'"><span>'+item.codeNm+'</span></label></li>')
                                    }
                                });
                            }
                        }
                    });

                    // 학과계열 체크박스 초기 설정
                    departmentLineVal_lesson.forEach(function(item) {
                        $('.rwd_popup_search .departmentLineArea input[name=departmentLine]').each(function() {
                            if($(this).val().toString() === item.toString()){
                                $(this).prop('checked', true);
                            }
                        });
                    });

                    // 관심대학 초기 설정
                    universityList2_lesson.forEach(function(item) {
                        schoolArr.forEach(function(school) {
                            if(item === school.partyNo){
                                $('.rwd_popup_search .university_list').append('<a href="#self"><span class="uni" data-schoolno="'+school.partyNo+'">'+school.schoolNm+'</span><span class="btn_close" onclick="removeUni($(this))"></span></a>')
                            }
                        });
                    });

                    // 요일 초기 설정
                    daysList.forEach(function(item) {
                        $('.rwd_popup_search #morning td, .rwd_popup_search #afternoon td').each(function(){
                            if($(this).data('no') === item){
                                $(this).append('<span class="on"></span>');
                            }
                        });
                    });

                    // 과목 초기설정
                    subjectList.forEach(function(item){
                        $('.rwd_popup_search #condition_subject input[type=checkbox]').each(function() {
                            if($(this).val() === item){
                                $(this).prop('checked', true);
                            }
                        })
                    });

                    // 과외 Event 기능 추가
                    $('.rwd_popup_search #morning td, .rwd_popup_search #afternoon td').unbind().bind('click', function(){
                        if($(this).find('span').length === 0){
                            $(this).append('<span class="on"></span>');
                        }else{
                            $(this).empty();
                        }
                    });
                }
            });
        }
        $('.rwd_popup_search').addClass('open');
    });
});

var controlHeight = function(cnt) {
    if ( cnt > 3 ) {
        var height = ((cnt - 3) * 33) + 240;
        if ( height > window.innerHeight ) {
            height = window.innerHeight - 128;
            $('.popup_all .popup_type .in_box::-webkit-scrollbar').css("display", "initial");
        }

        $('.popup_all .popup_type .inner_box').css("height", height+"px");
    }
    else {
        $('.popup_all .popup_type .inner_box').css("height", "240px");
    }
}

// 관심대학 삭제eurodb
var removeUni = function($obj){
    $obj.parent('a').remove();
}

var getSearchListByNickname = function(){
    var param = {
        start : nickSearchPage,
        searchTypeCd : 'MENTOR',
        nickname : $(".rwd_popup_search .cont_02 input[name=nickNm]").val()
    };

    consultApi.getSearchListByNickname(param, null, function(code, data, res){
        if(code === 0){
            if(tms.isNotEmpty(data)){
                $("#nickNmSearchTmpl").tmpl(data.searchList).appendTo('.rwd_popup_search .cont_02 .condition_mentoList');

                // 클릭 이벤트
                $('.rwd_popup_search .cont_02 .condition_mentoList .profile_area').unbind().bind("click", function(){
                    $(".rwd_popup_mentoring").addClass("open");
                    var hipId = $(this).data("no");
                    getMentorProfile(hipId, SEARCH_TYPE);
                    getMentorInfo(hipId);
                });
            }else{
                nickSearchLast = true;
            }
        }
    });
}
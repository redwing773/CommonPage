<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 멘톡칼럼 리스트 -->
<script id="mentalkListTmpl" type="text/x-jquery-tmpl">
    <li>
        <div class="mentalkList" data-No="\${channelNo}">
            {{if profileResourceUri != ""}}
                <div class="photo" style="background: url(\${profileResourceUri}) center center no-repeat; background-size:cover"></div>
            {{else}}
                {{if resourceUri != ""}}
                    <div class="photo" style="background: url(\${resourceUri}) center center no-repeat; background-size:cover"></div>
                {{else}}
                    <div class="photo"></div>
                {{/if}}
            {{/if}}
            <div class="tit">\${title}</div>
            <ul class="txt">
                <li>\${universityNm} \${majorNm}</li>
                <li>\${studentId}</li>
                <li>\${acceptanceLine}</li>
            </ul>
            <div class="name">\${nickname}</div>
            <div class="date">\${startDate}~\${endDate}</div>
            <div class="count">\${viewNumber}</div>
        </div>
    </li>
</script>

<!-- 멘톡칼럼 리스트 -->
<script id="mentalkListTmpl2" type="text/x-jquery-tmpl">
    <li>
		<div class="mentalkList goColumnDetail\${talkNo}" data-no=\${talkNo}>
			{{if profileResourceUri != ""}}
                <div class="photo" style="background: url(\${profileResourceUri}) center center no-repeat; background-size:cover"></div>
            {{else}}
                {{if resourceUri != ""}}
                    <div class="photo" style="background: url(\${resourceUri}) center center no-repeat; background-size:cover"></div>
                {{else}}
                    <div class="photo"></div>
                {{/if}}
            {{/if}}
			<div class="tit">\${talkTitle}</div>
			<ul class="txt">
				<li>\${universityNm} \${majorNm}</li>
                <li>\${studentId}</li>
                <li>\${acceptanceLine}</li>
			</ul>
			<div class="name">\${nickname}</div>
			<div class="mentalkStatus">
            	<div class="date">\${regDt}</div>
            	{{if viewCnt > 0}}
				<div class="count ml0">\${viewCnt}</div>
				{{/if}}
				{{if replyCnt > 0}}
				<div class="replyCount ml0">\${replyCnt}</div>
				{{/if}}
			</div>
		</div>
	</li>
</script>

<!-- 멘톡칼럼 리스트 (커밍순) -->
<script id="mentalkComingListTmpl" type="text/x-jquery-tmpl">
    <li style="position: relative;">
        <span class="column_comingsoon"></span>
        <span class="column_comingsoon_bg"></span>
        <span class="column_comingsoon_date">너만 몰랐던 수능 D-50 합격 전략</span>
		<div class="mentalkList comingsoon" data-no=\${talkNo}>
			{{if profileResourceUri != ""}}
                <div class="photo" style="background: url(\${profileResourceUri}) center center no-repeat; background-size:cover"></div>
            {{else}}
                {{if resourceUri != ""}}
                    <div class="photo" style="background: url(\${resourceUri}) center center no-repeat; background-size:cover"></div>
                {{else}}
                    <div class="photo"></div>
                {{/if}}
            {{/if}}
			<div class="tit">\${talkTitle}</div>
			<ul class="txt">
				<li>\${universityNm} \${majorNm}</li>
                <li>\${studentId}</li>
                <li>\${acceptanceLine}</li>
			</ul>
			<div class="name">\${nickname}</div>
		</div>
	</li>
</script>

<script id="mentalkDetailPopupTmpl" type="text/x-jquery-tmpl">
	<div class="mentalk_profile mb15">
		{{if resourceUri != ''}}
			<div class="profileImg">
				<img src=\${resourceUri} style=""></div>
		{{else}}
			<div class="profileImg">
				<img src="${pageContext.request.contextPath}/apps/images/ico_37.png"></div>
		{{/if}}
		<div class="nickname" data-no="\${hipId}">\${nickname}</div>
<%--		<div class="propose pl5 pr5">문의하기</div>--%>
		<div class="regDt">\${regDt}</div>
		<div class="badge">멘토</div>
	</div>
	<div class="mentalk_tit">\${talkTitle}</div>
	<div class="mentalk_con">\${talkContent}</div>
</script>

<!-- 멘톡칼럼 QnA 팝업 -->
<script id="mentalkQnaPopupTmpl" type="text/x-jquery-tmpl">
    <div class="txt_box">
        <div class="q">
            <p class="no">Q\${no}</p>
            <p class="txt">\${title}</p>
        </div>
        <div class="a">
            <div class="profile">
                <div class="inner">
                    <span class="label bg_blue">멘토</span>
                    <span class="name">\${nickname}</span>

                   {{if profileResourceUri != null && profileResourceUri != ""}}
                        <span class="photo" style="background: url(\${profileResourceUri}) center center no-repeat; background-size:cover">\${profileResourceUri}</span>
                    {{else}}
                        <span class="photo"></span>
                    {{/if}}
                </div>
            </div>
            <p class="txt">\${contents}</p>
            <p class="time">\${createDate}</p>
        </div>
    </div>
</script>

<!-- 멘토 리스트 (멘토링 & 과외) -->
<script id="mentorListTmpl" type="text/x-jquery-tmpl">
    <li>
        <div class="mentorList" data-no=\${hipId}>
            <div class="photo_box">
                {{if deviceType != "P" && !(headerDeviceType == null || headerDeviceType == "")}}
                    {{if resourceUri != null && resourceUri != ""}}
                        <div class="photo lazyload" data-background="\${resourceUri}" style="background: url(/apps/images/ico_37.png) center center no-repeat; background-size:cover">\${profileResourceUri}</div>
                    {{else}}
                        <div class="photo"></div>
                    {{/if}}
                {{else}}
                    {{if resourceUri != null && resourceUri != ""}}
                        <div class="photo" style="background: url(\${resourceUri}) center center no-repeat; background-size:cover">\${profileResourceUri}</div>
                    {{else}}
                        <div class="photo"></div>
                    {{/if}}
                {{/if}}

                <div class="label">
                    {{if contentsYn}}
                        <span class="red">{{if srSamplingYn}}<img class="mat" src="${pageContext.request.contextPath}/pc/images/ic_mat.png" alt="">{{/if}}생기부</span>
                    {{/if}}
                    {{if lessonCount > 99}}
                        <span class="mint">과외99+</span>
                    {{else lessonCount > 0}}
                        <span class="mint">과외 \${lessonCount}건</span>
                    {{/if}}
                    {{if selfReportYn}}
                        <span class="purple">자소서</span>
                    {{/if}}
                </div>
            </div>
            <div class="name">\${nickname}</div>
            <ul class="txt_info_01">
                <li>\${universityNm} \${majorNm}</li>
                <li>\${studentId}학번</li>
            </ul>
            {{if listType == "LESSON"}}
                <div class="txt_info_02">\${subjectList}</div>
            {{else}}
                <div class="txt_info_02" style="margin-bottom:0px;">
                    합격 유형 사례 :
                        {{if fixed > 0}}
                            정시 \${fixed} 건
                        {{/if}}
                        {{if nonscheduled > 0}}
                            수시 \${nonscheduled} 건
                        {{/if}}
                        {{if paper > 0}}
                            , 서류 \${paper} 건
                        {{/if}}
                </div>
            {{/if}}
            {{if listType == "MENTORING"}}
                <ul class="txt_info_03">
                    <li>생활기록부 : \${numberPages}장</li>
                    <li>수상내역 : \${numberAward}건</li>
                </ul>
            {{/if}}
            <ul class="txt_info_04">
                <li>\${acceptanceLine}</li>
                <li>\${acceptance}</li>
            </ul>
        </div>
    </li>
</script>


<!-- 멘토링 상세 검색 -->
<script id="mentoringDetailSearchTmpl" type="text/x-jquery-tmpl">
    <div class="table_box">
        <div class="condition_title">관심대학</div>
        <div class="condition_content">
            <input type="text" class="search_box" name="school_input" placeholder="멘토의 대학교 검색" autocomplete="off">
        </div>
        <div style="max-height:100px; overflow:auto; background-color: #f5f5f5; margin-top: -10px; padding-left: 15px;">
            <ul class="list-group university_search">
            </ul>
        </div>
        <div class="condition_list university_list">
       </div>
    </div>
    <div class="table_box">
        <div class="condition_title">학과계열</div>
        <div class="condition_content">
            <ul class='departmentLineArea'></ul>
        </div>
    </div>
</script>



<!-- 과외 상세 검색 -->
<script id="lessonDetailSearchTmpl" type="text/x-jquery-tmpl">
    <div class="table_box">
        <div class="condition_title">학과계열</div>
        <div class="condition_content">
            <ul class='departmentLineArea'></ul>
        </div>
    </div>
    <div class="table_box">
        <div class="condition_title">관심대학</div>
        <div class="condition_content">
            <input type="text" class="search_box" name="school_input" placeholder="멘토의 대학교 검색" autocomplete="off">
        </div>
        <div style="max-height:100px; overflow:auto; background-color: #f5f5f5; margin-top: -10px; padding-left: 15px;">
            <ul class="list-group university_search">
            </ul>
        </div>
        <div class="condition_list university_list">
       </div>
    </div>
    <div class="table_box">
        <div class="condition_title">과외 가능 요일</div>
        <div class="condition_content">
            <table cellpadding="0" cellspacing="0" class="table">
                <colgroup>
                    <col style="width:auto;">
                    <col style="width:12.5%;">
                    <col style="width:12.5%;">
                    <col style="width:12.5%;">
                    <col style="width:12.5%;">
                    <col style="width:12.5%;">
                    <col style="width:12.5%;">
                    <col style="width:12.5%;">
                </colgroup>
                <thead>
                <tr>
                    <th scope="col"></th>
                    <th scope="col">월</th>
                    <th scope="col">화</th>
                    <th scope="col">수</th>
                    <th scope="col">목</th>
                    <th scope="col">금</th>
                    <th scope="col">토</th>
                    <th scope="col">일</th>
                </tr>
                </thead>
                <tbody>
                <tr id="morning">
                    <td>오전</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr id="afternoon">
                    <td>오후</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <%--<td><span class="on"></span></td>--%>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="table_box">
        <div class="condition_title">과목</div>
        <div id="condition_subject">

        </div>
    </div>
</script>

<script id="nickNmSearchTmpl" type="text/x-jquery-tmpl">
    <a href="#self" class="profile_area" data-no=\${hipId}>
        <div class="photo_box">
            {{if resourceUri != ""}}
                <div class="photo"><img src="\${resourceUri}" alt=""></div>
            {{else}}
                <div class="photo"><img src="../../pc/images/sample_profile_01.png" alt=""></div>
            {{/if}}
        </div>
        <div class="name_box">
            <span class="name">\${nickname}</span>
        </div>
        <div class="txt_box">\${universityNm}</div>
    </a>
</script>

<script id="mentalkUniversityListTmpl" type="text/x-jquery-tmpl">
    <label class="select_radiobox style_01 mb10"><input type="radio" name="universityPartyNo" value="\${universityPartyNo}"/><em></em><span>\${universityPartyNm}</span></label>
</script>

<script id="mentalkAdmissionListTmpl" type="text/x-jquery-tmpl">
    <label class="select_radiobox style_01 mb10"><input type="radio" name="admissionTypeCd" value="\${admissionTypeCd}"/><em></em><span>\${admissionTypeNm}</span></label>
</script>

<script id="mentalkCategoryListTmpl" type="text/x-jquery-tmpl">
    <label class="select_radiobox style_01 mb10"><input type="radio" name="mentalkCategoryNo" value="\${mentalkCategoryNo}"/><em></em><span>\${mentalkCategoryNm}</span></label>
</script>

<script id="searchNoDataTmpl" type="text/x-jquery-tmpl">
    <li id="mentoListNoData"><div>조회된 결과가 없습니다.</div></li>
</script>

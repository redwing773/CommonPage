<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 멘토 상세팝업 (프로필) -->
<script id="mentorPopupProfileTmpl" type="text/x-jquery-tmpl">
    <div class="photo_box">
		{{if resourceUri}}
		<div class="photo"><img src="\${resourceUri}" alt=""></div>
		{{else}}
		<div class="photo"><img src="${pageContext.request.contextPath}/pc/images/ico_37.png" alt=""></div>
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
    <div class="name_box">
        <span class="name">\${nickname}</span>
        <span class="label">\${acceptanceLine}</span>
        <span class="label">\${acceptance}</span>
    </div>
    <ul class="txt_info_01">
        <li>\${universityNm} \${majorNm}</li>
        <li>\${studentId}학번</li>
    </ul>
    <div class="txt_info_02">
	출신고교 : \${areaSchoolNm} <br>
	합격 유형 사례 : 정시 \${fixed}건, 수시 \${nonscheduled}건</div>
    <div class="txt_info_03">
        <span class="txt_01">생활기록부 \${numberPages}장</span>
        <span class="txt_02">수상내역 \${numberAward}개</span>
    </div>
</script>

<!-- 멘토 상세팝업 (멘토링) -->
<script id="mentorPopupMentoringTmpl" type="text/x-jquery-tmpl">
    <li class="case_02">
        <span class="name">\${universityNm}</span>
        <span class="txt">
            \${departmentLine} <br>
            \${majorNm}
        </span>
        <ul class="label">
            <li><span>\${acceptance}</span></li>
            <li><span>\${acceptance2}</span></li>
        </ul>
    </li>
</script>

<!-- 멘토 상세팝업 (과외 Base) -->
<script id="mentorPopupLessonTmpl" type="text/x-jquery-tmpl">
    <div>
        <p class="title">과외 가능과목</p>
        <ul id="subjecetList" class="txt_01">
        </ul>
    </div>
    <div>
        <p class="title">과외 가능 지역</p>
        <p class="txt_02">\${areaList}</p>
    </div>
    <div>
        <p class="title">과외 가능 요일</p>
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
            <tbody id="areaChk">
            <tr>
                <td>오전</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>오후</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            </tbody>
        </table>
    </div>
    <div>
        <div class="txt_03">
            <p class="title">과외 횟수 시간</p>
            <p class="txt"><span>\${timesNm},</span> \${hoursNm}</p>
        </div>
    </div>
    <div>
        <div class="txt_04">
            <p class="title">희망과외비</p>
            <p class="txt">\${costNm}</p>
        </div>
    </div>
    <div>
        <p class="title">과외경력</p>
        <div id="careerList" class="txt_06">
        </div>
    </div>
    <div>
        <p class="title">수업방식</p>
        <p class="txt_07">\${teachingStyle}</p>
    </div>
</script>

<!-- 멘토 상세팝업 (과외 과목) -->
<script id="mentorPopupLessonTmpl" type="text/x-jquery-tmpl">
    <div>
        <p class="title">과외 가능과목</p>
        <ul class="txt_01">
            <li><span>수학</span>초등,  중등,  고등(공통),  고등(문과), 고등(이과),  편입, 초등,  중등,  고등(공통),  고등(문과), 고등(이과),  편입 </li>
            <li><span>영어</span>초등,  중등,  고등(공통),  고등(문과), 고등(이과),  편입, 초등,  중등,  고등(공통),  고등(문과), 고등(이과),  편입 </li>
        </ul>
    </div>
</script>
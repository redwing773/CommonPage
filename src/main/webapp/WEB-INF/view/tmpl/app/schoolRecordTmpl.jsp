<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script id="userInfoTmpl" type="text/x-jquery-tmpl">
	<h2 class="txt_20 fw_700 mb20">회원가입 축하 이벤트!</h2>
	<h2 class="txt_17 fw_700 mb20">\${nickname}님의 생기부 열람 비용을<br>링커가 대신 지불합니다</h2>
	<h3 class="txt_15 fw_500 mb10">입력하신 희망 계열, 멘토링 정보로<br>생기부를 추천합니다</h3>
	<p class="txt_13 c_red_02 mb34">해당 창을 닫으시면 생기부를 열람할 수 없습니다</p>
</script>

<script id="userInfoTmpl2" type="text/x-jquery-tmpl">
	<h3 class="txt_15 fw_500">\${nickname}님을 위한 추천 생기부</h3>
	<p class="txt_13 mb10">원하는 생기부를 <span class="txt_13 fw_500 salmon">'클릭'</span>하세요 </p>
</script>

<script id="eventUserInfoTmpl" type="text/x-jquery-tmpl">
	<img src="https://d9f2e26giax13.cloudfront.net/etc/295cd251be8945acb560c8fd57354405.png" class="imgCongratulation">
	<h2 class="txt_20 fw_700">\${nickname}님!</h2>
	<h3 class="txt_17 fw_700 mb10">생기부 열람 이벤트에 당첨되셨습니다.<h3>
	<h3 class="txt_17 fw_500 mb40">생기부 열람 비용을 링커가 대신 지불합니다.</h3>
	<h3 class="txt_15 fw_500 mb34" style="text-decoration:underline;">단, <span style="color:#c81833;">당첨을 취소</span>하려면 페이지를 닫으세요</h3>
</script>

<script id="eventUserInfoTmpl2" type="text/x-jquery-tmpl">
	<h3 class="txt_15 fw_500">\${nickname}님을 위한 추천 생기부</h3>
	<p class="txt_13 mb10">원하는 생기부를 <span class="txt_13 fw_500" style="color:#f57062;">'클릭'</span>하세요 </p>
</script>

<script id="eventWordCloudUserInfoTmpl" type="text/x-jquery-tmpl">
	<img src="https://d9f2e26giax13.cloudfront.net/etc/295cd251be8945acb560c8fd57354405.png" class="imgCongratulation">
	<h2 class="txt_20 fw_700">오늘도 로그인하신 \${nickname}님!</h2>
	<h3 class="txt_17 fw_700 mb20">생기부 열람 <span class="c_red_02" style="text-decoration:underline;">수시 이벤트</span>에 당첨되셨습니다!</h3>
	<h3 class="txt_15 fw_500 mb34" style="text-decoration:underline;">단, <span style="color:#c81833;">당첨을 취소</span>하려면 페이지를 닫으세요</h3>
</script>

<script id="eventWordCloudUserInfoTmpl2" type="text/x-jquery-tmpl">
	<h3 class="txt_15 fw_500">\${nickname}님을 위한 추천 생기부</h3>
	<p class="txt_13 mb10">원하는 생기부를 <span class="txt_13 fw_500 salmon">'클릭'</span>하세요 </p>
</script>

<script id="getRecommendTmpl" type="text/x-jquery-tmpl">
	<div class="card" onClick="fnOpenSchoolRecord(this, '\${hipId}');">
		<p class="schoolRecordYear">\${admissionYear} \${universityNm} \${admissionNm}</p>
		<span class="schoolRecordNum txt_11">총 \${numberPages}장</span>
		<p class="txt_13 fw_500 mt15 pl5">\${universityNm} \${majorNm}</p>
		<p class="txt_13 fw_500 mt11 pl5">\${acceptance} {{if acceptanceLine != null}}<span>\${acceptanceLine}</span>{{/if}}</p>
		<p class="txt_13 mt11 pl5">\${areaSchoolNm}</p>
		<p class="txt_11 fw_500 mt11 pl5">\${admissionInfo}</p>
	</div>
</script>

<script id="specialPackageInfoTmpl" type="text/x-jquery-tmpl">
<div class="mentorInfo_content">
	<p class="university txt_141 fw_500">\${universityNm} \${majorNm} | \${studentId}학번</p>
	<p class="highshcool txt_141">출신고교 : \${areaSchoolNm}</p>
	<div class="summaryInfo">
		{{if numberPages > 0}}
		<div class="summaryInfo_numberPages">
			<img src="${pageContext.request.contextPath}/apps/images/ic_numberPages.png">
			<p class="txt_12">생기부: \${numberPages}장</p>
		</div>
		{{/if}}
		{{if numberAward > 0}}
		<div class="summaryInfo_reward">
			<img src="${pageContext.request.contextPath}/apps/images/ic_medal.png">
			<p class="txt_12">수상내역: \${numberAward}개</p>
		</div>
		{{/if}}
		<div class="summaryInfo_view" onclick="allForView(this);">
			<p class="toggle_allForView txt_13">항목 전체 보기</p>
			<img class="toggle_dropDown" src="${pageContext.request.contextPath}/apps/images/ic_arrow_drop_down.png">
		</div>
	</div>
</div>
</script>

<script id="specialPackageInfoTmpl2" type="text/x-jquery-tmpl">
<div class="mentorInfo_content">
	<p class="university txt_141 fw_500">\${universityNm} \${majorNm} | \${studentId}학번</p>
	<p class="highshcool txt_141">출신고교 : \${areaSchoolNm}</p>
	<div class="summaryInfo">
		{{if numberPages > 0}}
		<div class="summaryInfo_numberPages">
			<img src="${pageContext.request.contextPath}/apps/images/ic_numberPages.png">
			<p class="txt_12">생기부: \${numberPages}장</p>
		</div>
		{{/if}}
		{{if numberAward > 0}}
		<div class="summaryInfo_reward">
			<img src="${pageContext.request.contextPath}/apps/images/ic_medal.png">
			<p class="txt_12">수상내역: \${numberAward}개</p>
		</div>
		{{/if}}
	</div>
</div>
</script>

<script id="specialExampleTmpl" type="text/x-jquery-tmpl">
<div class="mentorInfo_content">
	<p class="university txt_141 fw_500">\${universityNm} \${majorNm} | \${studentId}학번</p>
	<p class="highshcool txt_141">출신고교 : \${areaSchoolNm}</p>
	<div class="summaryInfo">
		{{if numberPages > 0}}
		<div class="summaryInfo_numberPages">
			<img src="${pageContext.request.contextPath}/apps/images/ic_numberPages.png">
			<p class="txt_12">생기부: \${numberPages}장</p>
		</div>
		{{/if}}
		{{if numberAward > 0}}
		<div class="summaryInfo_reward">
			<img src="${pageContext.request.contextPath}/apps/images/ic_medal.png">
			<p class="txt_12">수상내역: \${numberAward}개</p>
		</div>
		{{/if}}
	</div>
</div>
</script>

<script id="mentorPopupProfileTmpl" type="text/x-jquery-tmpl">
    <div class="photo_box">
        <div class="photo">
		{{if resourceUri != ''}}<img src="\${resourceUri}" alt="">
		{{else (resourceUri == '')}}<img src="${pageContext.request.contextPath}/apps/images/ico_37.png" alt="">
		{{/if}}
		</div>
        <div class="label">
            {{if contentsYn}}
                <span class="red">생기부</span>
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
    <div class="txt_info_02">합격 유형 사례 : 
		{{if fixed > 0}}정시 \${fixed}건{{/if}} 
		{{if nonscheduled}}수시 \${nonscheduled}건{{/if}} 
		{{if paper > 0}}서류 \${paper}건{{/if}}
	</div>
    <div class="txt_info_03 pt5">
        {{if numberPages > 0}}<span class="txt_01">생활기록부 : \${numberPages}장</span>{{/if}}
        {{if numberAward > 0}}<span class="txt_02">수상내역 : \${numberAward}개</span>{{/if}}
    </div>
</script>

<script id="mentorPopupProfileTmpl2" type="text/x-jquery-tmpl">
    <div class="photo_box">
        <div class="photo">
		{{if resourceUri != ''}}<img src="\${resourceUri}" alt="">
		{{else (resourceUri == '')}}<img src="${pageContext.request.contextPath}/apps/images/ico_37.png" alt="">
		{{/if}}
		</div>
        <div class="label">
            {{if contentsYn}}
                <span class="red">생기부</span>
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
    <div class="txt_info_02">합격 유형 사례 : 
		{{if fixed > 0}}정시 \${fixed}건{{/if}} 
		{{if nonscheduled}}수시 \${nonscheduled}건{{/if}} 
		{{if paper > 0}}서류 \${paper}건{{/if}}
	</div>
	<div class="summaryInfo">
		{{if numberPages > 0}}
		<div class="summaryInfo_numberPages">
			<%--<img src="${pageContext.request.contextPath}/apps/images/ic_numberPages.png">--%>
			<p class="txt_12">생기부: \${numberPages}장</p>
		</div>
		{{/if}}
		{{if numberAward > 0}}
		<div class="summaryInfo_reward">
			<%--<img src="${pageContext.request.contextPath}/apps/images/ic_medal.png">--%>
			<p class="txt_12">수상: \${numberAward}개</p>
		</div>
		{{/if}}
		<div class="summaryInfo_view" onclick="allForView(this);">
			<p class="toggle_allForView txt_12" style="letter-spacing:-1.5px;">전체 보기</p>
			<img class="toggle_dropDown" src="${pageContext.request.contextPath}/apps/images/ic_arrow_drop_down.png">
		</div>
	</div>
</script>

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

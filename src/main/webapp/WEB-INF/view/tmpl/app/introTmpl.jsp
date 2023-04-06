<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="onGoingColumnIntro" type="text/x-jquery-tmpl">
    <li>
		<div class="photo"><img src="${pageContext.request.contextPath}/\${resourceUri}" alt="" /></div>
		<div class="tit">\${title}</div>
		<ul class="txt">
			<li>서울대 경영학과</li>
			<li>20학번</li>
			<li>재학</li>
		</ul>
		<div class="name">\${nickname}</div>
		<div class="date">04.24~04.30</div>
		<div class="count">14</div>
	</li>
</script>

<script id="intendColumnIntro" type="text/x-jquery-tmpl">
    <li>
		<div class="photo"><img src="${pageContext.request.contextPath}/\${resourceUri}" alt="" /></div>
		<div class="tit">\${title}</div>
		<ul class="txt">
			<li>서울대 경영학과</li>
			<li>20학번</li>
			<li>재학</li>
		</ul>
		<div class="name">\${nickname}</div>
		<div class="date">\${startDate}~\${endDate}</div>
		<div class="count">\${viewNumber}</div>
	</li>
</script>

<script id="mentoringIntro" type="text/x-jquery-tmpl">
    <div class="photo_box">
		<div class="photo"><img src="${pageContext.request.contextPath}/\${resourceUri}" alt="" /></div>
		<div class="label">
		<c:if test="${data.numberPages > 0}">
            <span class="red">생기부</span>
        </c:if>
        <c:if test="${data.lessonCount > 0}">
            <span class="mint">과외+\${lessonCount}</span>
        </c:if>
        <c:if test="${data.paper > 0}">
            <span class="purple">자소서</span>
        </c:if>
		</div>
	</div>
	<div class="name">\${nickname}</div>
	<div class="txt_info_01">멘토</div>
	<ul class="txt_info_02">
		<li>\${universityNm}</li>
		<li>\${studentId}</li>
		<li>\${status}</li>
	</ul>
	<div class="txt_info_03">합격 유형 사례 : 정시 \${nonscheduled}건, 수시 \${fixed}건</div>
	<ul class="txt_info_04">
		<li>생활기록부 : \${numberPages}장</li>
		<li>수상내역 : \${numberAward}건</li>
	</ul>
	<ul class="txt_info_05">
		<li>\${acceptanceLine}</li>
		<li>\${acceptance}</li>
	</ul>
</script>

<script id="lessonIntro" type="text/x-jquery-tmpl">
    <div class="photo_box">
		<div class="photo"><img src="${pageContext.request.contextPath}/\${resourceUri}" alt="" /></div>
		<div class="label">
		<c:if test="${data.numberPages > 0}">
			<span class="red">생기부</span>
        </c:if>
        <c:if test="${data.lessonCount > 0}">
			<span class="mint">과외+\${lessonCount}</span>
        </c:if>
        <c:if test="${data.paper > 0}">
			<span class="purple">자소서</span>
        </c:if>
		</div>
	</div>
	<div class="name">닉네임은여덟글자</div>
	<div class="txt_info_01">멘토</div>
	<ul class="txt_info_02">
		<li>\${universityNm}</li>
		<li>\${studentId}</li>
		<li>\${status}</li>
	</ul>
	<div class="txt_info_03">합격 유형 사례 : 정시 \${nonscheduled}건, 수시 \${fixed}건</div>
	<ul class="txt_info_04">
		<li>생활기록부 : \${numberPages}장</li>
		<li>수상내역 : \${numberAward}건</li>
	</ul>
	<ul class="txt_info_05">
		<li>\${acceptanceLine}</li>
		<li>\${acceptance}</li>
	</ul>
</script>
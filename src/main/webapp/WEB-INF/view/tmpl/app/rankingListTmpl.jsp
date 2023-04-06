<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="rankingTitleTmpl" type="text/x-jquery-tmpl">
	<li data-idx="\${rankingNo}" data-type="\${rankingType}"><a href="javascript:void(0);">\${title}</a></li>
</script>

<script id="rankingListTmpl" type="text/x-jquery-tmpl">
{{if displayOrder <= 3}}
	<li class="rankingList pl10 pr10 pb25 pt25" style="background:rgba(48,44,200,0.1);">
		<p class="grade txt_15">\${displayOrder}</p>
		{{if gap >= 0}}
			{{if gap == 0}} <p class="gap">n</p>
			{{else (gap > 0)}} <p class="gap">\${gap}</p>
			{{/if}}
		{{/if}}
		</p>
		<div class="ranking_profile" style="border:solid 2px #302cc8; padding:3px;">
			{{if resourceUri == ''}}<img src="${pageContext.request.contextPath}/apps/images/ico_37.png">
			{{else}}<img src=\${resourceUri}>
			{{/if}}
		</div>
		<p class="mentorInfo txt_12">\${universityNm} \${majorNm} | \${studentId}학번 | \${acceptanceLine}</p>
		<p class="nickname txt_15">\${nickname}</p>
		<div class="ranking_btn">
			<div class="viewMentorProfile" data-no="\${hipId}">
				<p class="txt_13">프로필보기</p>
			</div>
			<div class="viewMentorActionLog" data-no="\${hipId}">
				<p class="txt_13">활동내역보기</p>
			</div>
		</div>
	</li>
{{else}}
	<li class="rankingList pl10 pr10 pb25 pt25">
		<p class="grade txt_15">\${displayOrder}</p>
		{{if gap >= 0}}
			{{if gap == 0}} <p class="gap">n</p>
			{{else (gap > 0)}} <p class="gap">\${gap}</p>
			{{/if}}
		{{/if}}
		</p>
		<div class="ranking_profile">
			{{if resourceUri == ''}}<img src="${pageContext.request.contextPath}/apps/images/ico_37.png">
			{{else}}<img src=\${resourceUri}>
			{{/if}}
		</div>
		<p class="mentorInfo txt_12">\${universityNm} \${majorNm} | \${studentId}학번 | \${acceptanceLine}</p>
		<p class="nickname txt_15">\${nickname}</p>
		<div class="ranking_btn">
			<div class="viewMentorProfile" data-no="\${hipId}">
				<p class="txt_13">프로필보기</p>
			</div>
			<div class="viewMentorActionLog" data-no="\${hipId}">
				<p class="txt_13">활동내역보기</p>
			</div>
		</div>
	</li>
{{/if}}
</script>
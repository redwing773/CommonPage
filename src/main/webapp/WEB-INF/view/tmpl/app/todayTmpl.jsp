<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="contentsListTmpl" type="text/x-jquery-tmpl">
	<div class="contents_list">
		<ul class="today_list">
			{{each list}}
				<li>
					<a data-no="\${hipId}" href="javascript:void(0);">
						<span class="today_list_header">
							<img class='today_list_header_img' src='\${resourceUrl}' alt='profile'>
							<span><span class='today_list_ht'><img class='today_list_ht_img' src='${pageContext.request.contextPath}/apps/images/highlight.png'>\${title}</span>
								<span class="today_list_info">\${mentorInfoA}  \${mentorInfoB} ㅣ \${mentorInfoC}</span></span>
							</span>
							<span class="today_list_content">
							<span style="color: #3a3a3a;">\${contentsSummary}</span>
							<span class="today_list_content_ex"><span class="today_list_content_in">\${contents}</span></span>
						</span>
					</a>
				</li>
			{{/each}}
		 </ul> 
	</div>
</script>

<script id="schoolRecordWholeListTmpl" type="text/x-jquery-tmpl">
			{{each list}}
					<a href="javascript:void(0);">
				<div class="schoolRecordWhole" data-no="\${hipId}">
						<div class="today_list_header">
							<img class='today_list_header_img' src='\${resourceUrl}' alt='profile'>
							<div><span class='today_list_ht'><img class='today_list_ht_img' src='${pageContext.request.contextPath}/apps/images/highlight.png'>\${title}</span>
								<span class="today_list_info">\${mentorInfoA}  \${mentorInfoB} ㅣ \${mentorInfoC}</span></span>
							</div>
							<div class="today_list_content" style="margin-top: 4px;height: 77px;padding-left: 8px; width: 280px;">
								<span style="color: #3a3a3a;">\${contentsSummary}</span>
								<span class="today_list_content_ex"><span class="today_list_content_in">\${contents}</span>
							</div>
						</div>
				</div>
					</a>
			{{/each}}
</script>

<script id="columnListTmpl" type="text/x-jquery-tmpl">
	{{each mentalkColumnList}}
	<div class="today_columnList" data-url="\${opentalkUri}">
		{{if profileResourceUri != ''}}
			<img src="\${profileResourceUri}" alt="" class="column_img">
		{{else}}
			<div class="column_img" style="background-image:url('\${resourceUri}'); background-position: center center; background-repeat: no-repeat; background-size: 200px 100px;">
			</div>
		{{/if}}
		{{if isVoice}}
			<img src="${pageContext.request.contextPath}/apps/images/ic_headphone.png" class="column_isVoice_img">
		{{/if}}
		<div class="today_columnList_r">\${talkTitle}</div>
		<div class="today_columnList_rc">\${universityNm} ㅣ \${studentId} ㅣ \${acceptanceLine}</div>
		<div class="today_columnList_rr">\${nickname}</div>
		<div class="today_columnList_rb">
			<span><img src="${pageContext.request.contextPath}/apps/images/icCalenda.png" alt="" style="width: 12px;height: 11px;"> \${regDt}</span>
			<span><img src="${pageContext.request.contextPath}/apps/images/icPeople.png" alt="" style="width: 14px;height: 10px;"> \${viewCnt}</span>
				{{if replyNo > 0}}
					<img src="${pageContext.request.contextPath}/apps/images/ic_sms_new.png" style="width: 19px;height: 20px; transform: translateY(-3px);">
				{{else}}
					<img src="${pageContext.request.contextPath}/apps/images/ic_sms.png"  style="width: 14px;height: 14px;">
				{{/if}}
				 \${replyCnt}
		</div>
    </div> 
	{{/each}}
</script>

<script id="schoolRecordListTmpl" type="text/x-jquery-tmpl">
	{{each schoolRecordList}}
	<a href="javascript:void(0);" class="today_schoolRecordList_a" data-no="\${hipId}">
	<div class="today_schoolRecordList">
		<img src="${pageContext.request.contextPath}/apps/images/ic_school_record_count2.png" alt="" class="today_schoolRecordList_img1">
		<div class="today_schoolRecordList_txt1">총 \${numberPages}장</div>
		<div class="today_schoolRecordList_txt2">\${admissionText2}</div>
		<div class="today_schoolRecordList_txt3">\${universityNm} <span style="display:inline-block; vertical-align: bottom; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; font-family: 'AppleSDGothicB';">\${majorNm}</span> ㅣ \${studentId}학번</div>
		<div class="today_schoolRecordList_txt4">\${acceptance}, \${areaSchoolNm}</div>
		<div class="today_schoolRecordList_txt5">\${numberAwardText} \${serviceTimesText}</div>
	</div>
	</a>
	{{/each}}
</script>

<script id="selfIntroListTmpl" type="text/x-jquery-tmpl">
	{{each selfReportList}}
	<a href="javascript:void(0);" class="today_selfReportList_a" data-no="\${hipId}">
		<div class="today_selfReportList">
			<img src="${pageContext.request.contextPath}/apps/images/ic_notes.png" class="today_selfReportList_img1">
			<div class="today_selfReportList_t1">\${universityNm} <span class="today_selfReportList_t4">\${majorNm}</span> ㅣ \${studentId}학번</div>
			<div class="today_selfReportList_t2">\${acceptance}, \${areaSchoolNm}</div>
			<div class="today_selfReportList_t3"><span style="font-family: 'AppleSDGothicB';">요약:</span> \${title}</div>
		</div>
	</a>
	{{/each}}
</script>

<script id="mentorProfileListTmpl" type="text/x-jquery-tmpl">
	{{each mentorList}}
	<a href="javascript:void(0);" class="today_mentorList_a" data-no="\${hipId}">
		<div class="today_mentorList">
			{{if resourceUri != ''}}
				<img src="\${resourceUri}" alt="" class="today_mentorList_i1">
			{{else}}
				<img src="${pageContext.request.contextPath}/apps/images/ico_37.png" alt="" class="today_mentorList_i2">
			{{/if}} 
			<div class="today_mentorList_t1">
				{{if contentsYn}}<div class="bedge_sr">생기부</div>{{/if}}
				{{if lessonCount > 0}}<div class="bedge_lesson">과외 \${lessonCount}건</div>{{/if}}
				{{if selfReportYn}}<div class="bedge_selfIntro">자소서</div>{{/if}}
			</div>
			<div class="today_mentorList_t2">\${nickname}</div>
			<div class="today_mentorList_t3"><div class="bedge_accept">\${acceptanceLine}</div> <div class="bedge_accept">\${acceptance}</div></div>
			<div class="today_mentorList_t4" style="">\${universityNm} <span class="today_mentorList_t4_1">\${majorNm}</span> ㅣ \${studentId}학번</div>
			<div class="mentorProfileList_txt1" style="grid-area: f;">출신고교: \${areaSchoolNm}</div>
			<div class="mentorProfileList_txt2" style="grid-area: g;">합격 유형 사례: 수시 \${nonscheduled}건</div>
			<div class="mentorProfileList_txt3" style="grid-area: h;">생활기록부: \${numberPages}장 &ensp; 수상내역: \${numberAward}개</div>
		</div>
	</a>
	{{/each}}
</script>

<script id="reviewListTmpl" type="text/x-jquery-tmpl">
		<li>
			<span class="today_list_review_header">
				<span class="today_list_review_header_txt1">
				{{if grade == 5}} 
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
				{{else  grade == 4.5}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_half.png"/>
				{{else grade == 4}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>		
				{{else grade == 3.5}}  
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_half.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 3}}  
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 2.5}} 
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_half.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 2}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 1.5}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_half.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 1}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{/if}}
				</span><span class="today_list_review_header_txt2">\${nickname}</span>        
				<span class="today_list_review_header_txt3">
					<span class="txt3_bedge">
						{{if consultCd == 2}}
							멘토링
						{{else}}
							과외
						{{/if}}
					</span>
				</span>
				<span class="today_list_review_header_txt4">\${review}</span>
				<span class="today_list_review_header_txt5">전체보기</span>
			</span>
		</li>
</script>

<script id="reviewMentorcolumnTmpl" type="text/x-jquery-tmpl">
	<li>
	<span class="today_columnList" data-url="\${opentalkUri}">
		{{if profileResourceUri != ''}}
			<img src="\${profileResourceUri}" alt="" class="column_img">
		{{else}}
			<div class="column_img" style="background-image:url('\${resourceUri}'); background-position: center center; background-repeat: no-repeat; background-size: 200px 100px;">
			</div>
		{{/if}}
		{{if isVoice}}
			<img src="${pageContext.request.contextPath}/apps/images/ic_headphone.png" class="column_isVoice_img">
		{{/if}}
		<span style="display: block;"><span class="today_columnList_r" style="white-space: normal;">\${talkTitle}</span></span>
		<span class="today_columnList_rc">\${universityNm} ㅣ \${studentId} ㅣ \${acceptanceLine}</span>
		<span class="today_columnList_rr">\${nickname}</span>
		<span class="today_columnList_rb">
			<span><img src="${pageContext.request.contextPath}/apps/images/icCalenda.png" alt="" style="width: 12px;height: 11px;"> \${regDt}</span>
			<span><img src="${pageContext.request.contextPath}/apps/images/icPeople.png" alt="" style="width: 14px;height: 10px;"> \${viewCnt}</span>
				{{if replyNo > 0}}
					<img src="${pageContext.request.contextPath}/apps/images/ic_sms_new.png" style="width: 19px;height: 20px; transform: translateY(-3px);">
				{{else}}
					<img src="${pageContext.request.contextPath}/apps/images/ic_sms.png"  style="width: 14px;height: 14px;">
				{{/if}}
				 \${replyCnt}
		</span>
		</div>
	</span>
    </li>
</script>

<script id="reviewOpentalkListTmpl" type="text/x-jquery-tmpl">
<div class="mentorInfo_opentalkList"  data-url="\${opentalkUri}">
     {{if mentorYn == "N"}}
		{{if isAdopt}}
			<img src="${pageContext.request.contextPath}/apps/images/ic_adoptted.png" class="mentorInfo_opentalkList_img">
		{{else}}
			<img src="${pageContext.request.contextPath}/apps/images/ic_reply.png" class="mentorInfo_opentalkList_img">
		{{/if}}
	 	 <span class="mentorInfo_opentalkList_txt1">\${schoolInfo} 멘티</span>
		 <span class="mentorInfo_opentalkList_txt2">댓글</span>
	 {{else}}
    	 <img src="${pageContext.request.contextPath}/apps/images/ic_write.png" class="mentorInfo_opentalkList_img">
		 <span class="mentorInfo_opentalkList_txt1">본인</span>
		 <span class="mentorInfo_opentalkList_txt2">작성글</span>
	 {{/if}}
	 {{if categoryNm}}
     	 <span class="mentorInfo_opentalkList_txt3">#\${categoryNm}</span>
	 {{/if}}
      <span class="mentorInfo_opentalkList_txt4">\${regDt}</span>
	  <div class="mentorInfo_opentalkList_txt5">\${talkContent}</div>
      {{if isReply}}
  		 <img src="${pageContext.request.contextPath}/apps/images/ic_comment.png" class="mentorInfo_opentalkList_img1">
     	 <div class="mentorInfo_opentalkList_txt6">\${replyContent}</div>
	  {{else}}
		 <div class="mentorInfo_opentalkList_txt6" style="height:32px"></div>
 	  {{/if}}
</div>
</script>

<script id="reviewListTmpl3" type="text/x-jquery-tmpl">
			<div class="today_list_review_header">
				<div class="today_list_review_header_txt1">
				{{if grade == 5}} 
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
				{{else  grade == 4.5}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_half.png"/>
				{{else grade == 4}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>		
				{{else grade == 3.5}}  
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_half.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 3}}  
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 2.5}} 
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_half.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 2}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 1.5}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_half.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{else grade == 1}}
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_blue.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
					<img class="starImg" src="${pageContext.request.contextPath}/apps/images/ic_star_grey.png"/>
				{{/if}}
				</div><span class="today_list_review_header_txt2">\${nickname}</span>        
				<span class="today_list_review_header_txt3">
					<span class="txt3_bedge">
						{{if consultCd == 2}}
							멘토링
						{{else}}
							과외
						{{/if}}
					</span>
				</span>
				<div class="today_list_review_header_txt4_1" style="height: auto;">\${review}</div>
			</div>
</script>
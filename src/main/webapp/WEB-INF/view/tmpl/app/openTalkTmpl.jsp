<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    
<script id="replyInputTmpl" type="text/x-jquery-tmpl">
  <div class="swl_comment_input mb15">
    <textarea class="replyArea" rows=2 name="reply_\${replyNo}" placeholder="댓글에 이모티콘 입력 불가" maxlength="5500" onkeyup="uptFn(this);" style="background:#ffffff;color:black;">\${replyContent}</textarea>
    <a href="#">
        <img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyModifyFn(this,\${replyNo},\${talkNo});">
    </a>
	<span class="countReply" style="opacity:1;">\${len}/5000</span>
</div>
</script>

<script id="basicReplyInputTmpl" type="text/x-jquery-tmpl">
  <div class="swl_comment_input mb15">
    <textarea class="replyArea" rows=2 name="reply_\${replyNo}" placeholder="댓글에 이모티콘 입력 불가" maxlength="5500" oncopy="return false;" onpaste="$('#alertPopArea').html('');common.openAlertPopup({message:'댓글 복사,붙여넣기 금지', popupClass:'popup_point_charge_complete'}); return false;" oncut="return false;" onkeyup="uptFn(this, \${opentalkNo});" style="background:#ffffff;color:black;">\${replyContent}</textarea>
    <a href="#">
        <img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyModifyFn(this,\${replyNo},\${talkNo},\${opentalkNo});">
    </a>
	<span class="countReply" style="opacity:1;">\${len}/5000</span>
</div>
</script>

<script id="secretReplyInputTmpl" type="text/x-jquery-tmpl">
  <div class="swl_comment_input mb15">
    <textarea class="replyArea" rows=2 name="reply_\${replyNo}" placeholder="멘토링톡은 채택 포인트만 있음 &#13;&#10;이모티콘 입력 불가" maxlength="5500" onkeyup="uptFn(this, \${opentalkNo});" style="background:#ffffff;color:black;">\${replyContent}</textarea>
    <a href="#">
        <img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyModifyFn(this,\${replyNo},\${talkNo},\${opentalkNo});">
    </a>
	<span class="countReply" style="opacity:1;">\${len}/5000</span>
</div>
</script>

<script id="myTalkListTmpl" type="text/x-jquery-tmpl">
<li data-idx=\${opentalkNo} data-no=\${talkNo} data-poll=\${pollNo} data-voice=\${isVoice} data-id=\${hipId} onclick="moveDetail(this);">
	<div class="mytalk_header">
		{{if opentalkNo == 1}}
			{{if categoryNm != null}}
				<p class="mytalk_categoryNm">\${categoryNm}</p>
			{{/if}}
		{{else (opentalkNo == 6)}}
			{{if categoryNm != null}}
				<p class="mytalk_categoryNm2">\${categoryNm}</p>
			{{/if}}
		{{/if}}
		{{if isReply == false}}
			{{if opentalkNo == 1 || opentalkNo == 6}}
				{{if mentorYn == 'N'}}
					{{if userCloseDate}}
						{{if userAdoptType == 'questioner'}}
						<p class="mytalk_profile_2 txt_13">채택<br>완료</p>
						{{else (userAdoptType == 'system')}}
						<p class="mytalk_profile_2 txt_13">자동<br>마감</p>
						{{else}}
						<p class="mytalk_profile txt_13">작성글</p>
						{{/if}}
					{{else (!userCloseDate)}}
						<p class="mytalk_profile_2 on txt_13">채택<br>필요</p>
					{{/if}}
				{{else (mentorYn == 'Y')}}
					<p class="mytalk_profile txt_13">작성글</p>
				{{/if}}
			{{else}}
				<p class="mytalk_profile txt_13">작성글</p>
			{{/if}}
			<p class="mytalk_info txt_11">본인<br>작성 글</p>
		{{else (isReply == true)}}
			{{if isAdopt == true}}
				<p class="mytalk_profile_2 on 13px">채택<br>댓글</p>
			{{else}}
				<p class="mytalk_profile 13px">댓글</p>
			{{/if}}
			{{if opentalkNo == 5}}
				<p class="mytalk_info txt_11">워드클라우드<br>댓글</p>
			{{else (opentalkNo == 3)}}
				<p class="mytalk_info txt_11">투표<br>댓글</p>
			{{else}}
				{{if mentorYn == 'Y'}}
					<p class="mytalk_info txt_11">\${schoolInfo} 멘토<br>댓글</p>
				{{else (mentorYn == 'N')}}
					<p class="mytalk_info txt_11">
						\${schoolInfo} 멘티
						{{if isAdopt == true}}
						<br>(\${adoptPoint}) 댓글
						{{else}}
						<br>댓글
						{{/if}}
					</p>
				{{/if}}
			{{/if}}
		{{/if}}
		<p class="mytalk_regDt">\${regDt}</p>
	</div>
	<div class="mytalk_content mt0 mb15">
		<div class="blockContentsText\${hipId}">
			<p class="txt_13">\${talkContent}</p>
		</div>
		<div class="blockContentsImg\${hipId}" style="display: none;"><img class="blockQuestionImg" src="${pageContext.request.contextPath}/apps/images/im_block_question.png"></div>
	</div>

	{{if isReply == true}}
		<div class="mytalk_reply blockReply\${replyHipId}">
			<p class="txt_13">\${replyContent}</p>
		</div>
		<div class="mytalk_reply blockReplyImg\${replyHipId}" style="display: none;"><img class="blockAnswerImg" src="${pageContext.request.contextPath}/apps/images/im_block_answer.png"></div>
	{{/if}}
</li>
</script>

<script id="opentalkListTmpl" type="text/x-jquery-tmpl">
{{if opentalkNo == 1}}
<li class="awl_content_reply_list">
	<input type="hidden" class="talkNo" value="\${talkNo}">
	{{if categoryNm != null}}
		<p class="awl_categoryNm">\${categoryNm}</p>
	{{/if}}
	<div class="awl_user">
		{{if resourceUri == ''}}
			<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"  onClick="invokeProfileFn('\${hipId}','\${mentorYn}');"/></span>
		{{else (resourceUri != '')}}
			{{if mojiEmail == null}}
				<span class="awl_img"><img src=\${resourceUri} onClick="invokeProfileFn('\${hipId}', '\${mentorYn}');"></span>
			{{else}}
				<span class="awl_img"><img src=\${resourceUri} onClick="invokeProfileMojiFn('\${hipId}', '\${mentorYn}');"></span>
			{{/if}}
		{{/if}}
		<div class="awl_name" data-no=\${hipId}>
			<strong class="awl_nickname">\${nickname}</strong>
			{{if hipId != userHipId && hipId != managerHipId && hipId != managerSupportHipId}}
			<span class="blockContentsSpan">
				<div class="blockContents">
					<div class="drop_bar" id="contents\${hipId}"><img class="moreBlock" src="${pageContext.request.contextPath}/apps/images/ic_more.png"></div>
					<div style="display: none;" class="drop_content">
						<a href="javascript:void(0);" onClick="moveReport('\${hipId}', \${talkNo});">신고하기</a>
						<a style="display: none;" class="block" onclick="block(this, 'contents', '\${hipId}', \${talkNo})">차단하기</a>
						<a style="display: none;" class="unBlock" onclick="unBlock(this, 'contents', '\${hipId}', \${talkNo})">차단해제</a>
					</div>
				</div>
			</span>
			{{/if}}
			{{if hipId == userHipId || hipId == managerHipId || hipId == managerSupportHipId}}
				<span class="blockContentsSpan"><div class="blockContents"></div></span>
			{{/if}}
			<span class="awl_date" data-no=\${expDt}>\${regDt}</span>
		</div>
		{{if mentorYn == 'Y'}}
			<span class="awl_badge" data-no=\${mentorYn}>멘토</span>
		{{else (mentorYn == 'N')}}
			{{if mojiEmail == null}}
				<span class="awl_badge" data-no=\${mentorYn}>멘티</span>
			{{else}}
				<img class="ic_moji_badge2" src="${pageContext.request.contextPath}/apps/images/ic_moji_badge.png">
			{{/if}}
		{{/if}}
		{{if userHipId}}
            {{if userMentorYn == 'Y'}}
                {{if mentorYn == 'N' && hipId != managerHipId && hipId != managerSupportHipId}}
					{{if mojiEmail == null}}
              			<span class="txt_11 btn_question" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">제안하기</span>
						<span class="txt_11 awl_mentorMenteeInfo">
					{{else}}
						<span style="color: #302cc8; grid-area: e; position: absolute; transform: translate(129px ,2px); font-size: 10px; font-weight: bold;">멘토링 제안 불가 회원</span>
						<span class="txt_11 awl_mentorMenteeInfo_moji">
					{{/if}}
                    {{if feature}}\${feature}, \${schoolLevel}</span>
                    {{else (!feature)}}\${schoolLevel}
                    {{/if}}
                </span>
                {{/if}}
            {{else (userMentorYn == 'N')}}
                {{if mentorYn == 'Y' && hipId != managerHipId && hipId != managerSupportHipId}}
                <span class="txt_11 btn_question" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">문의하기</span>
				<span class="txt_11 awl_mentorMenteeInfo">\${partyNm}, \${departmentLine}, \${studentId}학번, \${acceptanceLine}</span>
                {{else (mentorYn == 'N' && hipId != managerHipId && hipId != managerSupportHipId)}}
				{{if mojiEmail == null}}
                <span class="txt_11 awl_mentorMenteeInfo">
                    {{if feature}}\${feature}, \${schoolLevel}</span>
                    {{else (!feature)}}\${schoolLevel}
                    {{/if}}
                </span>
				{{else}}
				 <span class="txt_11 awl_mentorMenteeInfo_moji">
                    {{if feature}}\${feature}, \${schoolLevel}</span>
                    {{else (!feature)}}\${schoolLevel}
                    {{/if}}
                </span>
                {{/if}}
				{{/if}}
            {{/if}}
        {{else (!userHipId)}}
            {{if hipId != managerHipId  && hipId != managerSupportHipId}}
            <span class="txt_11 btn_question" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">문의하기</span>
            {{/if}}
        {{/if}}
	</div>
	<p class="con blockContentsText\${hipId}" onClick="replyExtendFn(this);">{{html talkContent}}</p>
	<p class="con blockContentsImg\${hipId}" style="display: none;" onClick="replyExtendFn(this);"><img class="blockListImg" src="${pageContext.request.contextPath}/apps/images/im_block_talk_list.png"></p>
	{{if ogUrl != null}}
		<div class="awl_ogTag" onClick="moveUrl(\${ogUrl});">
			<img src=\${ogImg} class="awl_ogImg" />
			<p class="awl_ogTitle">\${ogTitle}</p>
			<p class="awl_ogDescription">\${ogDescription}</p>
			<p class="awl_ogUrl">\${ogUrl}</p>
		</div>	
	{{/if}}
	<div class="awl_box_state">
		{{if replyCnt <= 0}}
			<span class="awl_dat" onClick="replyExtendFn(this);">댓글 쓰기</span>
		{{else (replyCnt > 0)}}
			<span class="awl_dat" onClick="replyExtendFn(this);">\${replyCnt}개의 댓글 보기</span>
		{{/if}}

		<div class="awl_abs_right">
		{{if hipId == userHipId}}
			{{if userMentorYn == 'N'}}
				{{if userHipId != managerHipId  && userHipId != managerSupportHipId}}
					{{if closeDate == null && adoptPoint != 0}}
   						<a href="javascript:void(0);" class="btn_select txt_13">채택 포인트 : \${adoptPoint}P</a>
					{{else (closeDate != null)}}
    				 	{{if adoptType == 'questioner' || adoptType == 'questioner_req'}}
							{{if talkNo <= 913}}
								<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(5,000P)</a>
							{{else (talkNo > 913)}}
								<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(\${adoptPoint}P)</a>
							{{/if}}
						{{else (adoptType == 'system' || adoptType == 'system_req')}}
							{{if talkNo <= 913}}
								<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(5,000P)</a>
							{{else (talkNo > 913)}}
								<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(\${adoptPoint}P)</a>
							{{/if}}
						{{/if}}
					{{/if}}
				{{else (userHipId == managerHipId || userHipId == managerSupportHipId)}}
					<a href="javascript:void(0);" class="btn_del" onClick="talkDelFn(this,\${talkNo},true);">삭제</a>
					<a href="javascript:void(0);" class="btn_upt" onClick="talkUptFn(\${talkNo},\${opentalkNo});">수정</a>
				{{/if}}
			{{else (userMentorYn == 'Y')}}
				<a href="javascript:void(0);" class="btn_del" onClick="talkDelFn(this,\${talkNo},true);">삭제</a>
				<a href="javascript:void(0);" class="btn_upt" onClick="talkUptFn(\${talkNo},\${opentalkNo});">수정</a>
			{{/if}}
		{{/if}}
		{{if hipId != userHipId && mentorYn == 'N'}}
			{{if hipId != managerHipId && hipId != managerSupportHipId}}
				{{if closeDate == null && adoptPoint != 0}}
   					<a href="javascript:void(0);" class="btn_select txt_13">채택 포인트 : \${adoptPoint}P</a>
				{{else (closeDate != null)}}
    				 {{if adoptType == 'questioner' || adoptType == 'questioner_req'}}
						{{if talkNo <= 913}}
							<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(5,000P)</a>
						{{else (talkNo > 913)}}
							<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(\${adoptPoint}P)</a>
						{{/if}}
					{{else (adoptType == 'system' || adoptType == 'system_req')}}
						{{if talkNo <= 913}}
							<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(5,000P)</a>
						{{else (talkNo > 913)}}
							<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(\${adoptPoint}P)</a>
						{{/if}}
					{{/if}}
				{{/if}}
			{{/if}}
		{{/if}}
		</div>
	</div>
	<div class="awl_comment_box mt10" id="awl_comment_box">
		<div class="awl_comment_head mb15">
			<img src="${pageContext.request.contextPath}/apps/images/ic_arrow_down.png" id="closeToggle" onClick="replyExtend2Fn(this);"/>
		</div>
		<div class="awl_comment_tit mt10">	
			<p class="adoptPercentForList"><span style="font-weight: bold;color:#000000">질문자의 </span>질문수 <span style="color: #302cc8;" id="questionSum\${talkNo}"></span> 
			{{if mojiEmail == null}}
				<span style="font-size: 12px;vertical-align:top;">·</span> 본인 채택율 <span style="color: #302cc8;" id="adoptPercent\${talkNo}"></span>
			{{else}}
				<span style="font-weight: bold; font-size: 10px; color: #f00;">멘토링 제안 댓글로 작성 불가</span>
			{{/if}}
			</p>
			<strong style="display: inline-block; margin-top:-12px;">댓글 \${replyCnt}</strong>
			<a href="javascript:void(0);" onClick="moreContentFn(\${talkNo});">댓글 모두 보기</a>
		</div>
		<div class="awl_swl_comment">
			<div class="swl_comment_input mb15">
			    <textarea rows=2 placeholder="댓글에 이모티콘 입력 불가" id="replyInput" maxlength="5500" oncopy="return false;" onpaste="$('#alertPopArea').html('');common.openAlertPopup({message:'댓글 복사,붙여넣기 금지', popupClass:'popup_point_charge_complete'}); return false;" oncut="return false;" onkeyup="replyInputFn(this, \${opentalkNo});" onclick="replyInputFn(this, \${opentalkNo});"></textarea>
			    {{if closeDate == null}}
					<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo}, false);"/></a>
				{{else (closeDate != null)}}
					<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo}, true);"/></a>
				{{/if}}
				<span class="countReply">0/5000</span>
			</div>
		</div>
		<ul class="swl_comment_list"></ul><!-- 댓글 삽입 부분 -->
	</div>
</li>
{{else (opentalkNo == 6)}}
	{{if userMentorYn == 'N'}}
		{{if hipId == userHipId}}
		<li class="awl_content_reply_list" style="border:solid 2px #302cc8;">
			<input type="hidden" class="talkNo" value="\${talkNo}">
			{{if categoryNm != null}}
				<p class="awl_categoryNm2">\${categoryNm}</p>
			{{/if}}
			<div class="awl_user">
			{{if resourceUri == ''}}
				<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"  onClick="invokeProfileFn('\${hipId}','\${mentorYn}');"/></span>
			{{else (resourceUri != '')}}
				<span class="awl_img"><img src=\${resourceUri} onClick="invokeProfileFn('\${hipId}', '\${mentorYn}');"></span>
			{{/if}}
			<div class="awl_name" data-no=\${hipId}>
				<strong class="awl_nickname">\${nickname}</strong>
				{{if hipId != userHipId && hipId != managerHipId && hipId != managerSupportHipId}}
				<span class="blockContentsSpan">
					<div class="blockContents">
						<div class="drop_bar" id="contents\${hipId}"><img class="moreBlock" src="${pageContext.request.contextPath}/apps/images/ic_more.png"></div>
						<div style="display: none;" class="drop_content">
							<a href="javascript:void(0);" onClick="moveReport('\${hipId}', \${talkNo});">신고하기</a>
							<a style="display: none;" class="block" onclick="block(this, 'contents', '\${hipId}', \${talkNo})">차단하기</a>
							<a style="display: none;" class="unBlock" onclick="unBlock(this, 'contents', '\${hipId}', \${talkNo})">차단해제</a>
						</div>
					</div>
				</span>
				{{/if}}
				{{if hipId == userHipId || hipId == managerHipId || hipId == managerSupportHipId}}
					<span class="blockContentsSpan"><div class="blockContents"></div></span>
				{{/if}}
				<span class="awl_date" data-no=\${expDt}>\${regDt}</span>
			</div>
			{{if mentorYn == 'Y'}}
				<span class="awl_badge" data-no=\${mentorYn}>멘토</span>
			{{else (mentorYn == 'N')}}
				<span class="awl_badge" data-no=\${mentorYn}>멘티</span>
			{{/if}}
			{{if userHipId}}
            	{{if userMentorYn == 'Y'}}
                	{{if mentorYn == 'N' && hipId != managerHipId && hipId != managerSupportHipId}}
                	<span class="txt_11 btn_question3" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">제안하기</span>
                	<span class="txt_11 awl_mentorMenteeInfo">
                    	{{if feature}}\${feature}, \${schoolLevel}</span>
                    	{{else (!feature)}}\${schoolLevel}
                    	{{/if}}
                	</span>
                	{{/if}}
            	{{else (userMentorYn == 'N')}}
                	{{if mentorYn == 'Y' && hipId != managerHipId && hipId != managerSupportHipId}}
                	<span class="txt_11 btn_question3" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">문의하기</span>
                	<span class="txt_11 awl_mentorMenteeInfo">\${partyNm}, \${departmentLine}, \${studentId}학번, \${acceptanceLine}</span>
                	{{else (mentorYn == 'N' && hipId != managerHipId && hipId != managerSupportHipId)}}
                	<span class="txt_11 awl_mentorMenteeInfo">
                    	{{if feature}}\${feature}, \${schoolLevel}</span>
                    	{{else (!feature)}}\${schoolLevel}
                    	{{/if}}
                	</span>
                {{/if}}
            {{/if}}
        	{{else (!userHipId)}}
            	{{if hipId != managerHipId && hipId != managerSupportHipId}}
            	<span class="txt_11 btn_question3" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">문의하기</span>
            	{{/if}}
			{{/if}}
		</div>
		<p class="con blockContentsText\${hipId}" onClick="replyExtendFn(this);">{{html talkContent}}</p>
		<p class="con blockContentsImg\${hipId}" style="display: none;" onClick="replyExtendFn(this);"><img class="blockListImg" src="${pageContext.request.contextPath}/apps/images/im_block_talk_list.png"></p>
		{{if ogUrl != null}}
			<div class="awl_ogTag" onClick="moveUrl(\${ogUrl});">
				<img src=\${ogImg} class="awl_ogImg" />
				<p class="awl_ogTitle">\${ogTitle}</p>
				<p class="awl_ogDescription">\${ogDescription}</p>
				<p class="awl_ogUrl">\${ogUrl}</p>
			</div>	
		{{/if}}
		<div class="awl_box_state">
			{{if replyCnt <= 0}}
				<span class="awl_dat" onClick="replyExtendFn(this);">댓글 쓰기</span>
			{{else (replyCnt > 0)}}
				<span class="awl_dat" onClick="replyExtendFn(this);">\${replyCnt}개의 댓글 보기</span>
			{{/if}}
			<div class="awl_abs_right">
			{{if hipId == userHipId}}
				{{if closeDate == null}}
				<a href="javascript:void(0);" class="btn_del" onClick="talkDelFn(this,\${talkNo},false);">삭제</a>
				{{else (closeDate != null)}}
				<a href="javascript:void(0);" class="btn_del" onClick="talkDelFn(this,\${talkNo},true);">삭제</a>
				{{/if}}
				<a href="javascript:void(0);" class="btn_upt" onClick="talkUptFn(\${talkNo}, \${opentalkNo});">수정</a>
			{{/if}}
			{{if hipId != userHipId && mentorYn == 'N'}}
				{{if hipId == managerHipId || hipId == managerSupportHipId}}{{/if}}
				{{if hipId != managerHipId &&  hipId != managerSupportHipId}}
					{{if closeDate == null && adoptPoint != 0}}
   						<a href="javascript:void(0);" class="btn_select2 txt_13">채택 포인트 : \${adoptPoint}P</a>
					{{else (closeDate != null)}}
    					{{if adoptType == 'questioner' || adoptType == 'questioner_req'}}
							{{if talkNo <= 913}}
								<a href="javascript:void(0);" class="btn_endSelect2 txt_13">질문자 채택(\${adoptPoint}P)</a>
							{{else (talkNo > 913)}}
								<a href="javascript:void(0);" class="btn_endSelect2 txt_13">질문자 채택(\${adoptPoint}P)</a>
							{{/if}}
						{{else (adoptType == 'system' || adoptType == 'system_req')}}
							{{if talkNo <= 913}}
								<a href="javascript:void(0);" class="btn_endSelect2 txt_13">자동 마감(\${adoptPoint}P)</a>
							{{else (talkNo > 913)}}
								<a href="javascript:void(0);" class="btn_endSelect2 txt_13">자동 마감(\${adoptPoint}P)</a>
							{{/if}}
						{{/if}}
					{{/if}}
				{{/if}}
			{{/if}}
			</div>
		</div>
		<div class="awl_comment_box mt10" id="awl_comment_box">
			<div class="awl_comment_head mb15">
				<img src="${pageContext.request.contextPath}/apps/images/ic_arrow_down.png" id="closeToggle" onClick="replyExtend2Fn(this);"/>
			</div>
			<div class="awl_comment_tit mt10">	
			<p class="adoptPercentForList"><span style="font-weight: bold;color:#000000">질문자의 </span>질문수 <span style="color: #302cc8;" id="questionSum\${talkNo}"></span> <span style="font-size: 12px;vertical-align:top;">·</span> 본인 채택율 <span style="color: #302cc8;" id="adoptPercent\${talkNo}"></span></p>
				<strong style="display: inline-block; margin-top:-12px;">댓글 \${replyCnt}</strong>
				<a href="javascript:void(0);" onClick="moreContentFn(\${talkNo});">댓글 모두 보기</a>
			</div>
			<div class="awl_swl_comment">
				<div class="swl_comment_input mb15">
			    	<textarea rows=2 placeholder="멘토링톡은 채택 포인트만 있음 &#13;&#10;이모티콘 입력 불가" id="replyInput" maxlength="5500" oninput="replyInputFn(this, \${opentalkNo});" onkeyup="replyInputFn(this, \${opentalkNo});" onclick="replyInputFn(this, \${opentalkNo});"></textarea>
			    	<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo});"/></a>
					<span class="countReply">0/5000</span>
				</div>
			</div>
			<ul class="swl_comment_list"></ul><!-- 댓글 삽입 부분 -->
		</div>
	</li>
		{{else (hipId != userHipId)}}
		<li class="awl_content_reply_list" onclick="goSecretDetail('\${talkNo}', true);" style="padding:0px 0px;">      
			<%--<img src="https://d9f2e26giax13.cloudfront.net/etc/eca85befc07c4a52bd78e1792f98043f-1.png" style="width:100%;">--%>
			<img src="${pageContext.request.contextPath}/apps/images/image_secret_head2.png" style="width:100%;">
			<div class="awl_secret_title">
				{{if mentorYn == 'N'}}
					<span class="awl_secret_badge" data-no=\${mentorYn}>멘티</span>
				{{/if}}
				<span class="awl_secret_menteeInfo">
					{{if feature}}\${feature}, \${schoolLevel}</span>
                	{{else (!feature)}}\${schoolLevel}
                	{{/if}}
				</span>
			</div>
			<div class="awl_secret_content mt0">
				<p class="awl_summaryContent">{{html summaryContent}}</p>
				{{if replyCnt <= 0}}
					<span class="awl_status">댓글 쓰기</span>
				{{else (replyCnt > 0)}}
					<span class="awl_status">\${replyCnt}개의 댓글 보기</span>
				{{/if}}
			</div>
			<div class="awl_secret_state mt0">
				<img src="${pageContext.request.contextPath}/apps/images/image_secret_content.png" style="width:100%;">
			</div>	
		</li>
		{{/if}}	
	{{else (userMentorYn == 'Y')}}
		{{if closeDate == null}}
		<li class="awl_content_reply_list" style="border:solid 2px #302cc8;">
			<input type="hidden" class="talkNo" value="\${talkNo}">
			<%-- 댓글 포인트 부분 추가 작업할 곳 --%>
			{{if categoryNm != null}}
				<p class="awl_categoryNm2">\${categoryNm}</p>
			{{/if}}
			<div class="awl_user">
			{{if resourceUri == ''}}
				<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"  onClick="invokeProfileFn('\${hipId}','\${mentorYn}');"/></span>
			{{else (resourceUri != '')}}
				{{if mojiEmail == null}}
					<span class="awl_img"><img src=\${resourceUri} onClick="invokeProfileFn('\${hipId}', '\${mentorYn}');"></span>
				{{else}}
					<span class="awl_img"><img src=\${resourceUri} onClick="invokeProfileMojiFn('\${hipId}', '\${mentorYn}');"></span>
				{{/if}}
			{{/if}}
			<div class="awl_name" data-no=\${hipId}>
				<strong class="awl_nickname">\${nickname}</strong>
				{{if hipId != userHipId && hipId != managerHipId && hipId != managerSupportHipId}}
				<span class="blockContentsSpan">
					<div class="blockContents">
					<div class="drop_bar" id="contents\${hipId}"><img class="moreBlock" src="${pageContext.request.contextPath}/apps/images/ic_more.png"></div>
					<div style="display: none;" class="drop_content">
						<a href="javascript:void(0);" onClick="moveReport('\${hipId}', \${talkNo});">신고하기</a>
						<a style="display: none;" class="block" onclick="block(this, 'contents', '\${hipId}', \${talkNo})">차단하기</a>
						<a style="display: none;" class="unBlock" onclick="unBlock(this, 'contents', '\${hipId}', \${talkNo})">차단해제</a>
					</div>
					</div>
				</span>
				{{/if}}
				{{if hipId == userHipId || hipId == managerHipId || hipId == managerSupportHipId}}
					<span class="blockContentsSpan"><div class="blockContents"></div></span>
				{{/if}}
				<span class="awl_date" data-no=\${expDt}>\${regDt}</span>
			</div>
			{{if mentorYn == 'Y'}}
				<span class="awl_badge" data-no=\${mentorYn}>멘토</span>
			{{else (mentorYn == 'N')}}
				<span class="awl_badge" data-no=\${mentorYn}>멘티</span>
			{{/if}}
			{{if userHipId}}
            	{{if userMentorYn == 'Y'}}
                	{{if mentorYn == 'N' && hipId != managerHipId && hipId != managerSupportHipId}}
					{{if mojiEmail == null}}
                		<span class="txt_11 btn_question3" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">제안하기</span>
					{{else}}
						<span style="color: #302cc8; grid-area: e; position: absolute; transform: translate(129px ,2px); font-size: 10px; font-weight: bold;">멘토링 제안 불가 회원</span>
					{{/if}}
                	<span class="txt_11 awl_mentorMenteeInfo">
                    	{{if feature}}\${feature}, \${schoolLevel}</span>
                    	{{else (!feature)}}\${schoolLevel}
                    	{{/if}}
                	</span>
                	{{/if}}
            	{{else (userMentorYn == 'N')}}
                	{{if mentorYn == 'Y' && hipId != managerHipId && hipId != managerSupportHipId}}
                	<span class="txt_11 btn_question" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">문의하기</span>
                	<span class="txt_11 awl_mentorMenteeInfo">\${partyNm}, \${departmentLine}, \${studentId}학번, \${acceptanceLine}</span>
                	{{else (mentorYn == 'N' && hipId != managerHipId && hipId != managerSupportHipId)}}
                	<span class="txt_11 awl_mentorMenteeInfo">
                    	{{if feature}}\${feature}, \${schoolLevel}</span>
                    	{{else (!feature)}}\${schoolLevel}
                    	{{/if}}
                	</span>
                {{/if}}
            {{/if}}
        	{{else (!userHipId)}}
            	{{if hipId != managerHipId && hipId != managerSupportHipId}}
            	<span class="txt_11 btn_question" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">문의하기</span>
            	{{/if}}
			{{/if}}
			</div>
			<p class="con blockContentsText\${hipId}" onClick="replyExtendFn(this);">{{html talkContent}}</p>
			<p class="con blockContentsImg\${hipId}" style="display: none;" onClick="replyExtendFn(this);"><img class="blockListImg" src="${pageContext.request.contextPath}/apps/images/im_block_talk_list.png"></p>
			{{if ogUrl != null}}
			<div class="awl_ogTag" onClick="moveUrl(\${ogUrl});">
				<img src=\${ogImg} class="awl_ogImg" />
				<p class="awl_ogTitle">\${ogTitle}</p>
				<p class="awl_ogDescription">\${ogDescription}</p>
				<p class="awl_ogUrl">\${ogUrl}</p>
			</div>	
			{{/if}}
			<div class="awl_abs_flex">
				{{if replyCnt <= 0}}
					<div class="awl_dat" onClick="replyExtendFn(this);">댓글 쓰기</div>
				{{else (replyCnt > 0)}}
					<div class="awl_dat" onClick="replyExtendFn(this);">\${replyCnt}개의 댓글 보기</div>
				{{/if}}
				<div class="btn_select3">
				{{if hipId == userHipId}}
					<a href="javascript:void(0);" class="btn_del" onClick="talkDelFn(this,\${talkNo});">삭제</a>
				{{/if}}
				{{if hipId != userHipId && mentorYn == 'N'}}
					{{if hipId == managerHipId || hipId == managerSupportHipId}}{{/if}}
					{{if hipId != managerHipId && hipId != managerSupportHipId}}
						{{if closeDate == null && adoptPoint != 0}}
							<div class="btn_select2 txt_13">
								<p>
									채택 포인트 : \${adoptPoint}P
								</p>
								{{if paidReplyCnt > 0}}
							    <p class="awl_abs_caption">
									댓글 선착순 5명 100P
							    </p>
							    {{/if}}
							</div>
						{{else (closeDate != null)}}
    						{{if adoptType == 'questioner'}}
								{{if talkNo <= 913}}
								<a href="javascript:void(0);" class="btn_endSelect2 txt_13">질문자 채택(\${adoptPoint}P)</a>
								{{else (talkNo > 913)}}
								<a href="javascript:void(0);" class="btn_endSelect2 txt_13">질문자 채택(\${adoptPoint}P)</a>
								{{/if}}
							{{else (adoptType == 'system')}}
								{{if talkNo <= 913}}
								<a href="javascript:void(0);" class="btn_endSelect2 txt_13">자동 마감(\${adoptPoint}P)</a>
								{{else (talkNo > 913)}}
								<a href="javascript:void(0);" class="btn_endSelect2 txt_13">자동 마감(\${adoptPoint}P)</a>
								{{/if}}
							{{/if}}
						{{/if}}
					{{/if}}
				{{/if}}
				</div>
			</div>
			<div class="awl_comment_box mt10" id="awl_comment_box">
				<div class="awl_comment_head mb15">
					<img src="${pageContext.request.contextPath}/apps/images/ic_arrow_down.png" id="closeToggle" onClick="replyExtend2Fn(this);"/>
				</div>
				<div class="awl_comment_tit mt10">	
					<p class="adoptPercentForList"><span style="font-weight: bold;color:#000000">질문자의 </span>질문수 <span style="color: #302cc8;" id="questionSum\${talkNo}"></span> <span style="font-size: 12px;vertical-align:top;">·</span> 본인 채택율 <span style="color: #302cc8;" id="adoptPercent\${talkNo}"></span></p>
					<strong style="display: inline-block; margin-top:-12px;">댓글 \${replyCnt}</strong>
					<a href="javascript:void(0);" onClick="moreContentFn(\${talkNo});">댓글 모두 보기</a>
				</div>
				<div class="awl_swl_comment">
					<div class="swl_comment_input mb15">
			    		<textarea rows=2 placeholder="멘토링톡은 채택 포인트만 있음 &#13;&#10;이모티콘 입력 불가" id="replyInput" maxlength="5500" oninput="replyInputFn(this, \${opentalkNo});" onkeyup="replyInputFn(this, \${opentalkNo});" onclick="replyInputFn(this, \${opentalkNo});"></textarea>
			    		<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo});"/></a>
						<span class="countReply">0/5000</span>
					</div>
				</div>
				<ul class="swl_comment_list"></ul><!-- 댓글 삽입 부분 -->
			</div>
		</li>
		{{else (closeDate != null)}}
		<li class="awl_content_reply_list" onclick="goSecretDetail('\${talkNo}', false);" style="padding:0px 0px;">      
			<img src="https://d9f2e26giax13.cloudfront.net/etc/abcd76a3ef0d4a62b57e32d6c3b30482-1.png" style="width:100%;">
		</li>
		{{/if}}
	{{/if}}
{{/if}}
</script>

<script id="questionListTmpl" type="text/x-jquery-tmpl">
<li class="awl_content_reply_list">
	<input type="hidden" class="talkNo" value="\${talkNo}">
	<div class="awl_user">
		{{if resourceUri == ''}}
			<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"  onClick="invokeProfileFn('\${hipId}','\${mentorYn}');"/></span>
		{{else (resourceUri != '')}}
			<span class="awl_img"><img src=\${resourceUri} onClick="invokeProfileFn('\${hipId}', '\${mentorYn}');"></span>
		{{/if}}
		<div class="awl_name" data-no=\${hipId}>
			<strong class="awl_nickname">\${nickname}</strong>
			{{if hipId != userHipId && hipId != managerHipId}}
			<span class="blockContentsSpan">
				<div class="blockContents">
					<div class="drop_bar" id="contents\${hipId}"><img class="moreBlock" src="${pageContext.request.contextPath}/apps/images/ic_more.png"></div>
					<div style="display: none;" class="drop_content">
						<a href="javascript:void(0);" onClick="moveReport('\${hipId}', \${talkNo});">신고하기</a>
						<a style="display: none;" class="block" onclick="block(this, 'contents', '\${hipId}', \${talkNo})">차단하기</a>
						<a style="display: none;" class="unBlock" onclick="unBlock(this, 'contents', '\${hipId}', \${talkNo})">차단해제</a>
					</div>
				</div>
			</span>
			{{/if}}
			{{if hipId == userHipId || hipId == managerHipId}}
				<span class="blockContentsSpan"><div class="blockContents"></div></span>
			{{/if}}
			<span class="awl_date" data-no=\${expDt}>\${regDt}</span>
		</div>
		{{if mentorYn == 'Y'}}
			<span class="awl_badge" data-no=\${mentorYn}>멘토</span>
		{{else (mentorYn == 'N')}}
			<span class="awl_badge" data-no=\${mentorYn}>멘티</span>
		{{/if}}
		{{if userHipId}}
            {{if userMentorYn == 'Y'}}
                {{if mentorYn == 'N' && hipId != managerHipId}}
                <span class="txt_11 btn_question" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">제안하기</span>
                <span class="txt_11 awl_mentorMenteeInfo">
                    {{if feature}}\${feature}, \${schoolLevel}</span>
                    {{else (!feature)}}\${schoolLevel}
                    {{/if}}
                </span>
                {{/if}}
            {{else (userMentorYn == 'N')}}
                {{if mentorYn == 'Y' && hipId != managerHipId}}
                <span class="txt_11 btn_question" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">문의하기</span>
                <span class="txt_11 awl_mentorMenteeInfo">\${partyNm}, \${departmentLine}, \${studentId}학번, \${acceptanceLine}</span>
                {{else (mentorYn == 'N' && hipId != managerHipId)}}
                <span class="txt_11 awl_mentorMenteeInfo">
                    {{if feature}}\${feature}, \${schoolLevel}</span>
                    {{else (!feature)}}\${schoolLevel}
                    {{/if}}
                </span>
                {{/if}}
            {{/if}}
        {{else (!userHipId)}}
            {{if hipId != managerHipId}}
            <span class="txt_11 btn_question" onClick="getConnectChat('\${hipId}', '\${mentorYn}');">문의하기</span>
            {{/if}}
        {{/if}}
	</div>
	<p class="con blockContentsText\${hipId}" onClick="replyExtendFn(this);">{{html talkContent}}</p>
	<p class="con blockContentsImg\${hipId}" style="display: none;" onClick="replyExtendFn(this);"><img class="blockListImg" src="${pageContext.request.contextPath}/apps/images/im_block_talk_list.png"></p>
	{{if ogUrl != null}}
		<div class="awl_ogTag" onClick="moveUrl(\${ogUrl});">
			<img src=\${ogImg} class="awl_ogImg" />
			<p class="awl_ogTitle">\${ogTitle}</p>
			<p class="awl_ogDescription">\${ogDescription}</p>
			<p class="awl_ogUrl">\${ogUrl}</p>
		</div>	
	{{/if}}
	<div class="awl_box_state">
		{{if replyCnt <= 0}}
			<span class="awl_dat" onClick="replyExtendFn(this);">댓글 쓰기</span>
		{{else (replyCnt > 0)}}
			<span class="awl_dat" onClick="replyExtendFn(this);">\${replyCnt}개의 댓글 보기</span>
		{{/if}}

		<div class="awl_abs_right">
		{{if hipId == userHipId}}
			<a href="javascript:void(0);" class="btn_del" onClick="talkDelFn(this,\${talkNo});">삭제</a>
			<a href="javascript:void(0);" class="btn_upt" onClick="talkUptFn(\${talkNo});">수정</a>
		{{/if}}
		</div>
	</div>
	<div class="awl_comment_box mt10" id="awl_comment_box">
		<div class="awl_comment_head mb15">
			<img src="${pageContext.request.contextPath}/apps/images/ic_arrow_down.png" id="closeToggle" onClick="replyExtend2Fn(this);"/>
		</div>
		<div class="awl_comment_tit mt10">	
			<strong>댓글 \${replyCnt}</strong>
			<a href="javascript:void(0);" onClick="moreContentFn(\${talkNo});">댓글 모두 보기</a>
		</div>
		<div class="awl_swl_comment">
			<div class="swl_comment_input mb15">
			    <textarea rows=2 placeholder="댓글에 이모티콘 입력 불가" id="replyInput" maxlength="5500" oninput="replyInputFn(this);" onkeyup="replyInputFn(this);" onclick="replyInputFn(this);"></textarea>
			    <a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this);"/></a>
				<span class="countReply">0/5000</span>
			</div>
		</div>
		<ul class="swl_comment_list"></ul><!-- 댓글 삽입 부분 -->
	</div>
</li>
</script>

<script id="worldCloudListTmpl" type="text/x-jquery-tmpl">
<li class="awl_content_reply_list">
	<input type="hidden" class="talkNo" value="\${talkNo}">
	<div class="awl_user">
		{{if resourceUri == ''}}
			<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"/></span>
		{{else (resourceUri != '')}}
			<span class="awl_img"><img src=\${resourceUri}></span>
		{{/if}}
		<div class="awl_name" data-no=\${hipId}>
			<strong class="awl_nickname">\${nickname}</strong>
			<span class="awl_date" data-no=\${expDt}>\${regDt}</span>
		</div>
		{{if mentorYn == 'Y'}}
			<span class="awl_badge" data-no=\${mentorYn}>멘토</span>
		{{else (mentorYn == 'N')}}
			<span class="awl_badge" data-no=\${mentorYn}>멘티</span>
		{{/if}}
	</div>
	<p class="con" onClick="replyExtendFn(this);">{{html talkContent}}</p>
	{{if ogUrl != null}}
		<div class="awl_ogTag" onClick="moveUrl(\${ogUrl});">
			<img src=\${ogImg} class="awl_ogImg" />
			<p class="awl_ogTitle">\${ogTitle}</p>
			<p class="awl_ogDescription">\${ogDescription}</p>
			<p class="awl_ogUrl">\${ogUrl}</p>
		</div>	
	{{/if}}
	<div class="awl_box_state">
		{{if replyCnt <= 0}}
			<span class="awl_dat" onClick="replyExtendFn(this);">댓글 쓰기</span>
		{{else (replyCnt > 0)}}
			<span class="awl_dat" onClick="replyExtendFn(this);">\${replyCnt}개의 댓글 보기</span>
		{{/if}}

		<div class="awl_abs_right">
		{{if hipId == userHipId}}
			<a href="javascript:void(0);" class="btn_del" onClick="talkDelFn(this,\${talkNo});">삭제</a>
			<a href="javascript:void(0);" class="btn_upt" onClick="talkUptFn(\${talkNo});">수정</a>
		{{/if}}
		</div>
	</div>
	<div class="awl_comment_box mt10" id="awl_comment_box">
		<div class="awl_comment_head mb15">
			<img src="${pageContext.request.contextPath}/apps/images/ic_arrow_down.png" id="closeToggle" onClick="replyExtend2Fn(this);"/>
		</div>
		<div class="awl_comment_tit mt10">	
			<strong>댓글 \${replyCnt}</strong>
		</div>
		<div class="awl_swl_comment">
			<div class="swl_comment_input mb15">
			    <textarea rows=2 placeholder="댓글에 이모티콘 입력 불가" id="replyInput" maxlength="5500" oninput="replyInputFn(this);" onkeyup="replyInputFn(this);" onclick="replyInputFn(this);"></textarea>
			    <a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo});"/></a>
				<span class="countReply">0/5000</span>
			</div>
		</div>
		<ul class="swl_comment_list"></ul><!-- 댓글 삽입 부분 -->
	</div>
</li>
</script>

<script id="noDataTmpl" type="text/x-jquery-tmpl">
	<div class="no_show2">
		<h2>\${msgData}</h2>
	</div>
</script>

<script id="bookmarkListTmpl" type="text/x-jquery-tmpl">
<li class="awl_content_reply_list" data-no="\${talkNo}" data-isVoice=\${isVoice} onclick="moveDetail(\${opentalkNo},\${talkNo});">
	{{if categoryNm != null}}
		<p class="awl_categoryNm">\${categoryNm}</p>
	{{/if}}
	<div class="awl_user">
		{{if resourceUri == ''}}
			<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"/></span>
		{{else (resourceUri != '')}}
			<span class="awl_img"><img src=\${resourceUri}></span>
		{{/if}}
		<div class="awl_name" data-no=\${hipId}>
			<strong class="awl_nickname">\${nickname}</strong>
			<span class="awl_date" data-no=\${expDt}>\${regDt}</span>
		</div>
		{{if mentorYn == 'Y'}}
			<span class="awl_badge" data-no=\${mentorYn}>멘토</span>
		{{else (mentorYn == 'N')}}
			<span class="awl_badge" data-no=\${mentorYn}>멘티</span>
		{{/if}}
		{{if userHipId}}
            {{if userMentorYn == 'Y'}}
                {{if mentorYn == 'N' && hipId != managerHipId}}
                <span class="txt_11 btn_question">제안하기</span>
                <span class="txt_11 awl_mentorMenteeInfo">\${schoolInfo}</span>
                {{/if}}
            {{else (userMentorYn == 'N')}}
                {{if mentorYn == 'Y' && hipId != managerHipId}}
                <span class="txt_11 btn_question">문의하기</span>
                <span class="txt_11 awl_mentorMenteeInfo">\${schoolInfo}</span>
                {{else (mentorYn == 'N' && hipId != managerHipId)}}
                <span class="txt_11 awl_mentorMenteeInfo">\${schoolInfo}</span>
                {{/if}}
            {{/if}}
        {{else (!userHipId)}}
            {{if hipId != managerHipId}}
            <span class="txt_11 btn_question">문의하기</span>
            {{/if}}
        {{/if}}
	</div>
	<p class="con blockContentsText\${hipId}">{{html talkContent}}</p>
	<p class="con blockContentsImg\${hipId}" style="display: none;"><img class="blockListImg" src="${pageContext.request.contextPath}/apps/images/im_block_talk_list.png"></p>
	<div class="awl_box_state">
		{{if replyCnt <= 0}}
			<span class="awl_dat"></span>
		{{else (replyCnt > 0)}}
			<span class="awl_dat">\${replyCnt}개의 댓글</span>
		{{/if}}
		<div class="awl_abs_right">
		{{if opentalkNo == 1}}
			{{if userCloseDate == null && adoptPoint != 0}}
   				<a href="javascript:void(0);" class="btn_select txt_13">채택 포인트 : \${adoptPoint}P</a>
			{{else (userCloseDate != null)}}
    			{{if userAdoptType == 'questioner'}}
					{{if talkNo <= 913}}
						<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(5,000P)</a>
					{{else (talkNo > 913)}}
						<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(\${adoptPoint}P)</a>
					{{/if}}
				{{else (userAdoptType == 'system')}}
					{{if talkNo <= 913}}
						<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(5,000P)</a>
					{{else (talkNo > 913)}}
						<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(\${adoptPoint}P)</a>
					{{/if}}
				{{/if}}
			{{/if}}
		{{else (opentalkNo == 6)}}
			{{if userCloseDate == null && adoptPoint != 0}}
   				<a href="javascript:void(0);" class="btn_select2 txt_13">채택 포인트 : \${adoptPoint}P</a>
			{{else (userCloseDate != null)}}
    			{{if userAdoptType == 'questioner'}}
					<a href="javascript:void(0);" class="btn_endSelect2 txt_13">질문자 채택(\${adoptPoint}P)</a>
				{{else (userAdoptType == 'questioner')}}
					<a href="javascript:void(0);" class="btn_endSelect2 txt_13">자동 마감(\${adoptPoint}P)</a>
				{{/if}}
			{{/if}}
		{{/if}}
		</div>
	</div>
</li>
</script>

<script id="noSearchDataTmpl" type="text/x-jquery-tmpl">
<div class="no_show3">
	<h2>\${msgData}</h2>
</div>
</script>

<script id="adoptRankListTmpl" type="text/x-jquery-tmpl">
<div class="adopt_rankDesc">
	<img src="${pageContext.request.contextPath}/apps/images/ic_trophy.png">
	<p class="adopt_description txt_12 fw_500">\${description}</p>
	<p class="adopt_title txt_13 fw_500" style="letter-spacing: -0.5px;">\${title}</p>
</div>
</script>

<script id="adoptAccountListTmpl" type="text/x-jquery-tmpl">
{{if displayOrder == 1}}
	<div class="adopt_accountList">
	{{if resourceUri == ''}}
		<img src="${pageContext.request.contextPath}/apps/images/ico_37.png" class="adopt_accountImg"/>
		<img src="https://d9f2e26giax13.cloudfront.net/etc/c9a5a3f085a445a6940b70cfe268da44.png" class="badge_rankDisplayOrder">
	{{else (resourceUri != '')}}
		<img src=\${resourceUri} class="adopt_accountImg">
		<img src="https://d9f2e26giax13.cloudfront.net/etc/c9a5a3f085a445a6940b70cfe268da44.png" class="badge_rankDisplayOrder">
	{{/if}}
	</div>
{{else (displayOrder == 2)}}
	<div class="adopt_accountList">
	{{if resourceUri == ''}}
		<img src="${pageContext.request.contextPath}/apps/images/ico_37.png" class="adopt_accountImg"/>
		<img alt="" src="https://d9f2e26giax13.cloudfront.net/etc/cc5f8fb0c3b84436b8db1973d8291e60.png" class="badge_rankDisplayOrder"/>
	{{else (resourceUri != '')}}
		<img src=\${resourceUri} class="adopt_accountImg">
		<img alt="" src="https://d9f2e26giax13.cloudfront.net/etc/cc5f8fb0c3b84436b8db1973d8291e60.png" class="badge_rankDisplayOrder"/>
	{{/if}}
	</div>
{{else (displayOrder == 3)}}
	<div class="mr0 adopt_accountList">
	{{if resourceUri == ''}}
		<img src="${pageContext.request.contextPath}/apps/images/ico_37.png" class="adopt_accountImg"/>
		<img alt="" src="https://d9f2e26giax13.cloudfront.net/etc/2ee9f86057ee45fdbb45003a972b7db0.png" class="badge_rankDisplayOrder"/>
	{{else (resourceUri != '')}}
		<img src=\${resourceUri} class="adopt_accountImg">
		<img alt="" src="https://d9f2e26giax13.cloudfront.net/etc/2ee9f86057ee45fdbb45003a972b7db0.png" class="badge_rankDisplayOrder"/>
	{{/if}}
	</div>
{{/if}}
</div>
</script>

<script id="questionRankListTmpl" type="text/x-jquery-tmpl">
<div class="question_rankDesc">
	<img src="${pageContext.request.contextPath}/apps/images/ic_trophy.png">
	<p class="question_description txt_12 fw_500">\${description}</p>
	<p class="question_title txt_13 fw_500">\${title}</p>
</div>
</script>

<script id="questionAccountListTmpl" type="text/x-jquery-tmpl">
{{if displayOrder == 1}}
	<div class="question_accountList">
	{{if resourceUri == ''}}
		<img src="${pageContext.request.contextPath}/apps/images/ico_37.png" class="question_accountImg"/>
		<img src="https://d9f2e26giax13.cloudfront.net/etc/c9a5a3f085a445a6940b70cfe268da44.png" style="position:relative; width:auto; height:auto; max-width:24px; max-height:24px; transform:translate(80%, -80%);">
	{{else (resourceUri != '')}}
		<img src=\${resourceUri} class="question_accountImg">
		<img src="https://d9f2e26giax13.cloudfront.net/etc/c9a5a3f085a445a6940b70cfe268da44.png" style="position:relative; width:auto; height:auto; max-width:24px; max-height:24px; transform:translate(80%, -80%);">
	{{/if}}
	</div>
{{else (displayOrder == 2)}}
	<div class="question_accountList">
	{{if resourceUri == ''}}
		<img src="${pageContext.request.contextPath}/apps/images/ico_37.png" class="question_accountImg"/>
		<img alt="" src="https://d9f2e26giax13.cloudfront.net/etc/cc5f8fb0c3b84436b8db1973d8291e60.png" style="position:relative; width:auto; height:auto; max-width:24px; max-height:24px; transform:translate(80%, -80%);" />
	{{else (resourceUri != '')}}
		<img src=\${resourceUri} class="question_accountImg">
		<img alt="" src="https://d9f2e26giax13.cloudfront.net/etc/cc5f8fb0c3b84436b8db1973d8291e60.png" style="position:relative; width:auto; height:auto; max-width:24px; max-height:24px; transform:translate(80%, -80%);" />
	{{/if}}
	</div>
{{else (displayOrder == 3)}}
	<div class="mr0 question_accountList">
	{{if resourceUri == ''}}
		<img src="${pageContext.request.contextPath}/apps/images/ico_37.png" class="question_accountImg"/>
		<img alt="" src="https://d9f2e26giax13.cloudfront.net/etc/2ee9f86057ee45fdbb45003a972b7db0.png" style="position:relative; width:auto; height:auto; max-width:24px; max-height:24px; transform:translate(80%, -80%);" />
	{{else (resourceUri != '')}}
		<img src=\${resourceUri} class="question_accountImg">
		<img alt="" src="https://d9f2e26giax13.cloudfront.net/etc/2ee9f86057ee45fdbb45003a972b7db0.png" style="position:relative; width:auto; height:auto; max-width:24px; max-height:24px; transform:translate(80%, -80%);" />
	{{/if}}
	</div>
{{/if}}

</script>


<script id="expertMentorTalkListTmpl" type="text/x-jquery-tmpl">
<li data-idx=\${opentalkNo} data-no=\${talkNo} data-poll=\${pollNo} data-voice=\${isVoice} onclick="moveDetail(this);">
	<div class="mytalk_header">
		{{if opentalkNo == 1}}
			{{if categoryNm != null}}
				<p class="mytalk_categoryNm">\${categoryNm}</p>
			{{/if}}
		{{else (opentalkNo == 6)}}
			{{if categoryNm != null}}
				<p class="mytalk_categoryNm2">\${categoryNm}</p>
			{{/if}}
		{{/if}}
			<p class="mytalk_profile_2 13px" style="border: solid 3px #fd7601; color: #fd7601;">파워<br>댓글</p>
					<p class="mytalk_info txt_11">
						\${schoolInfo} 멘티
						{{if isAdopt == true}}
						<br>(\${adoptPoint}) 댓글
						{{else}}
						<br>댓글
						{{/if}}
					</p>
		<p class="mytalk_regDt">\${regDt}</p>
	</div>
	<div class="mytalk_content mt0 mb15">
		<p class="txt_13">\${talkContent}</p>
	</div>
	{{if isReply == true}}
		<div class="mytalk_reply" style="max-height: 60px;">
			<p class="txt_13" style="white-space: pre-wrap; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; word-wrap: break-word;">\${replyContent}</p>
		</div>
	{{/if}}
</li>
</script>

<script id="expertMentorTalkMainListTmpl" type="text/x-jquery-tmpl">
<li data-idx=\${opentalkNo} data-no=\${talkNo} data-poll=\${pollNo} data-voice=\${isVoice} onclick="moveDetail(this);">
	<div class="mytalk_header" style="margin-bottom: 4px; grid-template-rows: repeat(2,19px);">
		{{if opentalkNo == 1}}
			{{if categoryNm != null}}
				<p class="mytalk_categoryNm">\${categoryNm}</p>
			{{/if}}
		{{else (opentalkNo == 6)}}
			{{if categoryNm != null}}
				<p class="mytalk_categoryNm2">\${categoryNm}</p>
			{{/if}}
		{{/if}}
			<p class="mytalk_profile_2 13px" style="border: solid 2px #fd7601; color: #fd7601; font-size: 12px; line-height: 1;max-width: 32px; max-height: 32px;">파워<br>댓글</p>
					<p class="mytalk_info txt_11">
						\${schoolInfo} 멘티
						{{if isAdopt == true}}
						<br>(\${adoptPoint}) 댓글
						{{else}}
						<br>댓글
						{{/if}}
					</p>
		<p class="mytalk_regDt">\${regDt}</p>
	</div>
	<div class="mytalk_content mt0 mb10" style="padding-left: 5px;">
		<p class="txt_13" style="height: 37px; white-space: pre-wrap; word-break: break-all; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; word-wrap: break-word;">\${talkContent}</p>
	</div>
	{{if isReply == true}}
		<div class="mytalk_reply" style="padding: 1px 10px;">
			<p class="txt_13">\${replyContent}</p>
		</div>
	{{/if}}
</li>
</script>
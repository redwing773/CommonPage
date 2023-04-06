<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="basicReplyInputTmpl" type="text/x-jquery-tmpl">
  <div class="swl_comment_input mb15">
    <textarea class="replyArea" rows=2 name="reply_\${replyNo}" placeholder="댓글에 이모티콘 입력 불가" maxlength="500" oncopy="return false;" onpaste="openAlertPopupMoji('댓글 복사,붙여넣기 금지'); return false;" oncut="return false;" onkeyup="uptFn(this, \${opentalkNo});" style="background:#ffffff;color:black;">\${replyContent}</textarea>
    <a href="#">
        <img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyModifyFn(this,\${replyNo},\${talkNo},\${opentalkNo});">
    </a>
	<span class="countReply" style="opacity:1;">\${len}/500</span>
</div>
</script>

<script id="opentalkListTmpl" type="text/x-jquery-tmpl">
<li class="awl_content_reply_list">
	<input type="hidden" class="talkNo" value="\${talkNo}">
	{{if categoryNm != null}}
		<p class="awl_categoryNm">\${categoryNm}</p>
	{{/if}}
	<div class="awl_user">
		<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"  onClick="invokeProfileFn('\${hipId}','\${mentorYn}');"/></span>
		<div class="awl_name" data-no=\${hipId}>
			<strong class="awl_nickname">\${nickname}</strong>
			<span class="blockContentsSpan"><div class="blockContents"></div></span>
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
            {{if userMentorYn == 'Y'}}
                {{if mentorYn == 'N' && hipId != managerHipId && hipId != managerSupportHipId}}
					{{if mojiEmail == null}}
						<span class="txt_11 awl_mentorMenteeInfo">
					{{else}}
						<span class="txt_11 awl_mentorMenteeInfo_moji">
					{{/if}}
                    {{if feature}}\${feature}, \${schoolLevel}</span>
                    {{else (!feature)}}\${schoolLevel}
                    {{/if}}
                </span>
                {{/if}}
            {{else (userMentorYn == 'N')}}
                {{if mentorYn == 'Y' && hipId != managerHipId && hipId != managerSupportHipId}}
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

				{{/if}}
			{{else (userMentorYn == 'Y')}}
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
			</p>
			<strong style="display: inline-block; margin-top:-12px;">댓글 \${replyCnt}</strong>
			<a href="javascript:void(0);" onClick="moreContentFn(\${talkNo});">댓글 모두 보기</a>
		</div>
		<div class="awl_swl_comment">
			<div class="swl_comment_input mb15">
			    <textarea rows=2 placeholder="댓글에 이모티콘 입력 불가" id="replyInput" maxlength="500" oncopy="return false;" onpaste="openAlertPopupMoji('댓글 복사,붙여넣기 금지'); return false;" oncut="return false;" onkeyup="replyInputFn(this, \${opentalkNo});" onclick="replyInputFn(this, \${opentalkNo});"></textarea>
			    {{if closeDate == null}}
					<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo}, false);"/></a>
				{{else (closeDate != null)}}
					<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo}, true);"/></a>
				{{/if}}
				<span class="countReply">0/500</span>
			</div>
		</div>
		<ul class="swl_comment_list"></ul><!-- 댓글 삽입 부분 -->
	</div>
</li>
</script>

<script id="opentalkMyListTmpl" type="text/x-jquery-tmpl">
<li class="awl_content_reply_list">
	<input type="hidden" class="talkNo" value="\${talkNo}">
	{{if categoryNm != null}}
		<p class="awl_categoryNm">\${categoryNm}</p>
	{{/if}}
	<div class="awl_user">
		<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"  onClick="invokeProfileFn('\${hipId}','\${mentorYn}');"/></span>
		<div class="awl_name" data-no=\${hipId}>
			<strong class="awl_nickname">\${nickname}</strong>
			<span class="blockContentsSpan"><div class="blockContents"></div></span>
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
            {{if userMentorYn == 'Y'}}
                {{if mentorYn == 'N' && hipId != managerHipId && hipId != managerSupportHipId}}
					{{if mojiEmail == null}}
						<span class="txt_11 awl_mentorMenteeInfo">
					{{else}}
						<span class="txt_11 awl_mentorMenteeInfo_moji">
					{{/if}}
                    {{if feature}}\${feature}, \${schoolLevel}</span>
                    {{else (!feature)}}\${schoolLevel}
                    {{/if}}
                </span>
                {{/if}}
            {{else (userMentorYn == 'N')}}
                {{if mentorYn == 'Y' && hipId != managerHipId && hipId != managerSupportHipId}}
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
	</div>
	{{if delDt != null}}
        <p style="font-size: 12px; font-weight: bold;line-height: 1.08;letter-spacing: -0.48px;color: #d82626;">질문톡 운영 정책에 따라 해당 글이 비노출 되어 이 글을 볼 수 없습니다.</p>
        <p class="con" style="color:#9a9a9a;">{{html talkContent}}</p>
    {{else}}
        <p class="con" onClick="replyExtendFn(this);">{{html talkContent}}</p>
    {{/if}}
	{{if ogUrl != null}}
		<div class="awl_ogTag" onClick="moveUrl(\${ogUrl});">
			<img src=\${ogImg} class="awl_ogImg" />
			<p class="awl_ogTitle">\${ogTitle}</p>
			<p class="awl_ogDescription">\${ogDescription}</p>
			<p class="awl_ogUrl">\${ogUrl}</p>
		</div>
	{{/if}}
	<div class="awl_box_state">
        {{if delDt != null}}
            {{if replyCnt <= 0}}
                <span class="awl_dat" onClick="replyExtendDelFn(this);">댓글 쓰기</span>
            {{else (replyCnt > 0)}}
                <span class="awl_dat" onClick="replyExtendDelFn(this);">\${replyCnt}개의 댓글 보기</span>
            {{/if}}
        {{else}}
            {{if replyCnt <= 0}}
                <span class="awl_dat" onClick="replyExtendFn(this);">댓글 쓰기</span>
            {{else (replyCnt > 0)}}
                <span class="awl_dat" onClick="replyExtendFn(this);">\${replyCnt}개의 댓글 보기</span>
            {{/if}}
        {{/if}}
		<div class="awl_abs_right">
		{{if delDt == null}}
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

				{{/if}}
			{{else (userMentorYn == 'Y')}}
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
	{{/if}}
	<div class="awl_comment_box mt10" id="awl_comment_box">
		<div class="awl_comment_head mb15">
			<img src="${pageContext.request.contextPath}/apps/images/ic_arrow_down.png" id="closeToggle" onClick="replyExtend2Fn(this);"/>
		</div>
		<div class="awl_comment_tit mt10">
			<p class="adoptPercentForList"><span style="font-weight: bold;color:#000000">질문자의 </span>질문수 <span style="color: #302cc8;" id="questionSum\${talkNo}"></span>
			</p>
			<strong style="display: inline-block; margin-top:-12px;">댓글 \${replyCnt}</strong>
			{{if delDt != null}}
			    <a href="javascript:void(0);" onClick="moreContentDelFn(\${talkNo});">댓글 모두 보기</a>
			{{else}}
			    <a href="javascript:void(0);" onClick="moreContentFn(\${talkNo});">댓글 모두 보기</a>
			{{/if}}
		</div>
		{{if delDt != null}}
		{{else}}
		<div class="awl_swl_comment">
			<div class="swl_comment_input mb15">
			    <textarea rows=2 placeholder="댓글에 이모티콘 입력 불가" id="replyInput" maxlength="500" oncopy="return false;" onpaste="openAlertPopupMoji('댓글 복사,붙여넣기 금지'); return false;" oncut="return false;" onkeyup="replyInputFn(this, \${opentalkNo});" onclick="replyInputFn(this, \${opentalkNo});"></textarea>
			    {{if closeDate == null}}
					<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo}, false);"/></a>
				{{else (closeDate != null)}}
					<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo}, true);"/></a>
				{{/if}}
				<span class="countReply">0/500</span>
			</div>
		</div>
		{{/if}}
		<ul class="swl_comment_list"></ul><!-- 댓글 삽입 부분 -->
	</div>
</li>
<%--<li class="awl_content_reply_list">--%>
<%--	{{if delDt != null}}--%>
<%--		<input name="talkNo\${talkNo}" type="hidden" class="talkNo delTalk" value="\${talkNo}">--%>
<%--	{{else}}--%>
<%--		<input name="talkNo\${talkNo}" type="hidden" class="talkNo" value="\${talkNo}">--%>
<%--	{{/if}}--%>
<%--		<div class="awl_name" data-no=\${hipId}>--%>
<%--			<strong class="awl_nickname">\${nickname}</strong>--%>
<%--			<span class="awl_date" data-no=\${expDt}>\${regDt}</span>--%>
<%--		</div>--%>
<%--	{{if delDt != null}}--%>
<%--		<p style="font-size: 12px; font-weight: bold;line-height: 1.08;letter-spacing: -0.48px;color: #d82626;">멘토톡 정책에 따라 글이 비노출 되었어요. 다른 사용자는 이 글을 볼 수 없어요.</p>--%>
<%--		<p class="con" onClick="replyExtendDelFn(this);" style="color:#9a9a9a;">{{html talkContent}}</p>--%>
<%--	{{else}}--%>
<%--		<p class="con" onClick="replyExtendFn(this);">{{html talkContent}}</p>--%>
<%--	{{/if}}--%>
<%--	<div class="awl_box_state">--%>
<%--		{{if replyCnt <= 0}}--%>
<%--			<span class="awl_dat" onClick="replyExtendFn(this);">댓글 보기</span>--%>
<%--		{{else (replyCnt > 0)}}--%>
<%--			<span class="awl_dat" onClick="replyExtendFn(this);">\${replyCnt}개의 댓글 보기</span>--%>
<%--		{{/if}}--%>
<%--		<div class="awl_abs_right">--%>
<%--        {{if delDt == null}}--%>
<%--		{{if hipId == userHipId}}--%>
<%--				{{if userHipId != managerHipId  && userHipId != managerSupportHipId}}--%>
<%--					{{if closeDate == null && adoptPoint != 0}}--%>
<%--   						<a href="javascript:void(0);" class="btn_select txt_13">채택 포인트 : \${adoptPoint}P</a>--%>
<%--					{{else (closeDate != null)}}--%>
<%--    				 	{{if adoptType == 'questioner' || adoptType == 'questioner_req'}}--%>
<%--							{{if talkNo <= 913}}--%>
<%--								<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(5,000P)</a>--%>
<%--							{{else (talkNo > 913)}}--%>
<%--								<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(\${adoptPoint}P)</a>--%>
<%--							{{/if}}--%>
<%--						{{else (adoptType == 'system' || adoptType == 'system_req')}}--%>
<%--							{{if talkNo <= 913}}--%>
<%--								<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(5,000P)</a>--%>
<%--							{{else (talkNo > 913)}}--%>
<%--								<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(\${adoptPoint}P)</a>--%>
<%--							{{/if}}--%>
<%--						{{/if}}--%>
<%--					{{/if}}--%>
<%--				{{/if}}--%>
<%--		{{/if}}--%>
<%--		{{if hipId != userHipId && mentorYn == 'N'}}--%>
<%--			{{if hipId != managerHipId && hipId != managerSupportHipId}}--%>
<%--				{{if closeDate == null && adoptPoint != 0}}--%>
<%--   					<a href="javascript:void(0);" class="btn_select txt_13">채택 포인트 : \${adoptPoint}P</a>--%>
<%--				{{else (closeDate != null)}}--%>
<%--    				 {{if adoptType == 'questioner' || adoptType == 'questioner_req'}}--%>
<%--						{{if talkNo <= 913}}--%>
<%--							<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(5,000P)</a>--%>
<%--						{{else (talkNo > 913)}}--%>
<%--							<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(\${adoptPoint}P)</a>--%>
<%--						{{/if}}--%>
<%--					{{else (adoptType == 'system' || adoptType == 'system_req')}}--%>
<%--						{{if talkNo <= 913}}--%>
<%--							<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(5,000P)</a>--%>
<%--						{{else (talkNo > 913)}}--%>
<%--							<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(\${adoptPoint}P)</a>--%>
<%--						{{/if}}--%>
<%--					{{/if}}--%>
<%--				{{/if}}--%>
<%--			{{/if}}--%>
<%--		{{/if}}--%>
<%--		{{/if}}--%>
<%--		</div>--%>
<%--	</div>--%>
<%--	<div class="awl_comment_box mt10" id="awl_comment_box">--%>
<%--		<div class="awl_comment_head mb15">--%>
<%--			<img src="${pageContext.request.contextPath}/apps/images/ic_arrow_down.png" id="closeToggle" onClick="replyExtend2Fn(this);"/>--%>
<%--		</div>--%>
<%--		<div class="awl_comment_tit mt10">	--%>
<%--			<p class="adoptPercentForList"><span style="font-weight: bold;color:#000000">질문자의 </span>질문수 <span style="color: #302cc8;" id="questionSum\${talkNo}"></span></p>--%>
<%--			 {{if replyCnt > 0}}--%>
<%--				<strong style="display: inline-block; margin-top:-12px;">댓글 \${replyCnt}</strong>--%>
<%--			{{else}}--%>
<%--				<strong style="display: inline-block; margin-top:-12px;">댓글 0</strong>--%>
<%--			{{/if}}--%>
<%--			{{if delDt != null}}--%>
<%--				<a href="javascript:void(0);" onClick="moreContentDelFn(\${talkNo});">댓글 모두 보기</a>--%>
<%--			{{else}}--%>
<%--				<a href="javascript:void(0);" onClick="moreContentFn(\${talkNo});">댓글 모두 보기</a>--%>
<%--			{{/if}}--%>
<%--		</div>--%>
<%--		{{if delDt != null}}--%>
<%--		{{else}}--%>
<%--		<div class="awl_swl_comment">--%>
<%--			<div class="swl_comment_input mb15">--%>
<%--			    <textarea rows=2 placeholder="댓글에 이모티콘 입력 불가" id="replyInput" maxlength="500" oncopy="return false;" onpaste="openAlertPopupMoji('댓글 복사,붙여넣기 금지'); return false;" oncut="return false;" onkeyup="replyInputFn(this, \${opentalkNo});" onclick="replyInputFn(this, \${opentalkNo});"></textarea>--%>
<%--			    {{if closeDate == null}}--%>
<%--					<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo}, false);"/></a>--%>
<%--				{{else (closeDate != null)}}--%>
<%--					<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, \${opentalkNo}, true);"/></a>--%>
<%--				{{/if}}--%>
<%--				<span class="countReply">0/500</span>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		{{/if}}--%>
<%--		<ul class="swl_comment_list moji_board_reply"></ul><!-- 댓글 삽입 부분 -->--%>
<%--	</div>--%>
<%--</li>--%>
</script>
<script id="noDataTmpl" type="text/x-jquery-tmpl">
	<div class="no_show2">
		<h2>\${msgData}</h2>
	</div>
</script>
<script id="alert_moji" type="text/x-jquery-tmpl">
	        <div class="outter_box">
	            <div class="inner_box" style="width: 320px;  min-height: 179px; padding: 40px 25px 95px 25px;  text-align: center; border-radius: 6px;">
	                <h2 class="title" style="font-size: 15px; line-height: 22px; color: #3A3A3A; font-weight: 500; letter-spacing: -0.5px;">{{html title}}</h2>
	                <div class="btn_box" style=" width: 100%; position: absolute; left: 0px; bottom: 0px;">
	                    <a href="javascript:void(0);" class="btn_40" style="width:100%; background: #302cc8; line-height: 60px; height: 60px; font-size: 16px;" onclick="Layer_CLOSE('.popup_alert_moji')">확인</a>
	                </div>
	            </div>
	        </div>
</script>
<script id="confirm_moji" type="text/x-jquery-tmpl">
	        <div class="outter_box">
	            <div class="inner_box" style=" width: 320px;  min-height: 179px; padding: 40px 25px 95px 25px;  text-align: center; border-radius: 6px;">
	                <h2 class="title" style="font-size: 15px; line-height: 22px; color: #3A3A3A; font-weight: 500; letter-spacing: -0.5px;">{{html title}}</h2>
	                <div class="btn_box" style=" width: 100%; position: absolute; left: 0px; bottom: 0px; display:grid; grid-template-columns:1fr 1fr; grid-template-areas:'a b'"">
	                    <a href="javascript:void(0);" class="btn_40" id="cancelWord" style="grid-area:a; background: #e5e5e5; line-height: 60px; height: 60px; font-size: 16px; color: #000 !important;" onclick="Layer_CLOSE('.popup_confirm_moji')">\${cancelWord}</a>
	                    <a href="javascript:void(0);" class="btn_40" id="checkWord" style="grid-area:b; background: #302cc8; line-height: 60px; height: 60px; font-size: 16px;">\${checkWord}</a>
	                </div>
	            </div>
	        </div>
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
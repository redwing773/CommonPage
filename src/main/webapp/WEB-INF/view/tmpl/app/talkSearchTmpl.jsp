<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<script id="talkQuestionSearchListTmpl" type="text/x-jquery-tmpl">
<li class="awl_content_reply_list">
	<input type="hidden" class="talkNo" value="\${talkNo}">
	<input type="hidden" class="rankNo" value="\${rankNo}">
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
						<a href="javascript:void(0);" onClick="moveReport('\${hipId}', \${talkNo}, 1);">신고하기</a>
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
	<p class="con blockContentsText\${hipId} clickable" onClick="moreContentQuestionFn(this, \${talkNo}, '\${from}');">{{html talkContent}}</p>
	<p class="con blockContentsImg\${hipId} clickable" style="display: none;" onClick="moreContentQuestionFn(this, \${talkNo}, '\${from}');"><img class="blockListImg" src="${pageContext.request.contextPath}/apps/images/im_block_talk_list.png"></p>
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
			<span class="awl_dat clickable" onClick="moreContentQuestionFn(this, \${talkNo}, '\${from}');">댓글 쓰기</span>
		{{else (replyCnt > 0)}}
			<span class="awl_dat clickable" onClick="moreContentQuestionFn(this, \${talkNo}, '\${from}');">\${replyCnt}개의 댓글 보기</span>
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
				{{/if}}
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
</li>
</script>

<script id="talkFreeSearchListTmpl" type="text/x-jquery-tmpl">
<li class="awl_content_reply_list">
	<input type="hidden" class="talkNo" value="\${talkNo}">
	<input type="hidden" class="rankNo" value="\${rankNo}">
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
						<a href="javascript:void(0);" onClick="moveReport('\${hipId}', \${talkNo}, 3);">신고하기</a>
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
	<p class="con blockContentsText\${hipId} clickable" onClick="moreContentFreeFn(this, \${talkNo}, '\${from}');">{{html talkContent}}</p>
	<p class="con blockContentsImg\${hipId} clickable" style="display: none;" onClick="moreContentFreeFn(this, \${talkNo}, '\${from}');"><img class="blockListImg" src="${pageContext.request.contextPath}/apps/images/im_block_talk_list.png"></p>
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
			<span class="awl_dat clickable" onClick="moreContentFreeFn(this, \${talkNo}, '\${from}');">댓글 쓰기</span>
		{{else (replyCnt > 0)}}
			<span class="awl_dat clickable" onClick="moreContentFreeFn(this, \${talkNo}, '\${from}');">\${replyCnt}개의 댓글 보기</span>
		{{/if}}
	</div>
</li>
</script>

<script id="talkPollSearchListTmpl" type="text/x-jquery-tmpl">
<li data-no=\${pollNo}>
    <input type="hidden" class="rankNo" value="\${rankNo}">
	<div class="vote_headerBox mb10">
		{{if status == 2}}
			<button type="button" class="red">진행중</button>
		{{else (status == 3)}}
			<button type="button" class="black">종료</button>
		{{else (status == 1)}}
			<button type="button" class="black">대기중</button>
		{{/if}}
		<button type="button" class="mint">\${joinReward}</button>
		<button type="button" class="purple">
		{{if joinTargetType == 1}}
			전체 참여 가능
		{{else (joinTargetType == 2)}}
			멘토 참여 가능
		{{else (joinTargetType == 3)}}
			멘티 참여 가능
		{{/if}}
		</button>
		<button type="button" class="bgray">\${subject}</button>
	</div>
	<div class="vote_contentBox">
		<div class="vote_header">
			<h2 class="voteTit">{{html title}}</h2>
			<p class="voteCnt">투표자 수 <span>\${answerNumber}</span></p>
			<p class="votePeriod">투표기간 <span>\${startDate} ~ \${endDate}</span></p>
		</div>
		<div class="vote_content">
			<div class="vote_img mb10">
				<img src=\${imgUri}>
			</div>
			<div class="vote_txt">
				<p class="voteContents clickable" onClick="moveVoteDetail(this, \${talkNo}, \${pollNo}, '\${from}');">{{html contents}}</p>
			</div>
		</div>
	</div>
</li>
</script>

<script id="replyTalkSearchListTmpl" type="text/x-jquery-tmpl">
    <li>
        <input type="hidden" class="talkNo" value="\${talkNo}">
        <input type="hidden" class="rankNo" value="\${rankNo}">
        <p class="name"><strong style="min-width: 41px;">답변자 :</strong>
        {{if mentorYn == 'Y'}}
			<span class="badge" data-no=\${mentorYn}>멘토</span>
		{{else (mentorYn == 'N')}}
			<span class="badge" data-no=\${mentorYn}>멘티</span>
		{{/if}}
        {{if userHipId}}
            {{if userMentorYn == 'Y'}}
                {{if mentorYn == 'N' && hipId != managerHipId}}
                <span>
                    {{if feature}}\${feature}, \${schoolLevel}</span>
                    {{else (!feature)}}\${schoolLevel}
                    {{/if}}
                </span>
                {{/if}}
            {{else (userMentorYn == 'N')}}
                {{if mentorYn == 'Y' && hipId != managerHipId}}
                <span>\${partyNm}, \${departmentLine}, \${studentId}학번, \${acceptanceLine}</span>
                {{else (mentorYn == 'N' && hipId != managerHipId)}}
                <span>
                    {{if feature}}\${feature}, \${schoolLevel}</span>
                    {{else (!feature)}}\${schoolLevel}
                    {{/if}}
                </span>
                {{/if}}
            {{/if}}
        {{/if}}
        </p>
        <p class="txt con blockContentsText\${hipId} clickable" onClick="moreContentTypeReplyFn(this, \${talkNo}, \${opentalkNo}, \${pollNo}, '\${from}');">{{html replyContent}}</p>
	    <p class="con blockContentsImg\${hipId} clickable" style="display: none;" onClick="moreContentTypeReplyFn(this, \${talkNo}, \${opentalkNo}, \${pollNo}, '\${from}');"><img class="blockListImg" src="${pageContext.request.contextPath}/apps/images/im_block_talk_list.png"></p>
	    {{if categoryNm != ""}}
            <span class="hashtag">\${categoryNm}</span>
        {{/if}}
    </li>
</script>

<script id="noDataTmpl" type="text/x-jquery-tmpl">
	<div class="no_show2">
		<h2>\${msgData}</h2>
	</div>
</script>

<script id="talkNoDataRecommendTmpl" type="text/x-jquery-tmpl">
    <p class="no_list_02">조회된 결과가 없습니다.</p>
    <div class="line_07"></div>
    <div class="line_01 mb15"></div>
    <h3 class="txt_10 fw_500 mb10">톡TALK 인기 검색어</h3>
    <div class="rank_list">
        <ol id="recommend1">
        </ol>
        <ol id="recommend2">
        </ol>
    </div>
</script>

<script id="recommendTmpl" type="text/x-jquery-tmpl">
    {{if upDownRanking > 0}}
        <li><a href="#self" onclick="recommendWordClick('\${keyword}')"><em class="no">\${ranking}.</em>\${keyword} <span class="up">\${upDownRanking}</span></a></li>
    {{else (upDownRanking < 0)}}
        <li><a href="#self" onclick="recommendWordClick('\${keyword}')"><em class="no">\${ranking}.</em>\${keyword} <span class="down">\${upDownRanking}</span></a></li>
    {{else (upDownRanking == 0)}}
        <li><a href="#self" onclick="recommendWordClick('\${keyword}')"><em class="no">\${ranking}.</em>\${keyword} <span>\${upDownRanking}</span></a></li>
    {{/if}}
</script>

<script id="recommendTmpl2" type="text/x-jquery-tmpl">
     <li><a href="#self" onclick="recommendWordClick('\${keyword}')">#\${keyword}</a></li>
</script>

<script id="talkNoDataRecommendTmpl2" type="text/x-jquery-tmpl">
    <div class="rank_list_box">
        <div class="rank_list">
            <ol>
                <img class="portal_search_icon next" src="${pageContext.request.contextPath}/pc/images/portal_search_icon_01_1.png"  onClick="moveToRight();"/>
                <span id="recommend"></span>
                <img class="portal_search_icon prev" src="${pageContext.request.contextPath}/pc/images/portal_search_icon_02_1.png"  onClick="moveToLeft();"/>
            </ol>
        </div>
    </div>
</script>
<script id="talkNoDataRecommendTmpl3" type="text/x-jquery-tmpl">
    <div class="rank_list_box">
        <div class="rank_list">
            <ol>
                <span id="recommend"></span>
            </ol>
        </div>
    </div>
    <div style="margin-top: 95px; text-align: center;">
        <img style="width: 44px;" src="${pageContext.request.contextPath}/pc/images/portal_emoji.png"/>
        <p style="text-align: center; letter-spacing: -0.02em; margin: 12px 0; font-weight: 400; font-size: 13px;">조회된 결과가 없습니다.</p>
    </div>
</script>
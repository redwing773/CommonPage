<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="voteListTmpl" type="text/x-jquery-tmpl">
<li data-no=\${pollNo}>
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
				<p class="voteContents">{{html contents}}</p>
			</div>
		</div>
	</div>
	{{if isAnswer == false}}
		{{if status == 2}}
			{{if joinTargetType == 2}}
				{{if mentorYn == "N"}}
					<button type="button" class="btn_result" data-status=\${isAnswer} data-no=\${status} onClick="moveVoteDetail(this, \${pollNo}, \${talkNo});">결과보기</button>
				{{else}}
					<button type="button" class="btn_vote" data-status=\${isAnswer} data-no=\${status} onClick="moveVoteDetail(this, \${pollNo}, \${talkNo});">투표하기</button>
				{{/if}}
			{{else (joinTargetType == 3)}}
				{{if mentorYn == "Y"}}
					<button type="button" class="btn_result" data-status=\${isAnswer} data-no=\${status} onClick="moveVoteDetail(this, \${pollNo}, \${talkNo});">결과보기</button>
				{{else}}
					<button type="button" class="btn_vote" data-status=\${isAnswer} data-no=\${status} onClick="moveVoteDetail(this, \${pollNo}, \${talkNo});">투표하기</button>
				{{/if}}
			{{else (joinTargetType == 1)}}
				<button type="button" class="btn_vote" data-status=\${isAnswer} data-no=\${status} onClick="moveVoteDetail(this, \${pollNo}, \${talkNo});">투표하기</button>
			{{/if}}
		{{else (status == 1)}}
			<button type="button" class="btn_vote" data-status=\${isAnswer} data-no=\${status} disabled="disabled" style="background:gray;">아직 투표 기간이 아닙니다</button>
		{{else (status == 3)}}
			<button type="button" class="btn_result" data-status=\${isAnswer} data-no=\${status} onClick="moveVoteDetail(this, \${pollNo}, \${talkNo});">결과보기</button>
		{{/if}}
	{{else (isAnswer == true)}}
		<button type="button" class="btn_result" data-status=\${isAnswer} data-no=\${status} onClick="moveVoteDetail(this, \${pollNo}, \${talkNo});">결과보기</button>
	{{/if}}
</li>
</script>

<script id="voteQuestionTmpl" type="text/x-jquery-tmpl">
<div class="vote_headerBox padding_16 mb10">
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
<div class="vote_contentBox padding_16">
	<div class="vote_header mb10">
		<h2 class="voteTit">\${title}</h2>
		<p class="voteCnt">투표자 수 <span>\${answerNumber}</span></p>
		<p class="votePeriod">투표기간 <span>\${startDate} ~ \${endDate}</span></p>
	</div>
	<div class="vote_content">
		<div class="vote_img mb10">
			<img src=\${imgUri}>
		</div>
		<div class="vote_txt">
			<p class="voteContents">{{html contents}}</p>
		</div>
	</div>
</div>
</script>

<script id="voteQuestionTmpl2" type="text/x-jquery-tmpl">
<div class="vote_headerBox mb10" style="display:grid; grid-template-columns:60px 1fr;">
	<div class="awl_voteHeaderBox">
		<div class="fl_l">
			<a href="javascript:void(0);" onclick="javascript:history.go(-1);" class="btn_prev"><span class="blind">이전</span></a>
		</div>
	</div>
	<div class="awl_voteStatusBox" style="display:flex; justify-content:flex-start; align-items:center;">
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
</div>
<div class="vote_contentBox padding_16">
	<div class="vote_header mb10">
		<h2 class="voteTit">\${title}</h2>
		<p class="voteCnt">투표자 수 <span>\${answerNumber}</span></p>
		<p class="votePeriod">투표기간 <span>\${startDate} ~ \${endDate}</span></p>
	</div>
	<div class="vote_content">
		<div class="vote_img mb10">
			<img src=\${imgUri} usemap="#test">
			<map id="imgmap2021218184141" name="test">
				<area shape="rect" alt="칼럼1" title="" coords="28,332,419,387" href="edulinker://inner_web?linkUrl=http://dev.ilinker.co.kr:10004/front/app/column/detail/730&title_bar_show=false" target="_blank" />
				<area shape="rect" alt="" title="" coords="32,699,472,754" href="edulinker://inner_web?linkUrl=http://dev.ilinker.co.kr:10004/front/app/column/detail/1354&title_bar_show=false" target="_blank" />
				<area shape="rect" alt="칼럼3" title="" coords="39,1031,635,1132" href="edulinker://inner_web?linkUrl=http://dev.ilinker.co.kr:10004/front/app/column/detail/1189&title_bar_show=false" target="_blank" />
			</map>
		</div>
		<div class="vote_txt">
			<p class="voteContents">{{html contents}}</p>
		</div>
	</div>
</div>
</script>

<script id="surveyListTmpl" type="text/x-jquery-tmpl">
<label class="radiobox style_02 pl10"><input type="radio" name="question" value="\${questionNo}"/><em></em><span>\${questionNo}번 {{html contents}}</span></label>
</script>

<script id="multipleSurveyListTmpl" type="text/x-jquery-tmpl">
{{if questionNo >= 90}}
	<p class="txt_15 mt10 mb10 pl5 pr5 pt5 pb5" style="border-top:solid 1px #cdcdcd; border-bottom:solid 1px #cdcdcd;">{{html contents}}</p>
{{else}}
	<label class="select_checkbox_01 style_03 mb10 pl10"><input type="checkbox" name="question" value="\${questionNo}"/><em></em><span>\${questionNo}번 {{html contents}}</span></label>
{{/if}}
</script>

<script id="resultListTmpl" type="text/x-jquery-tmpl">
{{if questionNo < 90}}
<li>
	<div class="graph_txt">
		<p class="que_txt txt_13">\${questionNo}번 {{html contents}}</p>
		<p class="answer_txt txt_13">\${answerPercent} (\${qaNumber}건)</p>
	</div>
	<div class="graph">
		<div style="width: \${answerPercent}; background: \${background};"></div>
	</div>
</li>
{{/if}}
</script>

<script id="voteReplyTmpl" type="text/x-jquery-tmpl">
  <div class="swl_comment_input padding_16">
    <textarea class="replyArea" name="replyArea" rows=2 name="reply_\${replyNo}" placeholder="댓글에 이모티콘 입력 불가" style="background:#ffffff;color:black;">\${replyContent}</textarea>
    <a href="javascript:void(0);">
        <img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="btn_updateReply" style="width:25px; height:25px; grid-area:b;">
    </a>
	<span class="countReply">\${len}/5000</span>
</div>
</script>

<script id="conditionTmpl" type="text/x-jquery-tmpl">
<label class="radiobox style_03 mb10"><input type="radio" name="categoryType" value="\${value}" id="categoryNo" data-type=\${type}><em></em><span>\${name}</span></label>
</script>

<script id="conditionUniversityTmpl" type="text/x-jquery-tmpl">
<label class="radiobox style_03 mb10"><input type="radio" name="categoryType" value="\${univNo}" id="categoryNo" data-type=\${type}><em></em><span>\${univNm}</span></label>
</script>

<script id="noDataTmpl" type="text/x-jquery-tmpl">
<div class="no_show2">
	<h2>\${msgData}</h2>
</div>
</script>

<script id="votePreviewTmpl" type="text/x-jquery-tmpl">
<li class="previewList mb15" style="display:none;" onclick="movePollList(\${pollNo}, \${talkNo}, \${status}, \${isAnswer}, \${joinTargetType});">
	<div class="previewList_header mb10">
		{{if status == 2}}
		<p class="red">진행중</p>
		{{else (status == 3)}}
		<p class="black">종료</p>
		{{else (status == 1)}}
		<p class="black">대기중</p>
		{{/if}}
		<p class="mint">\${joinReward}</p>
		{{if joinTargetType == 1}}
		<p class="purple">전체 참여 가능</p>
		{{else (joinTargetType == 2)}}
		<p class="purple">멘토 참여 가능</p>
		{{else (joinTargetType == 3)}}
		<p class="purple">멘티 참여 가능</p>
		{{/if}}
		<p class="blue_r">\${subject}</p>
	</div>
	<div class="vote_contentBox">
		<div class="vote_header">
			<h2 class="voteTit">{{html title}}</h2>
			<p class="voteCnt">
			{{if joinTargetType == 1}}전체
			{{else (joinTargetType == 2)}}멘토
			{{else (joinTargetType == 3)}}멘티
			{{/if}}
			 투표자 수 <span>\${answerNumber}</span>
			</p>
			<p class="votePeriod">투표기간 <span>\${startDate} ~ \${endDate}</span></p>
		</div>
	</div>
</li>
</script>
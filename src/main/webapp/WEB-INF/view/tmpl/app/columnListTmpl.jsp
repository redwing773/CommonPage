<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="mentalkCategoryListTmpl" type="text/x-jquery-tmpl">
    <label class="select_checkbox style_03 mb10"><input type="checkbox" name="mentalkCategoryNo" value="\${mentalkCategoryNo}" /><em></em><span>\${mentalkCategoryNm}</span></label>
</script>

<script id="replyInputTmpl" type="text/x-jquery-tmpl">
  <div class="swl_comment_input">
    <textarea class="replyArea" rows=2 name="reply_\${replyNo}" placeholder="댓글에 이모티콘 입력 불가" onkeyup="uptFn(this);" style="background:#ffffff;color:black;">\${replyContent}</textarea>
    <a href="#">
        <img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyModifyFn(this,\${replyNo},\${talkNo});">
    </a>
	<span class="countReply" style="opacity:1;">\${len}/5000</span>
</div>
</script>

<script id="mainListTmpl" type="text/x-jquery-tmpl">
    <li class="awl_content_reply_list" data-no=\${talkNo} onClick="moveColumnDetail(this);">
        <div class="awl_user">
            {{if resourceUri == ''}}
                <span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png" alt="" /></span>
            {{else}}
                <span class="awl_img"><img src="\${resourceUri}" style="width:30px;height:30px;border-radius:50%;"/></span>
            {{/if}}
               <span class="awl_name">
                   <strong>\${nickname}</strong>
                   <span>\${regDt}</span>
               </span>
        </div>
		<p class="title">\${talkTitle}</p>
        <p class="con">\${talkContent}</p>
        <div class="awl_box_state">
            <span class="awl_dat" onClick="openReplyListFn(this)">\${replyCnt}</span>
            <div class="awl_abs_right">

            </div>
        </div>
        <!-- 댓글 영역 -->
        <div class="awl_comment_box" id="awl_comment_box">
            <div class="awl_comment_tit">
                <strong>댓글 \${replyCnt}</strong>
                <a href="javascript:void(0);" onClick="moreContentFn(\${talkNo});">더보기</a>
            </div>
            <ul class="swl_comment_list"></ul><!-- 댓글 삽입 부분 -->
            <div class="swl_comment_input">
                <textarea rows=1 placeholder="댓글에 이모티콘 입력 불가" id="replyInput" onClick="replyInputFn(this);"></textarea>
                <a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(\${talkNo});"/></a>
            </div>
        </div>
    </li>
</script>

<script id="voiceColumnEventTmpl" type="text/x-jquery-tmpl">
	<div class="awl_column_event">
		<div></div> 
		<div></div> 
		<div></div> 
		<div></div> 
		<div></div> 
		<div></div> 
		<div></div> 
		<div></div> 
		<div></div> 
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
	</div>
</script>

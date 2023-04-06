<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/pc" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<t:noLayout>
    <jsp:attribute name="script_file">
		<%@ include file="/WEB-INF/view/tmpl/pc/portalTalkTmpl.jsp" %>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/inventory_api.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/consult_api.js?ver=20201211"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/shop_api.js?ver=20210128"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/linker_api.js?ver=2020122301"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/mojiboard_api.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/portaltalk_api.js"></script>
		<script type="text/javascript">
		<%--top.window.$('head').append('<link rel="shortcut icon" href="${pageContext.request.contextPath}/pc/images/favicon/72x72.png">');--%>

		<%-- 사용자 정보 --%>
		var userHipId = tms.getCookie("hipid");
 		var talkNo = "${opentalk.talkNo}";
		var systemMode = properties.getSystemMode();
		var userMentorYn = "N";
		var adoptYn = false;

		var compareMentorYn = "${opentalk.mentorYn}";

		<%-- 전문가 멘토 계정 처리  --%>
		var expertMentor = "";
		if(systemMode == "live") {
			expertMentor= properties.expertMentorLiveHipId;
		} else {
			expertMentor= properties.expertMentorDevHipId;
		}

		var userAgent = window.navigator.userAgent.toLowerCase();

		var inApp = new Array('iphone','android');

		var inappCheck = false;
		for(var appWord in inApp){
			if(userAgent.match(inApp[appWord]) != null){
				appcss();
				inappCheck = true;
			}
		}
		if(!inappCheck) {
			pccss();
		}

     	function pccss(){
           	$('.moji_detail').css({'width': '400px', 'margin': '0 auto'});
     	}
 		
     	function appcss() {
     		top.window.$('head').append('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">');
           	$('.moji_detail').css({'width': '100%', 'margin': ''});
     	}

		<%-- 매니저 계정 처리 --%>
		var managerHipId = "";
		var managerSupportHipId = "";
		if(systemMode == "live" || systemMode == "stage") {
			managerHipId = properties.managerLiveHipId;
			managerSupportHipId = properties.managerSupportLiveHipId;
		} else {
			managerHipId = properties.managerDevHipId;
			managerSupportHipId = properties.managerSupportDevHipId;
		}
		
		$(function(){
			<%-- 회원정보 조회 --%>
			inventoryApi.retrieveUserInformationInTheInventory(function (code, data) {
				if (code === 0) {
					common.userInfo.isLogin = true;
					userMentorYn = data.mentorYn;
				}
				reloadDetail($(".awl_commentBox"), talkNo);
			});


			
 			<%-- 글자수 카운팅 --%>
 			$("textarea[name=replyInput]").on("input click keyup", function(){
 				if (isLoginCheck() ==  0) {
	 				$(this).css({'background':'#ffffff','color':'#000000'});
	 				var $this = $(this);
	 				var opentalkNo = $(this).parent().data("no");
	 				checkTextCount($this, opentalkNo);
 				}
 			});
		});

		<%-- 댓글 다시 그려주기  --%>
		var reloadDetail = function (contentObj, talkNo){
			tms.ajaxGetHelper(contextPath + '/app/opentalk/redetail/' + talkNo, { 'talkNo' : talkNo }, null, function(data){
				var hipid = data.hipid;
				var replyList = data.replyList;
				var reloadTalk = data.reloadTalk;

				var replyTitle = '';
				var replyCnt = reloadTalk.replyCnt;
				if(reloadTalk){
					if(replyCnt > 0){
						$(contentObj).find('.awl_tit2').html("");
						replyTitle += '<h1>댓글 '+replyCnt+'개</h1>';
					}
				}
				$(contentObj).find('.awl_tit2').html(replyTitle);

				var rList = '';

				if(replyList != ""){
					$(contentObj).find('.swl_comment_list').html("");
					$(replyList).each(function(){
						rList += '<li><div class="height49" data-no=\''+this.hipId+'\'>';
						if(this.statusCd == 1 || this.statusCd == 2){
							rList += '<span class="awl_img" onclick="invokeReProfileFn(this,'+this.statusCd+',\''+this.mentorYn+'\');"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png" alt=""/></span>';
							rList += '<span class="awl_name"><strong>anon</strong>';
							rList += '<span class="blockContentsSpan"><div class="blockContents"></div></span>'
							rList += '<span>'+this.regDt+'</span></span>';

							if(this.mentorYn == 'Y'){
								rList += '<span class="swl_badge">멘토</span>';
							}else if(this.mentorYn == 'N'){
								rList += '<span class="swl_badge">멘티</span>';
							}
						}else if(this.statusCd == 0){
							if(this.resourceUri == ''){
								rList += '<span class="awl_img" onclick="invokeReProfileFn(this,'+this.statusCd+',\''+this.mentorYn+'\');"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png" alt=""/></span>';
							}else{
								if (this.hipId == expertMentor ){
									rList += '<span class="awl_img" style="border: solid 1.5px #fd7601 !important;"><img src="'+this.resourceUri+'"></span>';
									rList += '<img class="expertMentor_medal" src="${pageContext.request.contextPath}/apps/images/expertMentor_medal.png">';
								} else if (this.mojiEmail == null) {
									if(this.hipId == managerHipId){
										rList += '<span class="awl_img" onclick="invokeReProfileFn(this,'+this.statusCd+',\''+this.mentorYn+'\');"><img src="'+this.resourceUri+'"></span>';
									}else if(this.mentorYn == 'Y'){
										rList += '<span class="awl_img" onclick="invokeReProfileFn(this,'+this.statusCd+',\''+this.mentorYn+'\');"><img src="${pageContext.request.contextPath}/pc/images/portal_mentor_profile_img.png"></span>';
									}else if(this.mentorYn == 'N'){
										rList += '<span class="awl_img" onclick="invokeReProfileFn(this,'+this.statusCd+',\''+this.mentorYn+'\');"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"></span>';
									}
								} else{
									rList += '<span class="awl_img" onclick="invokeReProfileMojiFn(this,'+this.statusCd+',\''+this.mentorYn+'\');"><img src="'+this.resourceUri+'"></span>';
								}
							}

							rList += '<span class="awl_name"><strong>'+this.nickname+'</strong>';
							rList += '<span class="blockContentsSpan"><div class="blockContents"></div></span>'
							rList += '<span>'+this.regDt+'</span></span>';

							if(this.mentorYn == 'Y'){
								rList += '<span class="swl_badge">멘토</span>';
							}else if(this.mentorYn == 'N'){
								if (this.hipId == expertMentor ){
									rList += '<span class="expertMentor_bedge">파워멘토</span>';
								}else if (this.mojiEmail == null) {
									rList += '<span class="swl_badge">멘티</span>';
								}else{
									rList += '<img class="ic_moji_badge" src="${pageContext.request.contextPath}/apps/images/ic_moji_badge.png" alt=""/>';
								}
							}
								if(userMentorYn == 'Y'){
									if(this.mentorYn == 'N' && this.hipId != managerHipId && this.hipId != managerSupportHipId && this.hipId != expertMentor){
										if (this.mojiEmail == null) {
											if(tms.isNotEmpty(this.feature)){
												rList += '<span class="txt_11 swl_mentorMenteeInfo">'+ this.feature+ ', ' + this.schoolLevel +'</span>';
											}else {
												rList += '<span class="txt_11 swl_mentorMenteeInfo">'+ this.schoolLevel +'</span>';
											}
										} else {
											if(tms.isNotEmpty(this.feature)){
												rList += '<span class="txt_11 swl_mentorMenteeInfo_moji">'+ this.feature+ ', ' + this.schoolLevel +'</span>';
											}else {
												rList += '<span class="txt_11 swl_mentorMenteeInfo_moji">'+ this.schoolLevel +'</span>';
											}
										}
									}
								}else if(userMentorYn == 'N'){
									if(this.mentorYn == 'Y' && this.hipId != managerHipId && this.hipId != managerSupportHipId && this.hipId != expertMentor){
										var partyNm = this.partyNm.substring(0,5);
										var acceptanceLine = this.acceptanceLine.substring(0,2);
										rList += '<span class="txt_11 swl_mentorMenteeInfo">'+ partyNm + ', ' + this.departmentLine + ', ' + this.studentId + '학번, ' + acceptanceLine +'</span>';
									}else if(this.mentorYn == 'N' && this.hipId != managerHipId && this.hipId != managerSupportHipId && this.hipId != expertMentor){
										if (this.mojiEmail == null) {
											if(tms.isNotEmpty(this.feature)){
												rList += '<span class="txt_11 swl_mentorMenteeInfo">'+ this.feature+ ', ' + this.schoolLevel +'</span>';
											}else {
												rList += '<span class="txt_11 swl_mentorMenteeInfo">'+ this.schoolLevel +'</span>';
											}
										}else{
											if(tms.isNotEmpty(this.feature)){
												rList += '<span class="txt_11 swl_mentorMenteeInfo_moji">'+ this.feature+ ', ' + this.schoolLevel +'</span>';
											}else {
												rList += '<span class="txt_11 swl_mentorMenteeInfo_moji">'+ this.schoolLevel +'</span>';
											}
										}
									}
								}
						}
						rList += '</div>';
						if(this.closeDate == null){
							if(this.writerHipId == userHipId){
								if(this.writerHipId == managerHipId || this.writerHipId == managerSupportHipId || this.writerHipId == expertMentor){
									rList += '';
								}else if(this.writerHipId != managerHipId && this.writerHipId != managerSupportHipId && this.writerHipId != expertMentor){
									if(userMentorYn == 'N'){
										if((this.isAdopt == 0 || this.isAdopt == null) && this.mentorYn == "Y"){
											if(this.opentalkNo == 1){
												rList += '<button type="button" class="btn_selectReply txt_13" onclick="adoptReply(this,'+this.replyNo+','+this.talkNo+')";>채택하기</button>';
											}else if(this.opentalkNo == 6){
												rList += '<button type="button" class="btn_selectReply txt_13" onclick="adoptAnswerWithPay(this,'+this.replyNo+','+this.talkNo+')";>채택하기</button>';
											}
										}
									}
								}
							}
						}else if(this.closeDate != null){
							if(this.isAdopt == 1){
								if(this.adoptType == 'questioner'){
									rList += '<button type="button" class="btn_resultReply">채택<br>완료</button>';
								}else if(this.adoptType == 'system'){
									rList += '<button type="button" class="btn_resultReply">지급<br>완료</button>';
								}
							}
						}
						rList += '<p class="awl_comment_content blockReply'+this.hipId+'">'+this.replyContent+'</p>';
						rList += '<p class="blockReplyImg'+this.hipId+'" style="display: none;"><img class="blockListReplyImg" src="${pageContext.request.contextPath}/apps/images/im_block_talk_list.png"></p>';
						if(this.ogUrl != null){
							rList += '<div class="awl_ogTag" onClick="moveUrl(\'' + this.ogUrl + '\');">';
							rList += '<img src="' + this.ogImg + '" class="awl_ogImg" />';
							rList += '<p class="awl_ogTitle" >' + this.ogTitle + '</p>';
							rList += '<p class="awl_ogDescription">'+ this.ogDescription + '</p>';
							rList += '<p class="awl_ogUrl">' + this.ogUrl + '</p></div>';
						}
						rList += '<div class="awl_reply_box_state">';
						if(this.isAdopt == 1){
							adoptYn = true;
						}
						if(this.hipId == userHipId){
							rList += '<div class="awl_abs_right">';
							if(this.isAdopt == 1){
								rList += '';
							}else {
								console.log("adoptYn: "+adoptYn);
								if(this.opentalkNo == 1){
									if(!adoptYn){
										rList += '<a href="javascript:void(0);" onClick="replyModifyForm(this,'+this.replyNo+','+this.talkNo+','+this.opentalkNo+');">수정</a>';
									}
								}else if(this.opentalkNo == 6){
									if(!adoptYn){
										rList += '<a href="javascript:void(0);" onClick="replyDeleteFn(this,'+this.replyNo+','+this.talkNo+');">삭제</a>&nbsp;&nbsp;';
										rList += '<a href="javascript:void(0);" onClick="replyModifyForm(this,'+this.replyNo+','+this.talkNo+','+this.opentalkNo+');">수정</a>';
									}
								}
							}
							rList += '</div>';
						}
						rList += '</div></li>';
					});
					$(contentObj).find('.swl_comment_list').html(rList);
				}else{
					rList = '<li style="padding:20px;margin-left:0px;"><p style="text-align:left;">작성된 댓글이 없어요.</p></li>';
					$(contentObj).find('.swl_comment_list').html(rList);
				}
			});
		};

		<%-- 댓글 글자수 카운팅 --%>
		var reContext = "";
		var reContextLen = 0;
		var subReContextLen = 0;
		var checkTextCount = function (obj, opentalkNo){
			$(obj).val(tms.removeEmoji($(obj).val()));
			$(obj).css({'background':'#ffffff','color':'#000000'});
			if( $(obj).length > 0){
				reContext = $(obj).val();
				reContextLen = reContext.length;

				<%-- 이중스페이스, 엔터 금지 --%>
				if (reContext != null) {
					reContext = reContext.replace(/\r+/g, "\r");
	 				reContext = reContext.replace(/\n+/g, "\n");
	 				reContext = reContext.replace(/\r +/g, "\r");
	 				reContext = reContext.replace(/\n +/g, "\n");
	 				reContext = reContext.replace(/ +/g, " ");
	 				$(obj).val(reContext);
	 				reContextLen = reContext.length;
				}
				
				$(obj).parents().find('.countReply').text(reContextLen + "/500");
				if(reContextLen > 500){
					openAlertPopupMoji("댓글 내용은 500자를 초과할 수 없어요.", function(){
						reContext = reContext.substring(0,500);
						subReContextLen = reContext.length;
						$(obj).val(reContext);
						$(obj).parents().find('.countReply').text(subReContextLen + "/500");
					});
				}
			}
		};
			
		<%-- 댓글 작성 로직 분리 : 질문톡의 경우 삭제 불가 처리 --%>
		var replyInsertFn = function (obj, opentalkNo, isCloseDate){
			$(obj).attr('onClick', 'return false'); // 중복 입력 방지
			$(obj).parent().attr('onclick', 'return false');
			
			var contentObj = $(".awl_comment"); // 댓글 작성 처리 변수
			var replyInput = reContext;
			var talkNo = $('.awl_user #talkNo').val();
			var writerHipId = $(".awl_nickname").data("no");

			if(tms.isEmoji(replyInput)){
				openAlertPopupMoji("댓글 작성에 실패했어요.<br>이모티콘은 지원하지 않아요.<br><br>다시 시도해 주세요.", function(){
					$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 취소 시 중복 클릭 방지 해제
					$(obj).parent().removeAttr('onclick');
				});
				return false;
			}

			if(isLoginCheck() ==  0 && validContentMoji(replyInput) == 0){
				var param = { 
					'hipId':tms.getCookie("hipid"),
					'talkNo':talkNo,
					'replyContent':replyInput,
					'writerHipId':writerHipId,
					'mentorYn':userMentorYn
				};

				if(compareMentorYn == "N" && userMentorYn == "Y" && replyInput.length < 50){
					if(isCloseDate == false){
						var msgObj = {
							title: "50자 미만은 포인트가<br>지급되지 않으며,<br>작성된 댓글은 삭제되지 않습니다.<br>채택 후 모든 댓글은 수정이 불가합니다.<br><br>작성하시겠습니까?"
							,checkWord: "확인"
							,cancelWord: "취소"
						};

						$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 취소 시 중복 클릭 방지 해제
						$(obj).parent().removeAttr('onclick');

						openConfirmPopupMoji(msgObj, function(){
							saveReply(obj, contentObj, param, compareMentorYn, opentalkNo, isCloseDate);
						});
					}else{
						var msgObj = {
							title: "작성된 댓글은 삭제되지 않습니다.<br>채택 후 모든 댓글은 수정이 불가합니다.<br>작성하시겠습니까?"
							,checkWord: "확인"
							,cancelWord: "취소"
						};

						$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 취소 시 중복 클릭 방지 해제
						$(obj).parent().removeAttr('onclick');

						openConfirmPopupMoji(msgObj, function(){
							saveReply(obj, contentObj, param, compareMentorYn, opentalkNo, isCloseDate);
						});
					}
				} else if(compareMentorYn == "N" && userMentorYn == "Y" && replyInput.length >= 50) {
					var msgObj = {
						title: "작성된 댓글은 삭제되지 않습니다.<br>채택 후 모든 댓글은 수정이 불가합니다.<br>작성하시겠습니까?"
						,checkWord: "확인"
						,cancelWord: "취소"
					};

					$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 취소 시 중복 클릭 방지 해제
					$(obj).parent().removeAttr('onclick');

					openConfirmPopupMoji(msgObj, function(){
						saveReply(obj, contentObj, param, compareMentorYn, opentalkNo, isCloseDate);
					});
				} else {
					saveReply(obj, contentObj, param, compareMentorYn, opentalkNo, isCloseDate);
				}

				// $(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 취소 시 중복 클릭 방지 해제
				// $(obj).parent().removeAttr('onclick');
				//
				// openConfirmPopupMoji({title: "작성된 댓글은 삭제할 수 없어요.<br>댓글을 작성할까요?", checkWord: "확인", cancelWord: "취소"}, function(){
				// 	saveReply(obj, contentObj, param, opentalkNo, isCloseDate);
				// });
			}
		};
			
		<%-- 댓글 작성 로직 분리 --%>
		var saveReply = function(obj, contentObj, param, compareMentorYn, opentalkNo, isCloseDate) {
			param.registerKakaoAlarm = "Y";
			$.ajax({
				type : 'GET',
				url : tms.portalProxyUrl(contextPath + '/app/reply/write?' + $.param(param)),
				// data : $.param(param),
				// contentType: 'application/json',
				// contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(result){
					if(result == 1){
						$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 중복 클릭 방지 해제
						$(obj).parent().removeAttr('onclick');
						
						$(contentObj).find('#replyInput').val("");
						$(contentObj).find('.countReply').text("0/500");
						reContext = ""; // 변수 초기화

						if(!isCloseDate){
							if (userHipId == managerHipId || userHipId == managerSupportHipId) {

							}else{
								opentalkReplyEvent(compareMentorYn, param.replyContent, param.talkNo, opentalkNo); // 이벤트 처리
							}
						}
						
						reloadDetail(contentObj, param.talkNo); // DOM 다시 그리기
					}
				},error: function(){
					openAlertPopupMoji('댓글 작성에 실패했어요.<br>이모티콘은 지원하지 않아요.<br><br>다시 시도해 주세요.', function() {
						reloadDetail(contentObj, param.talkNo);
						
						$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 중복 클릭 방지 해제
						$(obj).parent().removeAttr('onclick');
					});
				}
			});
		};

		<%-- 이벤트 포인트 지급 --%>
		var opentalkReplyEvent = function(compareMentorYn, replyContent, talkNo, opentalkNo) {
			var param = { talkNo : talkNo };
			if(opentalkNo == 1){
				if(userMentorYn == "Y" && compareMentorYn == "N" && replyContent.length >= 50){
					shopApi.opentalkReplyEvent(param, function(res){
						console.log(res.resultText);
					});
				}
			}else if(opentalkNo == 6){
				shopApi.opentalkReplyEvent(param, function(res){
					console.log(res.resultText);
				});
			}
		};

		<%-- 댓글 수정폼 --%>
		var replyModifyForm = function(obj, replyNo, talkNo, opentalkNo){
			var replyContent = $(obj).parent().parent().parent().find('p.awl_comment_content').text();
			var str = new String(replyContent);
			var len = str.length;
			var data = [{
				"talkNo" : talkNo
				,"replyNo" : replyNo
			    ,"replyContent" : replyContent
			    ,"len" : len
			    ,"opentalkNo" : opentalkNo
			}];
			
			$('.awl_fixer_comment').empty();
			$('#basicReplyInputTmpl').tmpl(data).appendTo('.awl_fixer_comment');
			$('.replyArea').focus();
		};

		<%-- 댓글 수정 글자수 카운팅 --%>
		var uptFn = function (obj, opentalkNo){
			var uptContent = $(obj).val();
			var uptContentLen = uptContent.length;
			
			<%-- 이중스페이스, 엔터 금지 --%>
			if (uptContent != null) {
				uptContent = uptContent.replace(/\r+/g, "\r");
				uptContent = uptContent.replace(/\n+/g, "\n");
				uptContent = uptContent.replace(/\r +/g, "\r");
				uptContent = uptContent.replace(/\n +/g, "\n");
				uptContent = uptContent.replace(/ +/g, " ");
 				$(obj).val(uptContent);
 				uptContentLen = uptContent.length;
			}
			
			$(".countReply").text(uptContentLen + "/500");
			if(uptContentLen > 500){
				openAlertPopupMoji("댓글은 500자를<br>초과할 수 없어요.", function(){
					uptContent = uptContent.substring(0,500);
					var subUptLen = uptContent.length;
					$(obj).val(uptContent);
					$('.countReply').text(subUptLen + "/500");
				});
			}
		};
		
		<%-- 질문톡 채택--%>
		var adoptReply = function(obj, replyNo, talkNo) {
			var listObj = $(obj).parents(".awl_comment");

			if(isLoginCheck() ==  0) {
				openConfirmPopupMoji({title: "해당 댓글을 채택하시겠습니까?", checkWord: "채택하기", cancelWord: "취소"}, function () {
					var param = {talkNo: talkNo, replyNo: replyNo};
					consultApi.adoptAnswer(param, function (code, res) {
						if (code === 0) {
							// openAlertPopupMoji("채택이 완료되었습니다.", function () {
							// 	console.log(res.resultText);
							// 	reloadDetail(listObj, talkNo);
							// });
							adoptCompleteEventPopup(talkNo, function(){
								reloadDetail(listObj, talkNo);
							});
						} else {
							var msg = res.resultText;
							openAlertPopupMoji(msg, function () {
							});
						}
					});
				});
			}
		};
		
		<%-- 댓글 수정 --%>
		var replyModifyFn = function (obj, replyNo, talkNo, opentalkNo){
			var contentObj = $(".awl_comment");
			var updateContent = $(contentObj).find('.replyArea').val();

			if(validContentMoji(updateContent) == 0 && isLoginCheck() ==  0){
				var paramData = {
					replyNo : replyNo
				   ,replyContent : updateContent
				};
				
				$.ajax({
					type : 'GET',
					url : tms.portalProxyUrl(contextPath + '/app/reply/modifyAction?') + $.param(paramData),
					success : function(result){
						if(result){
							$(contentObj).find('.swl_comment_input').empty();
							
							var reload = '';
							reload += '<textarea rows=2 placeholder="댓글에 이모티콘 입력 불가" maxlength="500" id="replyInput" name="replyInput" oncopy="return false;" onpaste="openAlertPopupMoji(\'댓글 복사,붙여넣기 금지\'); return false;" oninput="checkTextCount(this, '+opentalkNo+');" onclick="checkTextCount(this, '+opentalkNo+');" onkeyup="checkTextCount(this, '+opentalkNo+');"></textarea>';
							reload += '<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, '+opentalkNo+');"/></a>';
							reload += '<span class="countReply">0/500</span>';
							
							$(contentObj).find('.swl_comment_input').html(reload);
							reloadDetail(contentObj,talkNo);
						}
					},error: function(){
						openAlertPopupMoji("댓글 수정에 실패했어요.<br>다시 시도해 주세요.", function(){
							reloadDetail(contentObj,talkNo);
						});
					}
				});
			}	
		};

		var isLoginCheck = function(){
			if(tms.isNotEmpty(tms.getCookie("linker_token")) && common.ssoLoginCode == -1) {
				if(tms.isEmpty(tms.getCookie("integratedMemberYn")) || tms.getCookie("integratedMemberYn") == "N"){
					var params = {
						client_id: properties.membershipClientId(),
						client_secret: properties.membershipSecretKey(),
						hip_id: tms.getCookie("hipid")
					}

					tms.ajaxPostHelper(properties.membershipAuthApiDomain() + "	/ext/auth/external/v1/linker/hipid/transfer/check", JSON.stringify(params), {headers:{'X-Os-Code': 'OSC001'}, showLoding: true}, function(res){
						if(res.code == 10008){
							//var membershipUrl = properties.getSystemMode() == "dev" ? "https://dev-my.linker.ac" : properties.getSystemMode() == "stage" ? "https://stage-my.linker.ac" : "https://my.linker.ac";
							openAlertPopupMoji("질문톡은 통합회원에 한해서 제공됩니다.<br>통합회원으로 전환하시겠어요?", function(){
								location.href = properties.membershipAuthDomain()+"/transfer/gate?forceTransfer=Y&clientId="+properties.membershipClientId()+"&sessionToken="+res.value.session_token+"&callbackUrl="+properties.membershipCallbackUrlPortal();
							});
							return -1;
						}else if(res.code == 10027) {
							openAlertPopupMoji("재로그인 후 이용해 주시길 바랍니다.", function(){
								tms.setCookie("hipid", "", -1);
								tms.setCookie("linker_token", "", -1);
								tms.setCookie("accessTokenInter", "", -1);
								tms.setCookie("integratedMemberYn", "", -1);

								common.loginMembershipPortal();
							});
							return -1;
						}else {
							location.href = contextPath + "/page/portal/talk/movePage" + location.search;
						}
					});
				}
			}else if(common.ssoLoginCode === 10009 || common.ssoLoginCode === 10046 || common.ssoLoginCode === 10047) {
				//openConfirmPopupMoji({title: "질문톡 서비스 이용 동의 후 사용할 수 있습니다.", checkWord: "확인", cancelWord: "취소"}, function(){
					common.loginMembershipPortal();
				//});
				return -1;
			}else if(!common.userInfo.isLogin && common.ssoLoginCode !== 0){
				//openConfirmPopupMoji({title: "로그인 후 서비스를 이용할 수 있습니다.", checkWord: "로그인", cancelWord: "취소"}, function(){
					//window.opener.postMessage("parentWindowLogin", "*");
					common.loginMembershipPortal();
				//});
				return -1;
			}else {
				return 0;
			}
		};
		
		var validContentMoji = function(value){
			if(value == ""){
				openAlertPopupMoji("내용을 입력해 주세요.");
				return -1;
			}else{
				return 0;
			}
		};
		
		var openAlertPopupMoji = function(title, fnAction){
			$(".popup_alert_moji").html("");
	        $("#alert_moji").tmpl({title:title}).appendTo(".popup_alert_moji");
			Layer_OPEN(".popup_alert_moji");

	        if(typeof fnAction == "function"){
	            $(".popup_alert_moji .btn_box a").bind("click", function(){
	                fnAction();
	                $(this).unbind();
	            });
	        }
	        
		};
		
		var openConfirmPopupMoji = function(msgObj, fnAction){
			$(".popup_confirm_moji").html("");
			$("#confirm_moji").tmpl(msgObj).appendTo(".popup_confirm_moji");
			Layer_OPEN(".popup_confirm_moji");

	        if(typeof fnAction == "function"){
	            $(".popup_confirm_moji .btn_box #checkWord").bind("click", function(){
	                fnAction();
	                Layer_CLOSE('.popup_confirm_moji')
	                $(this).unbind();
	            });
	        }
		}; 
		
		function movePrev(){
			var prev = tms.getParameterByName("prev");
			var gnbParams = location.search;
			if(gnbParams.indexOf("prev") != -1) {
				gnbParams = "?" + gnbParams.substr(gnbParams.indexOf("gnbService"));
			}

			if(prev == "question") {
				var keyword = tms.getParameterByName("keyword");
				if(gnbParams.indexOf("?") == 0) {
					location.href= contextPath + "/page/portal/search/question?keyword="+keyword + "&" +gnbParams.substr(1);
				}else {
					location.href= contextPath + "/page/portal/search/question?keyword="+keyword;
				}
			}else if(prev == "myTalk") {
				location.href= contextPath + "/page/portal/talk/myTalk"+ gnbParams;
			} else {
				location.href= contextPath + "/page/portal/talk/list"+ gnbParams;
			}
		};

		var openAlertPopupMojiQr = function(){
			Layer_OPEN(".popup_alert_moji_qr");
		};
		</script>
	</jsp:attribute>
	<jsp:body>
	<div class="moji_detail">
	<div class="awl_opentalk_header">
		<div class="both_area">
			<div class="fl_l">
				<a onclick="movePrev();" class="btn_prev" style="width: 50px; height: 50px;"><span class="blind">뒤로가기</span></a>
			</div>
			<h2 class="awl_talkTit" style="color: #222222; font-weight: bold; line-height: 50px; font-size: 20px; transform: translateY(2px);">모두보기</h2>
		</div>
	</div>
	<div class="awl_comment moji_board_reply" style="background:#fff !important;">	
		<div class="awl_main_reply">
			<ul class="moji_detail_main awl_main_list">
				<li>
					<p class="adoptPercent">질문수 <span style="color: #302cc8;font-weight: 600;">${opentalk.questionSum}</span></p>
					<c:if test="${opentalk.categoryNm != null}">
						<c:if test="${opentalk.opentalkNo == 1}"><p class="awl_categoryNm" style="display: inline-block;float: right;transform: translateY(10px);">${opentalk.categoryNm}</p></c:if>
					</c:if>
					<div class="awl_user">
						<input type="hidden" id="talkNo" value="${opentalk.talkNo}" />
						<span class="awl_img" data-no="${opentalk.mentorYn}"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png" alt=""/></span>
						<span class="awl_name">
							<c:if test="${opentalk.mojiEmail == null}">
								<strong class="awl_nickname" data-no="${opentalk.hipId}">${opentalk.nickname}</strong>
							</c:if>
							<c:if test="${opentalk.mojiEmail != null}">
								<strong class="awl_nickname mojiProfile" data-no="${opentalk.hipId}">${opentalk.nickname}</strong>
							</c:if>
							<span  class="awl_date">${opentalk.regDt}</span>
						</span>
						<c:if test="${opentalk.mentorYn == 'Y'}">
							<span class="awl_badge">멘토</span>
						</c:if>
						<c:if test="${opentalk.mentorYn == 'N' }">
							<c:if test="${opentalk.mojiEmail == null}">
								<span class="awl_badge">멘티</span>
							</c:if>
							<c:if test="${opentalk.mojiEmail != null}">
								<img class="ic_moji_badge2 mojiProfile" src="${pageContext.request.contextPath}/apps/images/ic_moji_badge.png" alt="" />
							</c:if>
						</c:if>
						<c:set var = "partyNm" value = "${opentalk.partyNm}"/>
						<c:set var = "acceptanceLine" value = "${opentalk.acceptanceLine}" />
						<c:if test="${hipid != '' || hipid != null}">
									<c:if test="${opentalk.mentorYn == 'N' && opentalk.hipId != managerHipId && opentalk.hipId != managerSupportHipId}">
										<c:if test="${opentalk.mojiEmail eq null}">
											<c:if test="${opentalk.feature != null}"><span class="txt_11 awl_mentorMenteeInfo">${opentalk.feature}, ${opentalk.schoolLevel}</span></c:if>
											<c:if test="${opentalk.feature == null}"><span class="txt_11 awl_mentorMenteeInfo">${opentalk.schoolLevel}</span></c:if>
										</c:if>
										<c:if test="${opentalk.mojiEmail ne null}">
											<c:if test="${opentalk.feature != null}"><span class="txt_11 awl_mentorMenteeInfo_moji">${opentalk.feature}, ${opentalk.schoolLevel}</span></c:if>
											<c:if test="${opentalk.feature == null}"><span class="txt_11 awl_mentorMenteeInfo_moji">${opentalk.schoolLevel}</span></c:if>
										</c:if>
									</c:if>
						</c:if>
					</div>
					<p class="awl_content">${opentalk.talkContent}</p>
					<div class="awl_box_state">
						<div class="awl_abs_right">
								<c:if test="${opentalk.opentalkNo == 1}">
										<c:if test="${hipid ne managerHipId && hipid ne managerSupportHipId}">
											<c:if test="${opentalk.adoptPoint != 0 && opentalk.closeDate == null}">
												<a href="javascript:void(0);" class="btn_select txt_13">채택 포인트 : ${opentalk.adoptPoint}P</a>
											</c:if>
											<c:if test="${opentalk.closeDate != null}">
												<c:if test="${opentalk.adoptType eq 'questioner' || opentalk.adoptType eq 'questioner_req'}">
													<c:if test="${opentalk.talkNo <= 913}">
														<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(5,000P)</a>
													</c:if>
													<c:if test="${opentalk.talkNo > 913}">
														<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(${opentalk.adoptPoint}P)</a>
													</c:if>
												</c:if>
												<c:if test="${opentalk.adoptType eq 'system' || opentalk.adoptType eq 'system_req'}">
													<c:if test="${opentalk.talkNo <= 913}">
														<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(5,000P)</a>
													</c:if>
													<c:if test="${opentalk.talkNo > 913}">
														<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(${opentalk.adoptPoint}P)</a>
													</c:if>
												</c:if>
											</c:if>
										</c:if>
								</c:if>
						</div>
					</div>
				</li>
			</ul><!-- 내용 -->
			<div class="line_04 mt10"></div>
			<div class="awl_commentBox pt10">
				<%-- 댓글 갯수 --%>
				<div class="awl_tit2">
					<c:if test="${opentalk.replyCnt > 0}">
						<h1>댓글 ${opentalk.replyCnt}개</h1>
					</c:if>
				</div>
				<%-- 댓글 입력 폼 --%>
				<div class="awl_fixer_comment mt10 mb15">
			    	<div class="swl_comment_input" data-no="${opentalk.opentalkNo}">
						<textarea rows=2 placeholder="댓글에 이모티콘 입력 불가" id="replyInput" maxlength="500" name="replyInput" oncopy="return false;" onpaste="openAlertPopupMoji('댓글 복사,붙여넣기 금지'); return false;"></textarea>
						<c:if test="${opentalk.closeDate == null}">
							<a href="javascript:void(0);"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this,${opentalk.opentalkNo}, false);"/></a>
						</c:if>
						<c:if test="${opentalk.closeDate != null}">
							<a href="javascript:void(0);"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this,${opentalk.opentalkNo}, true);"/></a>
						</c:if>
						<span class="countReply">0/500</span>
					</div>
				</div>
				<%-- 댓글 영역 --%>
	 			<ul class="swl_comment_list">
				</ul> 
			</div><!-- awl_commentBox -->
		</div><!-- awl_main_reply -->
	</div><!-- awl_comment -->
	</div>
	<%-- 모지 전용 팝업 --%>
	<div class="popup_all">
		<div class="popup_alert_moji">
         </div>
    </div>
	<div class="popup_all">
		<div class="popup_confirm_moji">
         </div>
    </div>
	</jsp:body>
</t:noLayout>
<%@ include file="/WEB-INF/view/pc/portal/event.jsp" %>
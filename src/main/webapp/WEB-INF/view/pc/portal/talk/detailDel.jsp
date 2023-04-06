<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/pc" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<t:noLayout>
    <jsp:attribute name="script_file">
		<%@ include file="/WEB-INF/view/tmpl/pc/portalTalkTmpl.jsp" %>
		<script type="text/javascript">
		<%--top.window.$('head').append('<link rel="shortcut icon" href="${pageContext.request.contextPath}/pc/images/favicon/72x72.png">');--%>
		var userMentorYn = "N";
		var adoptYn = false;
		var talkNo = "${talkNo}";
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

		function movePrev(){
			location.href= contextPath + "/page/portal/talk/myTalk"+ location.search;
		};
		</script>
	</jsp:attribute>
	<jsp:body>
	<div class="moji_detail">
	<div class="awl_opentalk_header">
		<div class="both_area">
			<div class="fl_l">
				<a href="javascript:void(0);" onclick="movePrev()" class="btn_prev" style="width: 50px; height: 50px;"><span class="blind">뒤로가기</span></a>
			</div>
			<h2 class="awl_talkTit" style="color: #222222; font-weight: bold; line-height: 50px; font-size: 18px;">댓글 모두보기</h2>
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
					<p class="awl_content" style="color:#9a9a9a; white-space: pre-line;">
					<span style="font-size: 12px; font-weight: bold;line-height: 1.08;letter-spacing: -0.48px;color: #d82626; display: block;">질문톡 운영 정책에 따라 해당 글이 비노출 되어 이 글을 볼 수 없습니다.</span>
					<span>${opentalk.talkContent}</span>
					</p>
					<div class="awl_box_state">
						<div class="awl_abs_right">
						</div>
					</div>
				</li>
			</ul><!-- 내용 -->
			<div class="line_04 mt10"></div>
			<div class="awl_commentBox pt10">
				<div class="awl_tit2">
<%--					<c:if test="${opentalk.replyCnt > 0}">--%>
<%--						<h1>댓글 ${opentalk.replyCnt -1}개</h1>--%>
<%--					</c:if>--%>
					<h1>댓글 ${opentalk.replyCnt}개</h1>
				</div>
				<%-- 댓글 영역 --%>
				<ul class="swl_comment_list">
					<c:if test="${replyList != null}">
						<c:forEach var="reply" items="${replyList}">
								<li data-no="${reply.hipId}">
									<c:if test="${reply.statusCd == 1 || reply.statusCd == 2}">
										<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"></span>
										<span class="awl_name moji_name">
										<strong>anon</strong>
										<span>${reply.regDt}</span>
										</span>
									</c:if>
									<c:if test="${reply.statusCd == 0}">
										<c:if test="${reply.resourceUri == ''}">
											<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"></span>
										</c:if>
										<c:if test="${reply.resourceUri != ''}">

											<c:choose>
												<c:when test="${reply.hipId == managerHipId}">
													<span class="awl_img"><img src="${reply.resourceUri}" ></span>
												</c:when>
												<c:when test="${reply.mentorYn == 'Y'}">
													<span class="awl_img"><img src="${pageContext.request.contextPath}/pc/images/portal_mentor_profile_img.png" ></span>
												</c:when>
												<c:when test="N">
													<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png"></span>
												</c:when>
											</c:choose>
										</c:if>
										<span class="awl_name moji_name">
										<strong>${reply.nickname}</strong>
										<c:if test="${reply.mentorYn == 'Y'}">
											<span class="swl_badge" style="transform: translate(-80px, 18px) !important;">멘토</span>
										</c:if>
										<span>${reply.regDt}</span>
										</span>
										<c:set var = "partyNm" value = "${reply.partyNm}"/>
		      							<c:if test="${reply.mentorYn == 'Y' && reply.hipId != managerHipId && reply.hipId != managerSupportHipId}">
		      								<br>
		      								<span class="txt_10 swl_mentorMenteeInfo" style="transform:translate(38px, -34px);">
		      									${fn:substring(partyNm,0,5)}, ${reply.departmentLine}, ${reply.studentId}학번
		      								</span>
		      							</c:if>
				      				</c:if>
				      				<c:choose>
				      					<c:when test="${empty reply.delDt}">
				      						<p class="swl_comment_content">${reply.replyContent}</p>
				      					</c:when>
				      					<c:otherwise>
				      						<div style="font-size: 12px; font-weight: bold;line-height: 1.08;letter-spacing: -0.48px;color: #d82626;">질문톡 운영 정책에 따라 해당 글이 비노출 되어 이 글을 볼 수 없습니다.</div>
				      						<p class="swl_comment_content" style="color:#9a9a9a;">${reply.replyContent}</p>
				      					</c:otherwise>
				      				</c:choose>
									<div class="awl_reply_box_state">
										<div class="awl_abs_right">
										</div>
									</div>
								</li>
						</c:forEach>
					</c:if>
				</ul>
			</div><!-- awl_commentBox -->
		</div><!-- awl_main_reply -->
	</div><!-- awl_comment -->
	</div>
	</jsp:body>
</t:noLayout>
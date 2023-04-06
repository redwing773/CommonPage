<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/pc" %>
<t:noLayout>
	<jsp:attribute name="script_file">
		<%@ include file="/WEB-INF/view/tmpl/pc/portalTalkTmpl.jsp" %>
		<%@ include file="/WEB-INF/view/tmpl/app/talkSearchTmpl.jsp" %>
        <%@ include file="/WEB-INF/view/tmpl/app/talkAutoCompleteTmpl.jsp" %>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/inventory_api.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/shop_api.js?ver=20221215"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/consult_api.js?ver=20221215"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/linker_api.js?ver=20221215"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/mojiboard_api.js?ver=20221215"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/portaltalk_api.js?ver=20221215"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/apps/js/search/list.js?ver=20221215"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/apps/js/search/log.js?ver=20221215"></script>
 		<script type="text/javascript">
 		<%-- 사용자 정보 --%>
 		var userHipId = tms.getCookie("hipid");
 		var systemMode = properties.getSystemMode();
 		var token = tms.getCookie("linker_token");
 		var reload = tms.getParameterByName("reload");
 		var onceReload = true;
		var once = true;
		var mentorYn = "N";
		var userMentorYn = "N";
		var adoptYn = false;

		<%-- 검색 시 사용되는 변수 --%>
		var option = {};
		var param = {
			categoryNo: '',
			schoolLevelNm: '',
			condition: 'm1'
		};

		<%-- 전문가 멘토 계정 처리  --%>
		var expertMentor = "";
		if(systemMode == "live") {
			expertMentor= properties.expertMentorLiveHipId;
		} else {
			expertMentor= properties.expertMentorDevHipId;
		}

		var goAppOneLink = "";
		var userAgent = window.navigator.userAgent.toLowerCase();
		 
        var inApp = new Array('iphone','android');

		var inappCheck = false;
		for(var appWord in inApp){
			if(userAgent.match(inApp[appWord]) != null){
				appcss();
				inappCheck = true;
				<%--if (appWord == 0 || appWord == 2 || appWord == 3) {--%>
				<%--	$('.downloadApp').attr("src", "${pageContext.request.contextPath}/apps/images/ic_apple_badge.png");--%>
				<%--	$('.downloadApp').attr("onclick", "goApp2()");--%>
				<%--	goAppOneLink = "https://ilinker.onelink.me/xLdV/q0qpcq0u";--%>
				<%--}else {--%>
				<%--	 $('.downloadApp').attr("src", "${pageContext.request.contextPath}/apps/images/ic_google_badge.png");--%>
				<%--	 $('.downloadApp').attr("onclick", "goGoogle2()");--%>
				<%--	goAppOneLink = "https://ilinker.onelink.me/xLdV/ywoid3u6";--%>
				<%--}--%>
				<%-- $('.downloadApp').css("height", "28px");--%>
				<%-- $('.downloadApp').css("padding", "12px");--%>
			}
		}
		if(!inappCheck) {
			goAppOneLink = "https://ilinker.onelink.me/xLdV/6k0bhn67";
			pccss();
		}

		if(userAgent.indexOf("mac") > -1){
			if(window.navigator.maxTouchPoints == 5){
				<%--$('.downloadApp').attr("src", "${pageContext.request.contextPath}/apps/images/ic_apple_badge.png");--%>
				<%--$('.downloadApp').attr("onclick", "goApp2()");--%>
				goAppOneLink = "https://ilinker.onelink.me/xLdV/q0qpcq0u";
			}
		}
		
        function goGoogle2() {
             window.open("https://ilinker.onelink.me/xLdV/ywoid3u6");
        }
        function goApp2(){
            window.open("https://ilinker.onelink.me/xLdV/q0qpcq0u");
        }
        function goQr2(){
       		openAlertPopupMojiQr();
        }
		
     	function pccss(){
           	var width = $(window).width();
           	width = (width-400)/2+4.5;

			$('#divList').css({'width': '400px', 'margin': '0 auto'});
           	// $('.mojiboard').css({'width': '400px', 'margin': '0 auto'});
           	// $('.board_menu_box').css('width', 'inherit');
			// $('.moveQuestion_btn > div').css({'width': 'calc(100% - 32px)', 'margin': '0 auto', 'max-width': '368px'});
           	$('.awl_fixer_plus2').css({'right':width+'px'});
        	$(".btn_moveQuestion_moji").css("background", "url(" + contextPath +"/apps/images/ic_moji_fab_pc.png)");
        	$(".btn_top_moji").css("background", "url(" + contextPath +"/apps/images/ic_moji_top_pc.png)");
			<%--$('.downloadApp').attr("src", "${pageContext.request.contextPath}/apps/images/ic_linker_badge2.png");--%>
			<%--$('.downloadApp').attr("onclick", "goQr2()");--%>
			<%--$('.downloadApp').css("height", "36px");--%>
			<%--$('.downloadApp').css("padding", "7px");--%>

			<%-- 화면 리사이즈될때 --%>
			$(window).resize(function() {
			 	var width = $(window).width();
	           	width = (width-400)/2+13;
	           	$('.awl_fixer_plus2').css({'right':width+'px'});
			});
     	}
     	
     	function appcss() {
     		top.window.$('head').append('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">');
			$('#divList').css({'width': '100%', 'margin': ''});
			// $('.mojiboard').css({'width': '100%', 'margin': ''});
           	// $('.board_menu_box').css('width', '100%');
			// $('.moveQuestion_btn > div').css({'width': '100%', 'margin': '', 'max-width': 'inherit'});
           	$('.awl_fixer_plus2').css({'right':'16px'});
        	$(".btn_moveQuestion_moji").css({"background": "url(" + contextPath +"/apps/images/ic_moji_fab.png)", "background-size" : "contain"});
        	$(".btn_top_moji").css({"background": "url(" + contextPath +"/apps/images/ic_moji_top.png)", "background-size" : "contain"});
	        $('.mojiSupport').attr("src", "${pageContext.request.contextPath}/apps/images/ic_moji_support.png");
			$(".expertMentor_banner_img").attr("src", "${pageContext.request.contextPath}/apps/images/expertMentor_banner_20211230_mo.png");

			<%-- 화면 리사이즈될때 --%>
			$(window).resize(function() {
	           	$('.awl_fixer_plus2').css({'right':'16px'});
			});
     	}

		let gnbParams = "";
		try {
			const briefingHide = {
				"service" : ["eci"],
				"detail-service" : [],
				"branch-code" : []
			};
			const urlSearch = new URLSearchParams(location.search);
			const gnbService = urlSearch.getAll('gnbService')[0];
			const gnbDetailService = urlSearch.getAll('gnbDetailService')[0];
			const gnbBranch = urlSearch.getAll('gnbBranch')[0];
			const returnURL = urlSearch.getAll('returnURL')[0];

			if(returnURL != undefined){
				location.href = returnURL;
			}

			let isHide = false;
			briefingLoop:
			for(const bKey in briefingHide){
				let target = "";

				switch (bKey) {
					case "service" :
						target = gnbService;
						break;
					case "detail-service" :
						target = gnbDetailService;
						break;
					case "branch-code" :
						target = gnbBranch;
						break;
					default:
						break;
				}

				for(let idx in briefingHide[bKey]){
					if(target == briefingHide[bKey][idx]){
						isHide = true;
						break briefingLoop;
					}
				}
			}

			if(isHide){
				$("#btn_briefing").css('display', 'none');
			} else {
				$("#btn_briefing").css('display', '');
			}

			gnbParams = location.search;
		}catch (e){
			console.error(e)
		}

 		<%-- 매니저 계정 처리  --%>		
		var managerHipId = "";
		var managerSupportHipId = "";
		if(systemMode == "live" || systemMode == "stage") {
			managerHipId = properties.managerLiveHipId;
			managerSupportHipId = properties.managerSupportLiveHipId;
		} else {
			managerHipId = properties.managerDevHipId;
			managerSupportHipId = properties.managerSupportDevHipId;
		}
		 		
		<%-- 스크롤 처리 변수 --%>
		var currentPaging;
		// var defaultOffset = 0;
		var chkPage = 1;
		var limit = 15;
		var endPage = false;
		
		var currentPaging2 = 1;
		var chkPage2 = 1;
		var endPage2 = false;

 		$(function(){
			$("body").css({"height": "auto", "overflow": "hidden"});
 			<%--top.window.$('head').append('<link rel="shortcut icon" href="${pageContext.request.contextPath}/pc/images/favicon/72x72.png">');--%>

			viewGnbPopup();

			<%-- 질문톡 목록 조회 --%>
			getOpenTalkList(currentPaging, limit, ".awl_main_mojilist");
			$("#talkNoDataRecommendTmpl2").tmpl().appendTo("#recommendList");
			getRecommendKeyworkPortal();

			$.fn.scrollStopped = function(callback) {
				var that = this, $this = $(that);
				$this.scroll(function(ev) {
					if($this.scrollTop() > 0) {
						$(".moveQuestion_btn").hide();
						clearTimeout($this.data('scrollTimeout'));
						$this.data('scrollTimeout', setTimeout(callback.bind(that), 250, ev));
					}
				});
			};

			$("#divList").scrollStopped(function(ev){
				if(userMentorYn == "N") {
					$(".moveQuestion_btn").show();
				}
			});

			<%-- 스크롤 페이지--%>
			$("#divList").scroll(function(){
				if (!$("input[name=selectMyTalk]").is(":checked")) {
					if (currentPaging != null && !endPage && $(this).scrollTop() + $(this).height() >= $(this).prop('scrollHeight') - 300) {
						getOpenTalkList(currentPaging, limit, ".awl_main_mojilist");
					}
				} else {
					if (currentPaging != null && !endPage2 && $(this).scrollTop() + $(this).height() >= $(this).prop('scrollHeight') - 300) {
						getMyTalkList(currentPaging2, limit, ".awl_main_mojimylist");
					}
				}

				if ($(this).scrollTop() <= 0) {
					$(".btn_top_moji").hide();
				} else {
					$(".btn_top_moji").show();
				}
			});

			// $(window).scroll(function(){
			// 	if (!$("input[name=selectMyTalk]").is(":checked")) {
			// 		if (currentPaging != null && !endPage &&  $(window).scrollTop() + $(window).height() >= $(document).height() - 182) {
			// 			getOpenTalkList(currentPaging, limit, ".awl_main_mojilist");
			// 		}
			// 	}else{
			// 		if (currentPaging != null && !endPage2 &&  $(window).scrollTop() + $(window).height() >= $(document).height() - 182) {
			// 			getMyTalkList(currentPaging2, limit, ".awl_main_mojimylist");
			// 		}
			// 	}
			//
			// 	if ($(this).scrollTop() <= 0) {
			// 		$(".btn_top_moji").hide();
			// 	 	$('.btn_moveQuestion_moji').css('grid-area', 'c');
			// 		$(".moveQuestion_btn").hide();
			// 	}else{
			// 		$(".btn_top_moji").show();
			// 	 	$('.btn_moveQuestion_moji').css('grid-area', 'b');
			// 		$(".moveQuestion_btn").show();
			// 	}
			// });
			
 			<%-- 질문톡 작성 페이지 이동 --%>
			$(document).on("click",  "#moveQuestion, #moveQuestion2, #moveQuestion4", function(){
				if(userMentorYn == "Y"){
					openAlertPopupMoji("질문톡 작성하기는<br>멘티님만 이용이 가능합니다.");
					return;
				}

 				if (isLoginCheck("write") == 0) {
					portaltalkApi.canJoinPortalDailyEvent(null, function(code, data, res){
						portaltalkApi.retrieveMeasure(null, function(code2, data2){
							if(code === 0 && code2 === 0){
								if (data.canJoin) {
									location.href = contextPath + "/page/portal/talk/write" + location.search;
								}else{
									openAlertPopupMoji("질문 작성 건수가 모두 소진 되었어요.<br>(1일 선착순 "+data2.dailyTotalCnt+"건, 1인 1일 "+data2.dailyJoinCnt+"회 작성 가능)");
								}
							}else {
								location.href = contextPath + "/page/portal/talk/movePage" + location.search;
							}
						});
					});
				}
 			});
 			
 			<%-- 상단으로 이동 --%>
 			$('#moveTop').on("click",function(){
				$('#divList').animate({scrollTop: '0'}, 1000);
 			});

 			<%-- 탭메뉴 이동 --%>
			$('.board_menu_box a').click(function(event){
				event.preventDefault();
				var tabNo = $(this).data("tab");
				$('.awl_header_b').children('a').removeClass('on');

				if(tabNo == 3) {
					location.href = contextPath + "/page/portal/column" + gnbParams;
				}else if(tabNo == 4) {
					location.href = contextPath + "/page/portal/briefing" + gnbParams;
				}else if(tabNo == 0) {
					location.href = contextPath + "/page/portal/talk/myTalk" + gnbParams;
				}else{
					$('#btn_talk').addClass('on');
				}
			});

			<%-- 내글 조회 --%>
			$("input[name=selectMyTalk]").change(function(){
				if($("input[name=selectMyTalk]").is(":checked")){
					if(isLoginCheck() == 0) {
						$('.awl_main_mojilist.moji_talk_list').hide();
						$('.board_mentee_conditionBox').hide();
						$('.awl_wrap.moji_mylist').show();

						if(once){
							getMyTalkList(currentPaging2, limit, ".awl_main_mojimylist");
							once = false;
						}
					}else{
						$("input[name=selectMyTalk]").prop("checked", false);
					}
				}else {
					$('.awl_wrap.moji_mylist').hide();
					$('.board_mentee_conditionBox').show();
					$('.awl_main_mojilist.moji_talk_list').show();
				}
			});

			// $(document).on("click", ".expertMentor_banner_img", function() {
			// 	$.ajax({
			// 		type: "GET",
			// 		url: properties.apiHost() + "/auth/svc/addExpertOpentalkLog",
			// 		beforeSend: function (xhr) {
			// 			xhr.setRequestHeader("hipId",userHipId);
			// 			xhr.setRequestHeader("deviceId","moji-web");
			// 		},
			// 		data: {talkNo:1},
			// 		success: function (res) {
			// 			location.href = contextPath + "/mojiboard/expertMentor?entrance=moji";
			// 		}
			// 	});
			// });
			<%-- 멘티 검색 : 질문자 --%>
			$(document).on("change", "select[name=questioner]", function(){
				var $this = $(this);
				var value = $this.val();

				$(".board_mentee_conditionBox .categoryNo option:eq(0)").prop('selected', true);

				option.schoolLevelNm = value;
				$('.awl_main_mojilist').html("");
				currentPaging = 1;
				getOpenTalkList(currentPaging, limit, ".awl_main_mojilist", option);

				option.schoolLevelNm = '';
			});

			<%-- 멘티 검색 : 주제 --%>
			$(document).on("change", "select[name=categoryNo]", function(){
				var $this = $(this);
				var value = $this.val();

				$(".board_mentee_conditionBox .questioner option:eq(0)").prop('selected', true);

				option.categoryNo = value;
				$('.awl_main_mojilist').html("");
				currentPaging = 1;
				getOpenTalkList(currentPaging, limit, ".awl_main_mojilist", option);

				option.categoryNo = 0;
			});

			<%-- 질문톡 고객센터(카카오톡)으로 이동 --%>
			$('.goKakaoQuestion').on("click", function(){
				window.open("http://pf.kakao.com/_DDxdTxj/chat");
			});

			<%-- 검색용 --%>
			$(".search_area .btn_del").on("click", function() {
				$("#searchKeyword").val("");
				$(".search_area .datalist").empty();
			});
			$("#searchKeyword").on("keypress", function(event) {
				if(event.keyCode == 13) {
					var keyword = $("#searchKeyword").val().trim();
					if(keyword == null || keyword.length <= 0) {
						return;
					}

					searchTalkTotal(keyword);
				}
			});
			$(".btn_do_search").on("click", function(event) {
				var keyword = $("#searchKeyword").val().trim();
				if(tms.isEmpty(keyword)) {
					openAlertPopupMoji("검색어를 입력해주세요.");
					return false;
				}

				searchTalkTotal(keyword);
			});

			$("#searchKeyword").on("keyup", function() {
				var searchWord = $(this).val();
				var param = {
					keyword: searchWord,
					limit: 10
				};

				tms.ajaxGetHelper(contextPath + "/api/search/autoComplete", param, null, function(res){
					var code = res.code;
					$(".search_area .datalist").empty();
					if(code === 0){
						var list = res.data.list;
						if(list != null && list.length > 0) {
							$("#autoCompleteTmpl").tmpl(res.data).appendTo(".search_area .datalist");
						}
					}
				});
			});
		});

		<%-- 검색용 --%>
		function recommendWordClick(keyword) {
			$("#searchKeyword").val(keyword);
			$(".search_area .datalist").empty();
			searchTalkTotal(keyword);
		}
		function searchTalkTotal(searchWord) {
			var keyword = escape(encodeURIComponent(searchWord));
			if(gnbParams.indexOf("?") == 0) {
				location.href = contextPath + "/page/portal/search/question?keyword=" + keyword + "&"+ gnbParams.substr(1);
			}else {
				location.href = contextPath + "/page/portal/search/question?keyword=" + keyword;
			}
		}

 		<%-- 마이톡 목록 조회 --%>
 		var getMyTalkList = function(no, limit, obj) {
			if(isLoginCheck() == 0) {
				chkPage2++;

				var params = {
					pageNo: no,
					limit: limit,
				};

				tms.ajaxGetHelper(contextPath + "/page/portal/talk/myList", params, null, function(res){
					var code = res.code;
					var talkList = res.data.list;
					var msg = res.message;

					if(code === 0){
						if(talkList != null){
							if(talkList.length > 0){
								chkPage2 = currentPaging2;
								currentPaging2++;

								$("#opentalkMyListTmpl").tmpl(talkList).appendTo(obj);

								// 댓글창 focus 시 글쓰기 버튼 감춤 처리
								$('#replyInput').focus(function(){
									$('.awl_fixer_plus2').hide();
								});

								// 댓글창 focus 해제 시 글쓰기 버튼 보이게 처리
								$('#replyInput').blur(function(){
									$('.awl_fixer_plus2').show();
								});

							}else if(talkList.length == 0) {
								if(no == 1){
									var noData = [{msgData : '작성된 글이 없어요.'}];
									$("#noDataTmpl").tmpl(noData).appendTo(obj);
								}
								endPage2 = true;
								return;
							}
						}else{
							endPage2 = true;
							return;
						}
					}else if(code === 101) {
						isLoginCheck();
					}else{
						location.href = contextPath + "/page/portal/talk/movePage" + location.search;
					}
				});
			}
 		};
 		
 		<%-- 질문톡 목록 조회 --%>
		var getOpenTalkList = function(no, limit, obj, option) {
			chkPage++;
			if(tms.isNotEmpty(option)){
				param.categoryNo = tms.isNotEmpty(option.categoryNo) ? option.categoryNo : 0;
				param.schoolLevelNm = tms.isNotEmpty(option.schoolLevelNm) ? option.schoolLevelNm : '';
				param.condition = tms.isNotEmpty(option.condition) ? option.condition : 'm1';
			}

			var params = {
				nextCursor: currentPaging == 1 ? null : currentPaging,
				limit: limit
				//time: moment().format('SSS SS S')
				// defaultOffset: defaultOffset
			};

			params.categoryNo = param.categoryNo;
			params.schoolLevelNm = param.schoolLevelNm;
			params.mentorYn = 'N';

			tms.ajaxGetHelper(contextPath + "/page/portal/talk/talkList", params, null, function(res){
				var code = res.code;
				var talkList = res.data.list;
				var msg = res.message;
				if(code === 0){
					if(talkList != null){
						if(talkList.length > 0){
							currentPaging = res.data.nextCursor;
							// defaultOffset = res.data.defaultOffset;

							talkList = talkList.map(function (obj) {
								obj.userMentorYn = mentorYn;
								return obj;
							});

							$("#opentalkListTmpl").tmpl(talkList).appendTo(obj);
							
							// 댓글창 focus 시 글쓰기 버튼 감춤 처리
				 			$('#replyInput').focus(function(){
				 				$('.awl_fixer_plus2').hide();
				 			});
				 			
				 			// 댓글창 focus 해제 시 글쓰기 버튼 보이게 처리
				 			$('#replyInput').blur(function(){
				 				$('.awl_fixer_plus2').show();
				 			});
				 			
				 			
				 			if (reload == 1 && onceReload) {
				 				 currentPaging = 1;
							     chkPage = 1;
								 endPage = false;
								 onceReload = false;
								 // defaultOffset = 0;
								 $('.awl_main_mojilist').html("");

								 var reloadFn = function(){
									 getOpenTalkList(currentPaging, limit, ".awl_main_mojilist");
									 if(gnbParams.indexOf("gnbService") != -1) {
										 gnbParams = "?"+gnbParams.substr(gnbParams.indexOf("gnbService"));
									 }
									 history.replaceState({}, null, location.pathname+gnbParams)
								 };
								 
								 setTimeout(function() {
									  reloadFn();
									}, 600);
							}
						}else if(talkList.length == 0) {
							if(no == 1){
								var noData = [{msgData : '작성된 글이 없어요.'}];
								$("#noDataTmpl").tmpl(noData).appendTo(obj);
							}
							endPage = true;
							return;
						}
					}else{
						endPage = true;
						return;
					}
				}else{
					location.href = contextPath + "/page/portal/talk/movePage" + gnbParams;
				}
			});
		};
		
		<%-- 댓글 전체보기 이동 --%>
		var moreContentFn = function(talkNo) {
			location.href = contextPath + "/page/portal/talk/detail/"+talkNo + gnbParams;
		};
		
		<%-- 삭제 글	댓글 전체보기 이동 --%>
		var moreContentDelFn = function(talkNo) {
			location.href = contextPath + "/page/portal/talk/dDetail/"+talkNo + gnbParams;
		};
		
		<%-- 댓글 영역 확장 --%>
		var replyExtendFn = function(obj) {
			$(obj).parents('.awl_content_reply_list').find('.awl_comment_box').toggle(600);

			var talkNo = $(obj).parents('.awl_content_reply_list').find('.talkNo').val();
			replyList(obj, talkNo);
			
			winScroll = $(window).scrollTop();
		};
		
		<%-- 삭제 댓글용 --%>
		var replyExtendDelFn = function(obj) {
			var talkNo = $(obj).parents('.awl_content_reply_list').find('.talkNo').val();
			moreContentDelFn(talkNo);
			// $(obj).parents('.awl_content_reply_list').find('.awl_comment_box').toggle(600);
			//
			// var talkNo = $(obj).parents('.awl_content_reply_list').find('.talkNo').val();
			// replyListDel(obj, talkNo);
			//
			// winScroll = $(window).scrollTop();
		};
		
		<%-- 댓글 영역 확장 : closeToggle버튼에 사용 --%>
		var replyExtend2Fn = function (obj){
			$(obj).parents('.awl_content_reply_list').find('.awl_comment_box').toggle(600);
		};

		<%-- 댓글 목록  --%>
		var replyList = function (obj,talkNo){
			$.ajax({
				type : 'GET',
				url : tms.portalProxyUrl(contextPath + '/app/reply/list?') + $.param({'talkNo' : talkNo}),
				success : function(data){
					var rList = '';					
					var hipid = data.hipid;
					var replyList = data.replyList;
					
					$("#questionSum"+talkNo).text(replyList[0].questionSum);

					if(replyList){
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
						$(obj).parents('.awl_content_reply_list').find('.swl_comment_list').html(rList);
					}else{
						rList = '<li style="padding:20px;margin-left:0px;"><p style="text-align:left;">작성된 댓글이 없어요.</p></li>';
						$(obj).parents('.awl_content_reply_list').find('.swl_comment_list').html(rList);
					}
				}
			});
		};

		<%-- 댓글 다시 그려주기 --%>
		var reloadOpentalk = function (obj, talkNo){
			$.ajax({
				type: 'GET',
				url: tms.portalProxyUrl(contextPath + "/app/opentalk/reload/" + talkNo) + "?" + $.param({'talkNo' : talkNo}),
				success: function(data){
					var hipid = data.hipid;				
					var replyList = data.replyList;
					var reloadTalk = data.reloadTalk;
					
					var replyCnt = '';
					var replyTitle = '';
					
					if(reloadTalk){
						replyCnt += '<span class="awl_dat" onClick="replyExtendFn(this);">'+reloadTalk.replyCnt+'개의 댓글 보기</span>';
						replyCnt += '<div class="awl_abs_right">';
							var adoptPoint = tms.setComma(reloadTalk.adoptPoint);
							if(reloadTalk.mentorYn == 'N' && reloadTalk.hipId != managerHipId && reloadTalk.hipId != managerSupportHipId){
								if(reloadTalk.adoptPoint != 0 &&  reloadTalk.closeDate == null ){
									replyCnt += '<a href="javascript:void(0);" class="btn_select txt_13">채택 포인트 : '+adoptPoint+'P</a>';
								}else if(reloadTalk.closeDate != null){
									if(reloadTalk.adoptType == 'questioner'){
						                if(reloadTalk.talkNo <= 913){
						                	replyCnt += '<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택(5,000P)</a>';
						                }else if(reloadTalk.talkNo > 913){
						                	replyCnt += '<a href="javascript:void(0);" class="btn_endSelect txt_13">질문자 채택('+adoptPoint+'P)</a>';
						                }
						            }else if(reloadTalk.adoptType == 'system'){
						                if(reloadTalk.talkNo <= 913){
						                	replyCnt += '<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감(5,000P)</a>';
						                }else if(reloadTalk.talkNo > 913){
						                	replyCnt += '<a href="javascript:void(0);" class="btn_endSelect txt_13">자동 마감('+adoptPoint+'P)</a>';
						                }
						            }
								}
							}
						if(reloadTalk.hipId == userHipId){
							if(hipid == managerHipId){
								replyCnt += '<a href="javascript:void(0);" class="btn_del" onClick="talkDelFn(this,'+reloadTalk.talkNo+');">삭제</a>';
								replyCnt += '<a href="javascript:void(0);" class="btn_upt" onClick="talkUptFn('+reloadTalk.talkNo+');">수정</a>';
							}
						}
						replyCnt += '</div>';
						
						replyTitle += '<strong>댓글 '+reloadTalk.replyCnt+'</strong>';
						replyTitle += '<a href="javascript:void(0);" onClick="moreContentFn('+reloadTalk.talkNo+');">댓글 모두 보기</a></div>';
					}
					$(obj).find('.awl_box_state').html(replyCnt);
					$(obj).find('.awl_comment_tit').html(replyTitle);					

					var rList = '';
                    if(replyList != ""){
                    	$(obj).find('.swl_comment_list').html("");

                    	$("#questionSum"+talkNo).text(replyList[0].questionSum);

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
						$(obj).find('.swl_comment_list').html(rList);
						<%--$(replyList).each(function(){		--%>
						<%--		rList += '<li><div data-no=\''+this.hipId+'\'>';--%>
						<%--		if(this.statusCd == 1 || this.statusCd == 2){--%>
						<%--			rList += '<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png" alt="" /></span>';--%>
						<%--			rList += '<span class="awl_name moji_name"><strong>anon</strong>';--%>
						<%--			rList += '<span class="awl_date">'+this.regDt+'</span></span>';--%>
						<%--			if(this.mentorYn == 'Y'){--%>
						<%--				rList += '<span class="swl_badge">멘토</span>';--%>
						<%--			}--%>
						<%--		}else if(this.statusCd == 0){--%>
						<%--			if(this.resourceUri == ''){--%>
						<%--			    rList += '<span class="awl_img"><img src="${pageContext.request.contextPath}/apps/images/ico_37.png" alt="" /></span>';--%>
						<%--			}else{--%>
						<%--				if (this.hipId == expertMentor){--%>
						<%--					rList += '<span class="awl_img" style="border: solid 1.5px #fd7601 !important;"><img src="'+this.resourceUri+'"></span>';--%>
						<%--					rList += '<img class="expertMentor_medal" src="${pageContext.request.contextPath}/apps/images/expertMentor_medal.png">';--%>
						<%--				}else {--%>
						<%--					rList += '<span class="awl_img"><img src="' + this.resourceUri + '"></span>';--%>
						<%--				}--%>
						<%--			}--%>
						<%--			--%>
						<%--			// 닉네임(이메일) 처리--%>
						<%--			if (this.nickname && this.mentorYn =='N' && this.hipId != managerHipId) {--%>
						<%--				var secretEmail = this.nickname.substring(0, 4);--%>
						<%--				for (var j = 4; j < this.nickname.length; j++) {--%>
						<%--					secretEmail += "*";--%>
						<%--				}--%>
						<%--				rList += '<span class="awl_name moji_name"><strong>'+secretEmail+'</strong>';--%>
						<%--			}else{--%>
						<%--				rList += '<span class="awl_name moji_name"><strong>'+this.nickname+'</strong>';--%>
						<%--			}--%>
						<%--			if(this.mentorYn == 'Y'){--%>
						<%--				rList += '<span class="swl_badge">멘토</span>';--%>
						<%--			}else if(this.hipId == expertMentor){--%>
						<%--				rList += '<span class="expertMentor_bedge_moji">파워멘토</span>';--%>
						<%--			}--%>
						<%--			--%>
						<%--			rList += '<span class="awl_date">'+this.regDt+'</span></span>';--%>
						<%--			--%>
						<%--			if(this.mentorYn == 'Y' && this.hipId != managerHipId && this.hipId != managerSupportHipId && this.hipId != expertMentor){--%>
						<%--				var partyNm = this.partyNm.substring(0,5);--%>
						<%--				rList += '<br><span class="txt_10" style="margin-left: 7px;">'+ partyNm + ', ' + this.departmentLine + ', ' + this.studentId + '학번</span>';--%>
						<%--			}--%>
						<%--		}--%>
						<%--		rList += '</div>';--%>
						<%--		if(this.isAdopt == 1){--%>
						<%--			if(this.adoptType == 'questioner' || this.adoptType == 'questioner_req'){--%>
						<%--				rList += '<button type="button" class="btn_resultReply">채택<br>완료</button>';--%>
						<%--			}else if(this.adoptType == 'system' || this.adoptType == 'system_req'){--%>
						<%--				rList += '<button type="button" class="btn_resultReply">지급<br>완료</button>';--%>
						<%--			}--%>
						<%--		}--%>
						<%--		rList += '<p class="awl_comment_content">'+this.replyContent+'</p>';--%>
						<%--		rList += '<div class="awl_reply_box_state">';--%>

						<%--		if(this.hipId == userHipId){--%>
						<%--			rList += '<div class="awl_abs_right">';--%>
						<%--			rList += '<a href="javascript:void(0);" onClick="replyModifyForm(this,'+this.replyNo+','+this.talkNo+','+this.opentalkNo+');">수정</a>';											--%>
						<%--			rList += '</div>';--%>
						<%--		}--%>
						<%--		rList += '</div></li>';--%>
						<%--});--%>
						<%--$(obj).find('.swl_comment_list').html(rList);--%>
						}else{
							rList = '<li style="padding:20px;margin-left:0px;"><p style="text-align:left;">작성된 댓글이 없어요.</p></li>';
							$(obj).find('.swl_comment_list').html(rList);
						}
					}
			});
		};

		<%-- 댓글 입력 폼 처리 --%>
		var reContext = null;
		var reContextLen = 0;
 		var replyInputFn = function(obj, opentalkNo){
			$(obj).val(tms.removeEmoji($(obj).val()));
			if(isLoginCheck() ==  0) {
				$(this).css({'background':'#ffffff','color':'#000000'});
				$(".awl_fixer_plus2").hide();

				$inputObj = $(obj).parent();
				$countReplyObj = $inputObj.find('.countReply');

				$(obj).css({"background":"#ffffff", "color":"#000000"});

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

				$countReplyObj.text(reContextLen + "/500");
				if(reContextLen > 500){
					openAlertPopupMoji("댓글은 500자를<br>초과할 수 없어요.", function(){
						reContext = reContext.substring(0,500);
						var subReContextLen = reContext.length;
						$(obj).val(reContext);
						$countReplyObj.text(subReContextLen + "/500");
					});
				}
			}
 		};
		
		<%-- 질문톡 채택 --%>
		var adoptReply = function(obj, replyNo, talkNo) {
			var listObj = $(obj).parents(".awl_content_reply_list");
			
			openConfirmPopupMoji({title: "해당 댓글을 채택하시겠습니까?", checkWord: "채택하기", cancelWord: "취소"}, function(){
				var param = {talkNo:talkNo, replyNo:replyNo};
				consultApi.adoptAnswer(param, function(code, res){
					if(code === 0){
						// openAlertPopupMoji("채택이 완료되었습니다.", function(){
						// 	console.log(res.resultText);
						// 	reloadOpentalk(listObj, talkNo);
						// });
						adoptCompleteEventPopup(talkNo, function(){
							reloadOpentalk(listObj, talkNo);
						});
					}else {
						var msg = res.resultText;
						openAlertPopupMoji(msg, function(){});
					}
				});
			});
		};

		<%-- 댓글 작성 --%>
		var replyInsertFn = function (obj, opentalkNo, isCloseDate){
			$(obj).attr('onClick', 'return false'); // 중복 클릭 방지
			$(obj).parent().attr('onclick', 'return false');

			var replyInput = reContext;
			var listObj = $(obj).parents(".awl_content_reply_list");
			var talkNo = $(listObj).find('.talkNo').val();
			var writerHipId = $(listObj).find(".awl_name").data("no");
			var writerMentorYn = $(listObj).find(".awl_user .awl_badge").data("no");

			if (!writerMentorYn) {
				writerMentorYn = "N";
			}

			if(tms.isEmoji(replyInput)){
				openAlertPopupMoji("댓글 작성에 실패했어요.<br>이모티콘은 지원하지 않아요.<br><br>다시 시도해 주세요.", function(){
					$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 취소 시 중복 클릭 방지 해제
					$(obj).parent().removeAttr('onclick');
				});
				return false;
			}

			if(isLoginCheck() == 0 && validContentMoji(replyInput) == 0) {
				var paramData = {
					'hipId':tms.getCookie("hipid"),
					'talkNo':talkNo,
					'replyContent':replyInput,
					'writerHipId':writerHipId,
					'mentorYn': userMentorYn,
					'isCloseDate': isCloseDate == true ? 1 : 0
				};

				if(writerMentorYn == "N" && userMentorYn == "Y" && replyInput.length < 50){
					if(isCloseDate == false){
						var msgObj = {
							title: "50자 미만은 포인트가<br>지급되지 않으며,<br>작성된 댓글은 삭제되지 않습니다.<br>채택 후 모든 댓글은 수정이 불가합니다.<br><br>작성하시겠습니까?"
							,checkWord: "확인"
							,cancelWord: "취소"
						};

						$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 취소 시 중복 클릭 방지 해제
						$(obj).parent().removeAttr('onclick');

						openConfirmPopupMoji(msgObj, function(){
							saveReply(obj, listObj, paramData, writerMentorYn, opentalkNo, isCloseDate);
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
							saveReply(obj, listObj, paramData, writerMentorYn, opentalkNo, isCloseDate);
						});
					}
				} else if(writerMentorYn == "N" && userMentorYn == "Y" && replyInput.length >= 50) {
					var msgObj = {
						title: "작성된 댓글은 삭제되지 않습니다.<br>채택 후 모든 댓글은 수정이 불가합니다.<br>작성하시겠습니까?"
						,checkWord: "확인"
						,cancelWord: "취소"
					};

					$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 취소 시 중복 클릭 방지 해제
					$(obj).parent().removeAttr('onclick');

					openConfirmPopupMoji(msgObj, function(){
						saveReply(obj, listObj, paramData, writerMentorYn, opentalkNo, isCloseDate);
					});
				} else {
					saveReply(obj, listObj, paramData, writerMentorYn, opentalkNo, isCloseDate);
				}
				
				// $(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 취소 시 중복 클릭 방지 해제
				// $(obj).parent().removeAttr('onclick');
				//
				// openConfirmPopupMoji({title: "작성된 댓글은 삭제할 수 없어요.<br>댓글을 작성할까요?", checkWord: "확인", cancelWord: "취소"}, function(){
				// 	saveReply(obj, listObj, paramData, writerMentorYn, opentalkNo, isCloseDate);
				// });
			}
		};
		
		<%-- 댓글 작성 로직 분리 --%>
		var saveReply = function(obj, listObj, paramData, writerMentorYn, opentalkNo, isCloseDate) {
			paramData.registerKakaoAlarm = "Y";
			$.ajax({
				type : 'GET',
				url : tms.portalProxyUrl(contextPath + '/app/reply/write?' + $.param(paramData)),
				// data : JSON.stringify(paramData),
				// contentType: 'application/json',
				// contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				success : function(result){
					if(result){
						// console.log("result: "+ result);
						$(window).scrollTop(winScroll); // 저장된 스크롤 값에 따라 해당 위치로 이동

						$(listObj).find('#replyInput').val("");
						if(!isCloseDate){
							opentalkReplyEvent(writerMentorYn, paramData.replyContent, paramData.talkNo, opentalkNo); // 이벤트 처리
						}
						$(listObj).find('.countReply').text("0/500");

						$('.awl_fixer_plus2').show();
						
						$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 중복 클릭 방지 해제
						$(obj).parent().removeAttr('onclick');
						
						reContext = "";

						reloadOpentalk(listObj, paramData.talkNo); // DOM 다시 그려줌
					}
				},error: function(){
					openAlertPopupMoji("댓글 작성에 실패했어요.<br>이모티콘은 지원하지 않아요.<br><br>다시 시도해 주세요.", function(){
						reloadOpentalk(listObj, paramData.talkNo);
						
						$(obj).attr('onClick', 'replyInsertFn(this,'+opentalkNo+','+isCloseDate+');'); // 중복 클릭 방지 해제
						$(obj).parent().removeAttr('onclick');
					});
				}
			});
		};

		<%-- 이벤트 포인트 지급 --%>
		var opentalkReplyEvent = function(writerMentorYn, replyContent, talkNo, opentalkNo) {
			var param = { talkNo : talkNo };
			if(opentalkNo == 1){
				if(userMentorYn == "Y" && writerMentorYn == "N" && replyContent.length >= 50){
					shopApi.opentalkReplyEvent(param, function(res){
						// console.log(res.resultText);
					});
				}
			}else if(opentalkNo == 6){
				shopApi.opentalkReplyEvent(param, function(res){
					// console.log(res.resultText);
				});
			}
		};

		<%-- 댓글 수정 --%>
		var replyModifyForm = function (obj, replyNo, talkNo, opentalkNo){
			var replyContent = $(obj).parent().parent().parent().find('p.awl_comment_content').text();
			var str = new String(replyContent);
			var len = str.length;
			var data = [{"talkNo" : talkNo, "replyNo" : replyNo, "replyContent" : replyContent, "len" : len , "opentalkNo" : opentalkNo}];
			$commentObj = $(obj).parents(".awl_comment_box");
			$replyObj = $commentObj.find(".awl_swl_comment");
			$replyObj.empty();
			
			$('#basicReplyInputTmpl').tmpl(data).appendTo($replyObj);

			$('.awl_fixer_plus2').hide();
			$('.replyArea').focus();
		};
		
		<%-- 댓글 수정 시 글자수 카운팅 --%>
		var uptFn = function (obj, opentalkNo){
			$inputObj = $(obj).parent();
			$countReplyObj = $inputObj.find('.countReply');
			
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
			
			$countReplyObj.text(uptContent.length + "/500");
			if(uptContentLen > 500){
				openAlertPopupMoji("댓글은 500자를 초과할 수 없어요.", function(){
					uptContent = uptContent.substring(0,500);
					var subUptLen = uptContent.length;
					$(obj).val(uptContent);
					$countReplyObj.text(subUptLen + "/500");
				});
			}
		};
		
		<%-- 댓글 수정 --%>
		var replyModifyFn = function (obj, replyNo, talkNo, opentalkNo){
			var listObj = $(obj).parents(".awl_content_reply_list");
			var uptTalkNo = talkNo;
			var updateContent = $(listObj).find('.replyArea').val();

			if(validContentMoji(updateContent) == 0 && isLoginCheck() ==  0){
				var param = {'replyNo':replyNo, 'replyContent':updateContent};
				$.ajax({
					type : 'GET',
					url : tms.portalProxyUrl(contextPath + '/app/reply/modifyAction?') + $.param(param),
					success : function(result){
						if(result){
							$(window).scrollTop(winScroll);
							
							$(listObj).find('.swl_comment_input').empty();

							var reload = '';

							reload += '<textarea rows=2 placeholder="댓글에 이모티콘 입력 불가" maxlength="500" id="replyInput" oncopy="return false;" onpaste="openAlertPopupMoji(\'댓글 복사,붙여넣기 금지\'); return false;" oncut="return false;" onclick="replyInputFn(this, '+opentalkNo+');" onkeyup="replyInputFn(this, '+opentalkNo+');" oninput="replyInputFn(this, '+opentalkNo+');"></textarea>';
							reload += '<a href="#"><img src="${pageContext.request.contextPath}/apps/images/ico_send.png" class="sendIcon" onClick="replyInsertFn(this, '+opentalkNo+');"/></a>';
							reload += '<span class="countReply">0/500</span>';
							
							$(listObj).find('.swl_comment_input').html(reload);
							
							reloadOpentalk(listObj,uptTalkNo);
							$('.awl_fixer_plus2').show();
						}
					},error: function(){
						openAlertPopupMoji("댓글 수정에 실패했어요.<br>다시 시도해 주세요.", function(){
							reloadOpentalk(listObj, uptTalkNo);
						});
					}
				});
			}
		};

		var isLoginCheck = function(actionNm){
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
								location.href = properties.membershipAuthDomain()+"/transfer/gate?forceTransfer=Y&clientId="+properties.membershipClientId()+"&sessionToken="+res.value.session_token+"&callbackUrl="+properties.membershipCallbackUrlPortal() + "&returnURL=" + encodeURIComponent(properties.membershipReturnUrlPortal() + location.search);
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
							location.href = contextPath + "/page/portal/talk/movePage" + gnbParams;
						}
					});
				}else {
					common.loginMembershipPortal(actionNm);
				}
			}else if(common.ssoLoginCode === 10009 || common.ssoLoginCode === 10046 || common.ssoLoginCode === 10047) {
				//openConfirmPopupMoji({title: "질문톡 서비스 이용 동의 후 사용할 수 있습니다.", checkWord: "확인", cancelWord: "취소"}, function(){
					common.loginMembershipPortal(actionNm);
				//});
				return -1;
			}else if(!common.userInfo.isLogin && common.ssoLoginCode !== 0){
				//openConfirmPopupMoji({title: "로그인 후 서비스를 이용할 수 있습니다.", checkWord: "로그인", cancelWord: "취소"}, function(){
					//window.opener.postMessage("parentWindowLogin", "*");
					common.loginMembershipPortal(actionNm);
				//});
				return -1;
			}else {
				return 0;
			}
		};
		
		var validContentMoji = function(value){
			if(value == "" || value == null){
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
		
		var openAlertPopupMojiQr = function(){
			Layer_OPEN(".popup_alert_moji_qr");
		};
		</script>
	</jsp:attribute>
	<jsp:body>
	<%-- 헤더 --%>
	<div class="mojiboard">
		<div class="board_menu_box" style="padding: 0;width: 100%; position:relative; top: 0px; left: 0;background-color: #fff; border-bottom: 1px solid #F1F1F1;z-index: 999">
			<div class="awl_header2" style="width: 100%; height: 50px; max-width: 400px; margin: 0 auto;">
				<div class="awl_header_l">
					<img src="${pageContext.request.contextPath}/pc/images/portaltalk_title2.png" alt="입SEE" style="width: 99px;">
				</div>
				<div class="awl_header_c" style="cursor: pointer;width: fit-content; position: absolute;top: 0;right: 0;">
<%--					<div class="goKakaoQuestion" style="display: none;">--%>
<%--                        <div class="goKakaoQuestion_img">--%>
<%--						    <img src="${pageContext.request.contextPath}/pc/images/gnb_kakao_talk_img2.svg" alt="질문톡 고객센터" style="width: 16px;">--%>
<%--                        </div>--%>
<%--                        <div class="goKakaoQuestion_txt_area">--%>
<%--                            <span class="goKakaoQuestion_txt1">질문톡 고객센터</span>--%>
<%--                            <span class="goKakaoQuestion_txt2">평일 10시 - 17시</span>--%>
<%--                        </div>--%>
<%--					</div>--%>
					<div class="veiwEventWinner" style="width: 175px; height: 42px; margin-top: 4px;margin-right: 16px; display: none;">
						<img src="${pageContext.request.contextPath}/pc/images/event_winner_btn2.svg" alt="질문톡 이벤트 당첨자" style="transform: translateX(-4px);">
					</div>
				</div>
				<div class="awl_header_r">
				</div>
			</div>

			<div class="awl_header_b" style="max-width: 384px;margin: 0 auto;padding-left: 16px;">
				<a href="javascript:void(0);" id="btn_talk" class="moji_tab on" data-tab="1">질문톡</a>
				<a href="javascript:void(0);" id="btn_column" class="moji_tab" data-tab="3">멘토칼럼</a>
				<a href="javascript:void(0);" id="btn_briefing" class="moji_tab" data-tab="4" style="display: none">
					<img src="${pageContext.request.contextPath}/pc/images/briefing_icon.png" style="width: 14px; vertical-align: text-top;margin-top: 1px;"> 설명회
				</a>
				<a href="javascript:void(0);" id="btn_mytalk" class="moji_tab" data-tab="0">내글</a>
			</div>
		</div>
		<div style="display: flex; justify-content: center; background-color: #F7F9FF; height: calc(100vh - 100px);">
			<div id="divList" style="position:absolute;top:100px;height:calc(100vh - 100px); overflow:auto;max-width:400px; width: 400px; margin: 0px auto;">
				<div class="search_area">
					<div class="title">질문 검색</div>
					<div class="in_box">
						<input type="text" id="searchKeyword" placeholder="검색어를 입력해 주세요.">
						<button type='button' class='btn_del'><span class="blind">삭제</span></button>
						<button type="button" class="btn_do_search"><span>검색하기</span></button>
					</div>
					<div class="datalist" style="transform: translateZ(10px);"></div>
					<div class="awl_content">
						<div id="recommendList"></div>
					</div>
				</div>

				<div class="awl_wrap moji_list" style="background: none; margin-top: 16px;">
<%--				<img src="${pageContext.request.contextPath}/pc/images/image_portal_04.png" class="banner_img" id="moveQuestion2" style="width: 100%; cursor: pointer;">--%>
					<%-- 전문가 멘토 배너 영역 --%>
				<div class="board_expertMentor_box2 mb10 mt10" style="display: none; padding: 0 18px 0 18px;">
					<img src="${pageContext.request.contextPath}/apps/images/expertMentor_banner_20211230_pc.png" class="expertMentor_banner_img" style="width: 100%; cursor: pointer;">
				</div>
					<%-- 조건검색 --%>
				<div class="portal_opentalk_list_filter">
	<%--				<div class="my_talk_list">--%>
	<%--					<label class="mytalk_checkbox">--%>
	<%--						<input type="checkbox" name="selectMyTalk" class="blind"><em></em><span style="vertical-align: bottom;">내글</span>--%>
	<%--					</label>--%>
	<%--				</div>--%>
					<div class="board_mentee_conditionBox">
						<select class="questioner txt_13" name="questioner">
							<option value="">질문자 전체</option>
							<option value="h3">고3</option>
							<option value="h2">고2</option>
							<option value="h1">고1</option>
							<option value="m3">중3</option>
							<option value="etc">그 외 학년</option>
						</select>
						<select class="categoryNo txt_13" name="categoryNo">
							<option value="0">주제 전체</option>
							<option value="13">학습법</option>
							<option value="14">학교생활</option>
							<option value="15">입시</option>
							<option value="16">기타</option>
						</select>
					</div>
				</div>
				<div class="awl_content">
					<%-- 질문톡 리스트 --%>
					<ul class="awl_main_mojilist moji_talk_list" style="padding:0 16px 20px 16px;"></ul>
				</div>
				<div class="awl_fixer_plus2 on" style="bottom: 79px;">
					<%--<a href="javascript:void(0);" id="moveQuestion" class="btn_moveQuestion_moji" style="grid-area: c;"><span class="blind">질문톡</span></a>--%>
					<a href="javascript:void(0);" id="moveTop" class="btn_top_moji" style="display: none;"><span class="blind">TOP</span></a>
				</div>
				<div class="moveQuestion_btn" style="position: fixed; left: 0;width: 100%; text-align: center;z-index: 10;height: 74px; bottom: 0;">
					<div style="background-color: rgb(247, 249, 255); height: inherit; width: 100% ;min-width: 328px; margin: 0 auto;">
						<a href="javascript:void(0);" id="moveQuestion" style="font-size: 16px;cursor: pointer;width:100%;max-width: 364px; min-width: 328px; height: 52px;background: #302cc8; border-radius: 6px; color: #fff;display: inline-block; line-height: 52px;">
						멘토에게 질문하기<span class="ico_badge" style="position: relative;display: inline-block;top: -10px;margin-left: 8px;margin-right: -60px;height: 40px;animation: ani_bounce 1s ease-in-out infinite;"><img src="${pageContext.request.contextPath}/apps/images/ico_question_badge.png" width="70" alt="5분 답변"></span>
						</a>
					</div>
				</div>

				<div class="awl_wrap moji_mylist" style="display: none; background: none;">
					<div class="awl_content">
							<%-- 마이톡 리스트 --%>
						<ul class="awl_main_mojimylist moji_talk_list" style="padding:0 16px 88px 16px;"></ul>
					</div>
				</div>
			</div>
		</div>
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
    <div class="popup_all">
		<div class="popup_alert_moji_qr">
			<div class="outter_box">
	            <div class="inner_box" style=" width: 320px;  height: 383px; padding: 20px 25px 20px 25px;  text-align: center; border-radius: 6px;">
	                <h2 class="title" style="font-size: 16px; line-height: 22px; color: #000; font-weight: 600; letter-spacing: -0.5px;">QR코드로 다운로드하기</h2>
	                <img src="${pageContext.request.contextPath}/pc/images/portal_linker_qr.svg" style="width: 238px; bottom: 80px; position: absolute; left: 45px;">
	                <div class="btn_box" style=" width: 100%; position: absolute; left: 0px; bottom: 0px;">
	                    <a href="javascript:void(0);" class="btn_40" style="width:100%; background: #302cc8; line-height: 60px; height: 60px; font-size: 16px;" onclick="Layer_CLOSE('.popup_alert_moji_qr')">확인</a>
	                </div>
	            </div>
	        </div>
         </div>
    </div>
	</jsp:body>
</t:noLayout>
<%@ include file="/WEB-INF/view/pc/portal/event.jsp" %>
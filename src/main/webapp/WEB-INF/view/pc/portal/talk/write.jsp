<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/pc" %>
<t:noLayout>
    <jsp:attribute name="script_file">
		<%@ include file="/WEB-INF/view/tmpl/pc/portalTalkTmpl.jsp" %>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/code_api.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/inventory_api.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/consult_api.js?ver=202011130"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/linker_api.js?ver=20201222"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/membership_api.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/mojiboard_api.js?ver=20211102"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/portaltalk_api.js?ver=20221102"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/api/myPage_api.js?ver=220915"></script>
		<script type="text/javascript">
		var userHipId = tms.getCookie("hipid");
		var userMentorYn = "N";
		var systemMode = properties.getSystemMode();
		var dailyJoinCnt = 5;
		var dailyTotalCnt = 100;

		var userAgent = window.navigator.userAgent.toLowerCase();

		var inApp = new Array('iphone','android');

		var gnbParams = "";

		try {
			const urlSearch = new URLSearchParams(location.search);
			const gnbService = urlSearch.getAll('gnbService')[0];
			const returnURL = urlSearch.getAll('returnURL')[0];

			if(returnURL != undefined && gnbService == undefined){
				gnbParams = returnURL;
				if(gnbParams.indexOf("?") != -1) {
					gnbParams =  gnbParams.substr(gnbParams.indexOf("?")+1);
				}

				var accessTokenInter = tms.getParameterByName("accessToken");
				var integrateType = tms.getParameterByName("type");
				if(accessTokenInter && integrateType != "account" && integrateType != "sns"){
					tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/etoos/login", JSON.stringify({
						pushKey: "",
						apnsPushKey: ""
					}), {
						headers: {
							'authorization': accessTokenInter,
							"osType": "P",
							"appVersion": "1.1.7"
						}
					}, function (res) {
						if (res.resultCode === 0) {
							tms.ajaxPostHelper(properties.apiHost() + "/auth/svc/etoos/addConnectLog", JSON.stringify({pushKey: "", apnsPushKey: ""}), {headers: {'authorization': accessTokenInter, "osType": "P", "appVersion": "1.1.7"}}, null);

							tms.setCookie("accessTokenInter", accessTokenInter, -1);
							tms.setCookie("hipid", res.result.hipId, -1);
							tms.setCookie("linker_token", res.result.token, -1);

							if (res.result.integratedMemberNo > 0) {
								tms.setCookie("integratedMemberYn", "Y", -1);
							} else {
								tms.setCookie("integratedMemberYn", "N", -1);
							}
							location.href = contextPath + "/page/portal/talk/write?" + gnbParams;
						}
					});
				}else {
					location.href = contextPath + "/page/portal/talk/write?" + gnbParams;
				}
			}
		}catch (e) {
			console.error(e);
		}
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

		var prev = tms.getParameterByName("prev");
		var keyword = tms.getParameterByName("keyword");

		function pccss(){
           	$('.moji_write').css({'width': '400px', 'margin': '0 auto'});
	        // $('.awl_word .awl_write_btn_forMoji').css('width', '400px');
	        $('.banner_img').css('width', '400px');
     	}
 		
     	function appcss() {
     		top.window.$('head').append('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">');
     		$('.moji_write').css({'width': '100%', 'margin': ''});
	        // $('.awl_word .awl_write_btn_forMoji').css('width', '100%');
	        $('.banner_img').css('width', '100%');
     	}
		<%-- 매니저 계정 처리 --%>
		var systemMode = properties.getSystemMode();
		var managerHipId = "";
		if(systemMode == "live" || systemMode == "stage") {
			managerHipId = properties.managerLiveHipId;
		} else {
			managerHipId = properties.managerDevHipId;
		}
		
		//var hasMatchingInfo = false;
		var saveComplete ="";
		
		$(function(){
			<%--top.window.$('head').append('<link rel="shortcut icon" href="${pageContext.request.contextPath}/pc/images/favicon/72x72.png">');--%>
			
			<%-- 뒤로가기 버튼 처리 --%>
			$('.btn_prev').on('click',function(){
				openConfirmPopupMoji({title: "질문이 등록되지 않았어요.<br>입력한 질문을 등록하지 않고 이동하시겠습니까?", checkWord: "취소", cancelWord: "등록없이 나가기"},  function(){}, function(){
					movePrev();
				});
			});
			
			<%-- 글쓰기 영역 클릭 시 활성화 --%>
			$('.awl_text').on('click',function(){
				$(".awl_intext").hide();
				$("#talkContent").focus();
			});

			<%-- 글쓰기 영역 fcusout시 텍스트 다시 보여주기 --%>
			$('#talkContent').on('focusout',function(){
				if(tms.isEmpty($("#talkContent").text())) {
					$(".awl_intext").show();
				}
			});
			
			<%-- 글자수 카운팅 --%>
			$('div[name="talkContent"]').on("input keyup", function(){
				checkTextCount();
			});
			
			<%-- 게시글 등록 --%>
			$("#btn_register").on("click", function(){
				if(userMentorYn == "Y"){
					openAlertPopupMoji("질문톡 작성하기는<br>멘티님만 이용이 가능합니다.", function(){
						gnbParams = location.search;
						gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
						location.href = contextPath + "/page/portal/talk/list?"  + gnbParams;
					});
					return;
				}
				canJoinPortalDailyEvent("saveOpenTalk");
			});
			
		   <%-- 관심 대학 검색 --%>
            $(document).on("keyup", "input[name=universitySchool]", function () {
                var code = [3];
                searchSchool($(this).val(), code, $("#universitySchool"));
            });
            
            <%-- 검색한 대학교 추가 --%>
			$(document).on("click", "#universitySchool li a", function(){
		        var $this = $(this);
		        var dataCnt = 0;
		        $('#need_university li input[name="university"]').each(function(){
		        	var dataValue = $(this).val();
		        	if(tms.isNotEmpty(dataValue)){
		        		dataCnt++;
		        	}
		        });
		        
		        if(dataCnt >= 3){
					openAlertPopupMoji("대학은 최대 3개까지<br>설정 가능해요.", function(){
						$("#universitySchool").empty();
		            	$("input[name=universitySchool]").val("");
					});
		        } else if(dataCnt < 3){
		        	var $universityObj = '<li><label class="checkbox style_04"><input type="checkbox" name="university" value="'+ $this.data("no") +'"/><span>'+$this.text().substring(0,5)+'</span></label></li>';
				    $("#need_university").append($universityObj);
				    $("#universitySchool").empty();
	            	$("input[name=universitySchool]").val("");
			        $("input[name=universitySchool]").trigger("change");
		        }
		    });
			
			<%-- 계열 선택 --%>
			$(document).on("click", "input[name=menteeLine]", function(){
				var $len = $("input[name=menteeLine]:checked").length;
				var $val = $(this).val();
				if($len > 3){
					$('#need_acceptance input[value='+$val+']').prop('checked', false);
					
					openAlertPopupMoji("계열은 최대 3개까지<br>설정 가능해요.");
				}
		    });
			
			<%-- 관심 대학 제거 --%>
			$(document).on("click", "#need_university li", function(){
				$(this).remove();
			});
		});

		var canJoinPortalDailyEvent = function(funcNm) {
			portaltalkApi.canJoinPortalDailyEvent(null, function(code, data, res){
				if(code === 0){
					if (data.canJoin) {
						if(funcNm == "saveOpenTalk") {
							saveOpenTalk();
						}
					}else{
						openAlertPopupMoji("질문 작성 건수가 모두 소진 되었어요.<br>(1일 선착순 "+ dailyTotalCnt +"건, 1인 1일 "+ dailyJoinCnt +"회 작성 가능)", function() {
							gnbParams = location.search;
							gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
							location.href = contextPath + "/page/portal/talk/list?"  + gnbParams;
						});
					}
				}else {
					gnbParams = location.search;
					gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
					location.href = contextPath + "/page/portal/talk/movePage?" + gnbParams;
				}
			});
		};

 		<%-- 글자 수 카운팅 --%>
		var checkTextCount = function () {
			var reContext = $("#talkContent").text();
			$(".cnt").text(reContext.length);
			
			if( reContext.length > 0){
				if(reContext.length > 200){
					openAlertPopupMoji("내용은 200자를<br>초과할 수 없어요.", function(){
						reContext = reContext.substring(0,200);
						$("#talkContent").text(reContext);
						$(".cnt").text(reContext.length);
					});
				}
			}
		};
		
		<%-- 게시글 저장 --%>
		var saveOpenTalk = function(){
			var talkContent = $('#talkContent').text();
			var categoryNo = $("input:radio[name='questionMethod']:checked").val();

			if(isLoginCheck() ==  0 && validContentMoji(talkContent) == 0){

			 	var matchingParam = '';
			   <%--
               if (!hasMatchingInfo) {
                   //var univList = []; // 대학
                   var lineList = []; // 계열

                   <%--대학
                   $('input[type="checkbox"][name="university"]').each(function(){
                       univList.push(Number($(this).val()));
                   });--%>
		           <%--계열
		            $('input[type="checkbox"][name="menteeLine"]:checked').each(function(){
		            	lineList.push(Number($(this).val()));
		            });
		            
		            <%-- 유효성 검사
		            if(tms.isEmpty(univList)){
						openAlertPopupMoji("관심 대학을 선택해 주세요.");
		           		return false;
		            }
		            if(tms.isEmpty(lineList)){
						openAlertPopupMoji("관심 계열을 선택해 주세요.");
		        		return false;
		            }
		            
		            matchingParam = {
						lineList: lineList
						//, univList: univList
					};		            
				}
				--%>
				
				if(tms.isEmoji(talkContent)){
					openAlertPopupMoji("이모티콘은 지원하지 않아요.<br><br>다시 시도해 주세요.", function(){
					});
					return false;
				}

				var param = {
					hipId: tms.getCookie("hipid"),
					talkContent: talkContent,
					adoptPoint: 500,
					categoryNo: categoryNo,
					opentalkNo: 1,
					portalTalk: "true"
				};

				openConfirmPopupMoji({title: "질문을 등록할까요?<br><span style='color: #ff0000; font-size:13px; font-weight: 500;'>등록한 질문은 삭제 또는 수정을 할 수 없어요.</span>", checkWord: "질문 등록하기", cancelWord: "취소"}, function(){
					saveOpentalkComplete(param, matchingParam);
				}, function(){});
			}
		};
		
		<%-- 오픈톡 저장 완료 로직 변경 --%>
		var saveOpentalkComplete  = function(param, matchingParam) {
			$("#talkContent").prop('disabled', true);
			$("#btn_register").prop('disabled', true);
			$("#btn_register").css("background","#757575");
			$("#btn_register").text('질문 등록 중');
			$(".popup_confirm_moji .btn_box #checkWord").css('background', '#757575');

			<%--
			if (!hasMatchingInfo) {
				saveMatchingRequestInfo(matchingParam);
			}
			--%>
			if (saveComplete == 0) {
				$.ajax({
					type : 'GET',
					url : tms.portalProxyUrl(contextPath + '/app/opentalk/writeAction?' + $.param(param)),
					// data : param,
					// contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					success : function(result){ // result = talkNo
						if(result){
							var hours = moment().hour();
							if(hours >= 23 || hours <= 8){
								openAlertPopupMoji("매일 23시 ~ 08시에는<br>멘토님들의 답변이<br>조금 늦을 수 있어요.", function(){
									opentalkComplete();
								});
							}else {
								opentalkComplete();
							}
						}
					},error: function(){
						openAlertPopupMoji("등록에 실패했어요.<br>다시 시도해 주세요.", function(){
							gnbParams = location.search;
							gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
							location.href = contextPath + "/page/portal/talk/list?"  + gnbParams;
						});
					}
				});
			}
		};
		
		<%-- 오픈톡 완료 처리 --%>
		var opentalkComplete = function() {
			talkCompleteEventPopup(function(){
				gnbParams = location.search;
				gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
				// location.href = contextPath + "/page/portal/talk/list?reload=1&" + gnbParams;
				location.href = contextPath + "/page/portal/talk/myTalk?reload=1&" + gnbParams;
			});
		};
		
		<%-- 매칭 정보 저장 처리 --%>
		var saveMatchingRequestInfo = function(param) {
			myPageApi.updateMenteeInformationInTheMyInfoV2(param, {async:false}, function(res){
				var code = res.resultCode;
				saveComplete = code;
				if (code != 0) {
					openAlertPopupMoji("등록에 실패했어요.<br>다시 시도해 주세요.", function () {
						gnbParams = location.search;
						gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
						location.href = contextPath + "/page/portal/talk/list?"  + gnbParams;
					});
				}
			});
		};
		
		<%-- 첫질문 여부 확인 --%>
		var mojiMatchingRequestInfo =  function() {
			// if (isLoginCheck() !=  0) {
			// 	$("#btn_register").prop('disabled', true);
			// 	$("#talkContent").prop('disabled', true);
			// }
			portaltalkApi.retrieveMeasure(null, function(code, data){
				if(code === 0){
					dailyTotalCnt = data.dailyTotalCnt;
					dailyJoinCnt = data.dailyJoinCnt;
				}
				$(".dailyTotalCnt").text(dailyTotalCnt);
				$(".dailyJoinCnt").text(dailyJoinCnt);
			});

			<%--
			myPageApi.retrieveMenteeInformation({menteeHipId: hipId}, function (code, data) {
				if(code === 0){
					console.log("계열length: " + Object.keys(data).includes('menteeLineList'));
					if(!Object.keys(data).includes('menteeLineList')) {
						<%-- 최근 관심 계열, 대학 리스트 출력
						getMenteeSetting();
						//getSchool();

						$('.myInterest_content').show();
					}else {
						hasMatchingInfo = true;
					}
				}else {
					gnbParams = location.search;
					gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
					location.href = contextPath + "/page/portal/talk/movePage?" + gnbParams;
				}
			});
			--%>
		};
		
        <%-- 최근 관심 전형 셋팅--%>
		var getMenteeSetting = function () {
            codeApi.getRetrieveCd({categoryNo: "17", parentNo: "0"}, function (code, data) {
                if(code === 0) {
                    data.filter(function (item) {
                        $("#need_acceptance").append('<li><label class="checkbox style_01"><input type="checkbox" name="menteeLine" value="'+item.codeNo+'"/><span>'+item.codeNm+'</span></label></li>');
                    });
                }
            });
        }
		
	 	<%-- 전체 학교 정보 --%>
        var getSchool = function () {
            membershipApi.retrieveSchool({searchKey:""}, function (code, data) {
                if(code === 0) {
                    school = data;
                }
            });
        };
        
		<%-- 학교 검색 --%>
        var searchSchool = function(searchWord, schoolCd, $searchList){
            $searchList.empty();
            if(searchWord.length < 1){
                return;
            }

            <%-- getSchool에서 받은 학교 데이터 filter 처리  --%>
            var result = school.filter(function (item) {
            	if(typeof schoolCd === "object"){
		        	return tms.isNotEmpty(item.schoolNm) && item.schoolNm.startsWith(searchWord) && item.schoolCd >= Math.min.apply(null, schoolCd) && item.schoolCd <= Math.max.apply(null, schoolCd);
		        }else{
		        	return tms.isNotEmpty(item.schoolNm) && item.schoolNm.startsWith(searchWord) && item.schoolCd === schoolCd;
		        }
            });

            <%-- 검색 후 결과 영역에 바인딩 --%>
            if(result.length > 0){
                result.forEach(function(item){
                    $searchList.append('<li class="list-group-item pl5"><a href="javascript:void(0);" class="txt_13" data-no='+item.partyNo+' data-code='+item.schoolCd+'>'+item.schoolNm+'</a></li>');
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
							gnbParams = location.search;
							gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
							location.href = contextPath + "/page/portal/talk/movePage?" + gnbParams;
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
	        
	        $(".popup_alert_moji .btn_box a").html("");
	        $(".popup_alert_moji .btn_box a").html("확인");
			Layer_OPEN(".popup_alert_moji");

	        if(typeof fnAction == "function"){
	            $(".popup_alert_moji .btn_box a").bind("click", function(){
	                fnAction();
	                $(this).unbind();
	            });
	        }
	        
		};
		
		var openAlertPopupMoji2 = function(title, fnAction, checkWord){
			$(".popup_alert_moji").html("");
	        $("#alert_moji").tmpl({title:title}).appendTo(".popup_alert_moji");
	        
	        $(".popup_alert_moji .btn_box a").html("");
	        $(".popup_alert_moji .btn_box a").html("작성 중인 글 수정하기");
			Layer_OPEN(".popup_alert_moji");

	        if(typeof fnAction == "function"){
	            $(".popup_alert_moji .btn_box a").bind("click", function(){
	                fnAction();
	                $(this).unbind();
	            });
	        }
	        
		};
		
		var openConfirmPopupMoji = function(msgObj, fnAction, fnCancel){
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
	        if(typeof fnCancel == "function"){
	            $(".popup_confirm_moji .btn_box #cancelWord").bind("click", function(){
	            	fnCancel();
	                Layer_CLOSE('.popup_confirm_moji')
	                $(this).unbind();
	            });
	        }
		};

		function movePrev(){
			gnbParams = location.search;
			gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
			if(prev == "question") {
				location.href= contextPath + "/page/portal/search/question?keyword="+keyword + "&" +gnbParams;
			}else {
				location.href= contextPath + "/page/portal/talk/list?"+ gnbParams;
			}
		};
		</script>
		<style>
		input:focus {border:solid 1px #302cc8;}
		.checkbox.style_01 span {padding:0px 0px; width:100%; height: 36px; background-color: #EEEEEE; border-radius: 100px; color: #000; font-weight: 400;font-size: 13px;letter-spacing: -0.05em;line-height: 35px;border: none;}
		.checkbox.style_01 input[type="checkbox"]:checked + span {border:solid 1px #302cc8; color:#fff; background:#302cc8;}
		</style>
	</jsp:attribute>
	<jsp:body>
<div class="moji_write" style="min-height: 100vh; overflow: auto;margin:0 auto;max-width:400px ;">
	<div class="awl_opentalk_header">
		<div class="both_area">
			<div class="fl_l">
				<a class="btn_prev" style="width: 50px; height: 50px;"><span class="blind">뒤로가기</span></a>
			</div>
			<h2 class="awl_talkTit" style="color: #222222; font-weight: bold; line-height: 50px; font-size: 20px;transform: translateY(2px);">멘토에게 질문하기</h2>
		</div>
	</div>
	<div class="awl_wrap" style="background: none;letter-spacing: -0.05em;margin-top: 26px;">
		<div class="myInterest_content moji_write_option" style="display: none;">
			<section class="myInterest_current">
				<div class="mb20 padding_04" style="display: none;">
					<div class="current_univ_title">
						<p class="fw_500 mb5" style="font-size: 15px;">· 관심 대학을 선택해주세요. <span class="txt_11">(최대 3개)</span></p>
					</div>
					<div class="university_search mb10">
						<input type="text" class="myInterest_univ" name="universitySchool" placeholder="관심대학을 입력하세요" style="background: url(${pageContext.request.contextPath}/apps/images/ic_search.png) right 14px center no-repeat !important;background-size: 15px 15px !important;">
						<div class="current_univList">
							<ul class="list-group" id="universitySchool"></ul>
						</div>
					</div>
					<ul class="chk_list_02 mb5" id="need_university"></ul>
				</div>
				<div class="mb40 padding_04" style="padding-top: 16px;">
					<div class="current_line_title" style="display: none;">
						<p class="fw_500 mb5" style="font-size: 15px;">· 관심 계열을 선택해주세요. <span class="txt_11">(최대 3개)</span></p>
					</div>
					<ul class="chk_list_02" id="need_acceptance"></ul>
				</div>
			</section>
		</div>
		<div class="awl_word" style="height: auto;">
			<p class="fw_500 mb8" style="font-size: 16px; padding: 0px 16px; letter-spacing: -0.04em;">멘토에게 무엇이든 물어보세요.</p>
			<div class="awl_word_header" style="margin: 5px 0 12px 0;padding: 0px 16px;">
				<div id="commonArea" class="question_common">
					<label class="radiobox style_04"><input type="radio" name="questionMethod" value="13" checked="checked"><em style="display: none;"></em><span>학습법</span></label>
					<label class="radiobox style_04"><input type="radio" name="questionMethod" value="14"><em style="display: none;"></em><span>학교생활</span></label>
					<label class="radiobox style_04"><input type="radio" name="questionMethod" value="15"><em style="display: none;"></em><span>입시</span></label>
					<label class="radiobox style_04"><input type="radio" name="questionMethod" value="16"><em style="display: none;"></em><span>기타</span></label>
				</div>
			</div>
			<div class="awl_text" style="padding: 0px 16px;">
				<%-- <textarea id="talkContent" name="talkContent" style="resize:none; border: solid 1px #d4d6de; border-radius: 8px; height: 200px; padding: 14px 16px 28px 16px;"></textarea> --%>
				<div class="talkContentPortal">
					<div id="talkContent" name="talkContent" contenteditable="true" class="talkContentPortal_con"></div>
				</div>
				<span class="awl_intext" style="color: #9a9a9a;padding: 26px 32px; text-align: left; line-height: 19px; width: auto;letter-spacing: 0px;">
					<span class="txt_11">
						- 질문톡은 링커의 후원으로 무료로 운영됩니다.<br>
						- 1인당 1일 <span class="dailyJoinCnt"></span>회의 질문이 가능합니다. (1일 총 <span class="dailyTotalCnt"></span>건 선착순)<br>
						- 이모티콘은 입력이 불가합니다.<br>
					</span>
				</span>
				<div class="write_count">
					<span class="cnt">0</span> / 200
				</div>
			</div>
			<div style="padding: 4px 16px 0 16px; color: #9A9A9A; letter-spacing: -0.05em; font-size: 12px; font-weight: 400; margin-bottom: 100px !important;">
				<div class="mb8">
					* 질문 내용에 서비스와 관련된 문구가 포함될 경우 질문이&ensp;등록되지<br>&ensp; 않을 수 있습니다.<br>
<%--					<span style="display: inline-block; margin-top: 5px;">* 처음 오신 회원님은 닉네임이 자동 생성 되었어요!</span>--%>
				</div>
			</div>
			<div class="awl_write_btn_forMoji">
<%--				<span style="font-weight: 400; font-size: 12px; letter-spacing: -0.05em; color: #9A9A9A; position: absolute; top: 0px;">--%>
<%--					* 질문톡은 대학생 멘토가 활동하는 링커에 게시됩니다.--%>
<%--				</span>--%>
<%--				<button type="button" onclick="movePrev()" style="margin-right: 8px; border: solid 1px #E5E5E5; background: #E5E5E5;font-weight: 500;">취소</button>--%>
				<button type="button" id="btn_register" style="background:#302cc8; color:#fff;">질문하기</button>
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
	</jsp:body>
</t:noLayout>
<%@ include file="/WEB-INF/view/pc/portal/event.jsp" %>
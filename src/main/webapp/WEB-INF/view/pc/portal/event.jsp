<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
    $(function () {
		$("input[name=eventAgree]").change(function(){
			if($("input[name=eventAgree]").is(":checked")){
				$(".popup_gnb_event_complete2 .joinMojiReward").addClass("on");
			}else {
				$(".popup_gnb_event_complete2 .joinMojiReward").removeClass("on");
			}
		});

		$(document).on("click", ".veiwEventWinner", function() {
			var expire = new Date();
			expire.setDate(expire.getDate() + 30);
			document.cookie = "popupWinnerInfo" + '=' + escape("Y") + '; path=/; expires=' + expire.toGMTString() + ';';

			$('.popupWinnerInfo').addClass('open');

			$(".veiwEventWinner").css("display", "none");
			$(".awl_header2").css("position", "initial");
			$(".goKakaoQuestion").css("display", "flex");
		});
    });

	//이벤트 종료일 체크
	var isExpireEventData = function() {
		var _expiredDataStr = "2022-11-28 23:59";
		var today = new Date();
		var d = _expiredDataStr.split(/[\s,\-:]+/);
		var expired_date = new Date(d[0], d[1] - 1, d[2], d[3] || 24, d[4] || 0);

		return today < expired_date;
	}

	//이벤트 공지사항 시작일, 종료일 체크
	var isExpireWinnerInfoData = function() {
		var _startedDataStr = "2022-12-06 10:00";
		var _expiredDataStr = "2022-12-12 23:59";
		var today = new Date();
		var d2 = _startedDataStr.split(/[\s,\-:]+/);
		var d = _expiredDataStr.split(/[\s,\-:]+/);
		var started_date = new Date(d2[0], d2[1] - 1, d2[2], d2[3] || 24, d2[4] || 0);
		var expired_date = new Date(d[0], d[1] - 1, d[2], d[3] || 24, d[4] || 0);

		return today < expired_date && today > started_date;
	}

	var goToMoji = function(){
		window.open(properties.getMojiSiteHost() + "/#/product/productIntro");
	};

	var notViewToday = function(){
		var expire = new Date();
		expire.setDate(expire.getDate() + 1);
		document.cookie = "popupGnbEvent" + '=' + escape("Y") + '; path=/; expires=' + expire.toGMTString() + ';';

		Layer_CLOSE(".popup_gnb_event");
	};

	var viewGnbPopup = function(){
		var popupGnbEventCookie = tms.getCookie("popupGnbEvent");
		if(isExpireEventData()) {
			if(popupGnbEventCookie != "Y") {
				$('.popup_gnb_event').addClass('open');
			}
		}

		//이벤트 공지 사항 버튼 및 고객센터 노출
		var popupWinnerInfoCookie = tms.getCookie("popupWinnerInfo");
		if(popupWinnerInfoCookie != "Y" && isExpireWinnerInfoData()) {
			$(".veiwEventWinner").css("display", "block");
			$(".awl_header2").css("position", "relative");
		}else {
			$(".goKakaoQuestion").css("display", "flex");
		}
	};

	var talkCompleteEventPopup = function(fn) {
		if(isExpireEventData()) {
			$('.popup_gnb_event_complete1').addClass('open');
		}else {
			if(typeof fn === "function") {
				fn();
			}
		}
		if(typeof fn === "function") {
			$(".moveTalkDetail").unbind().bind("click", function(){
				fn();
			});
		}
	}

	var closeConfirm1 = false;
	var popupGnbEventComplete1Close =  function() {
		if(closeConfirm1 == false) {
			if(isExpireEventData()) {
				$('.popup_event_close_alert').addClass('open');
				closeConfirm1 = true;
			}
		}else{
			moveMytalk();
		}
	}

	var closePopupAll =  function() {
		Layer_CLOSE('.popup_event_close_alert');
		moveMytalk();
	}

	var moveMytalk = function() {
		Layer_CLOSE('.popup_gnb_event_complete1');
		if(tms.isEmpty("gnbParams")) {
			var gnbParams = "";
		}
		gnbParams = location.search;
		gnbParams = gnbParams.substr(gnbParams.indexOf("gnbService"));
		location.href = contextPath + "/page/portal/talk/myTalk?reload=1&" + gnbParams;
	}

	var downloadMojiReport1 = function() {
		window.location.assign("https://s3.ap-northeast-2.amazonaws.com/www.ilinker.co.kr/pdf/gnb/etoos_analysis.pdf");
	}

	var downloadMojiReport2 = function() {
		window.location.assign("https://s3.ap-northeast-2.amazonaws.com/www.ilinker.co.kr/pdf/gnb/etoos_table.zip");
	}

	var downloadMojiReport3 = function() {
		window.location.assign("https://s3.ap-northeast-2.amazonaws.com/www.ilinker.co.kr/pdf/gnb/etoos_schedule.pdf");
	}

	var adoptCompleteEventPopup = function(talkNo, fn) {
		if(isExpireEventData()) {
			$('.popup_gnb_event_complete2').addClass('open');
		}
		if(typeof fn === "function") {
			fn();
		}

		$(".joinMojiReward").unbind().bind("click", function(){
			if(!$("input[name=eventAgree]").is(":checked")){
				return;
			}
			if(!$(".joinMojiReward").hasClass("on")) {
				return;
			}
			tms.ajaxPostHelper(properties.apiHost() + "/edu/svc/etoos/apply", JSON.stringify({talkNo: talkNo}), null, null);
			if(isExpireEventData()) {
				$('.popup_event_final').addClass('open');
			}
			setTimeout(function() {
				Layer_CLOSE('.popup_event_final');
				Layer_CLOSE('.popup_gnb_event_complete2');
			}, 2000);
		});
	}

	var closeConfirm2 = false;
	var popupGnbEventComplete2Close =  function() {
		if(closeConfirm2 == false) {
			if(isExpireEventData()) {
				$('.popup_event_close_alert2').addClass('open');
				closeConfirm2 = true;
			}
		}else{
			Layer_CLOSE('.popup_gnb_event_complete2');
		}
	}

	var closePopupAll2 =  function() {
		Layer_CLOSE('.popup_event_close_alert2');
		Layer_CLOSE('.popup_gnb_event_complete2');
	}

	var detailAgreeView = function() {
		if(isExpireEventData()) {
			$('.popup_detail_agree').addClass('open');
		}
	}
</script>
<style>
	.popup_all .btn_box em{font-size: 17px; display: inline-block;transform: translateY(1px);line-height: 15px;}
	.popup_gnb_event_complete2 .checkbox_event_agree{width: 196px;height: 16px;position: absolute;left: 37px;bottom: 86px;}
	.popup_gnb_event_complete2 .checkbox_event_agree span {background: url(../../../../pc/images/event_checkbox.svg) left center no-repeat; display: inline-block;width: 100%;height: 100%;}
	.popup_gnb_event_complete2 .checkbox_event_agree input[type="checkbox"]:checked + span {background: url(../../../../pc/images/event_checkbox_active.svg) left center no-repeat;}
	.popup_gnb_event_complete2 .joinMojiReward{display: inline-block; width:100%; height: 56px; border-radius: 0 0 18px 18px; z-index: 1; text-align: center; background-color: #C9C9C9;}
	.popup_gnb_event_complete2 .joinMojiReward.on{background-color: #302cc8;}
	.goToMojiBtn{position: absolute;width: 35%; height: 13px; right: 10%; bottom: calc(14% + 56px)}
	@media screen and (max-width:315px){.goToMojiBtn{bottom: calc(13% + 56px)}}
	@media screen and (max-width:265px){.goToMojiBtn{bottom: calc(12% + 56px)}}
	@media screen and (max-width:230px){.goToMojiBtn{height: 10px;}}
</style>
<div class="popup_all">
	<div class="popup_gnb_event" style="z-index: 999;">
		<div class="outter_box">
			<div class="inner_box" style="position: relative; width: 328px; height: 606px; background: none; border-radius: 0;">
				<div style="margin-bottom: 11px; height: 32px; overflow: hidden;">
					<div class="btn_box" style="display: inline-block; cursor: pointer;">
						<img src="${pageContext.request.contextPath}/pc/images/not_view_today.svg" onclick="notViewToday()">
						<span class="blind">오늘 하루 안 보기</span>
					</div>
					<div class="btn_box" style="display: inline-block;float: right; cursor: pointer;">
						<img src="${pageContext.request.contextPath}/pc/images/gnb_event_close.svg" onclick="Layer_CLOSE('.popup_gnb_event')">
						<span class="blind">닫기</span>
					</div>
				</div>
				<div style="width: 328px; background: url('../../../../pc/images/gnb_event_popup2.svg') center center no-repeat; height: 507px;border: none;background-size: cover;"></div>
				<div class="btn_box" style="width: 100%; position: absolute; left: 0; bottom: 0;">
					<a href="javascript:void(0);" id="moveQuestion4" style="display: inline-block; width:100%; height: 56px; border-radius: 0 0 18px 18px; z-index: 1; text-align: center; background-color: #302cc8;">
						<span style="font-size: 15px; font-weight: 700;letter-spacing: -0.02em; color: #fff; display: inline-block; padding-top: 17px; text-align: center;">질문하고 바로 경품 받기 <em>></em></span>
					</a>
				</div>
				<div class="btn_box" style=" width: 100%; position: absolute; left: 16px; bottom: 235px;">
					<a href="javascript:void(0);" onclick="goToMoji()" style="display: inline-block; width:119px; height: 26px; border-radius: 10px;"><span class="blind">MOJI 자세히 보기 ></span></a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="popup_all">
	<div class="popup_gnb_event_complete1">
		<div class="outter_box">
			<div class="inner_box" style="position: relative; width: 328px; height: 594px; background: none; border-radius: 0;">
				<div style="margin-bottom: 11px; height: 32px; overflow: hidden;">
					<div class="btn_box" style="display: inline-block;float: right; cursor: pointer;">
						<img src="${pageContext.request.contextPath}/pc/images/gnb_event_close.svg" onclick="popupGnbEventComplete1Close()">
						<span class="blind">닫기</span>
					</div>
				</div>
				<img src="${pageContext.request.contextPath}/pc/images/event_talk_complete.svg">
				<div class="btn_box" style="width: 100%; position: absolute; left: 0; bottom: 0;">
					<a class="moveTalkDetail" href="javascript:void(0);" style="display: inline-block; width:100%; height: 56px; border-radius: 0 0 18px 18px; z-index: 1; text-align: center; background-color: #302cc8;">
						<span style="font-size: 15px; font-weight: 700;letter-spacing: -0.02em; color: #fff; display: inline-block; padding-top: 17px; text-align: center;">답변 확인하기 <em>></em></span>
					</a>
				</div>
				<div class="btn_box" style="position: absolute;width: 79px; height: 38px; top: 187px;right: 27px;">
					<a href="javascript:void(0);" onclick="downloadMojiReport1()" style="display: inline-block; width:100%; height: 100%; border-radius: 3px;"><span class="blind">받기</span></a>
				</div>
				<div class="btn_box" style="position: absolute;width: 79px; height: 38px; top: 250px;right: 27px;">
					<a href="javascript:void(0);" onclick="downloadMojiReport2()" style="display: inline-block; width:100%; height: 100%; border-radius: 3px;"><span class="blind">받기</span></a>
				</div>
				<div class="btn_box" style="position: absolute;width: 79px; height: 38px; top: 312px;right: 27px;">
					<a href="javascript:void(0);" onclick="downloadMojiReport3()" style="display: inline-block; width:100%; height: 100%; border-radius: 3px;"><span class="blind">받기</span></a>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="popup_all">
	<div class="popup_event_close_alert">
		<div class="outter_box">
			<div class="inner_box" style="position: relative; width: 328px; height: 346px; background: none; border-radius: 0;">
				<div style="margin-bottom: 11px; height: 32px; overflow: hidden;">
					<div class="btn_box" style="display: inline-block;float: right; cursor: pointer;">
						<img src="${pageContext.request.contextPath}/pc/images/gnb_event_close.svg" onclick="Layer_CLOSE('.popup_event_close_alert')">
						<span class="blind">닫기</span>
					</div>
				</div>
				<img src="${pageContext.request.contextPath}/pc/images/event_close_alert.svg">
				<div class="btn_box" style="width: 100%; position: absolute; left: 0; bottom: 0;">
					<a onclick="closePopupAll()" href="javascript:void(0);" style="display: inline-block; width:50%; height: 56px; border-radius: 0 0 0 18px; z-index: 1; text-align: center; background-color: #A8B2D3; float: left;">
						<span style="font-size: 15px; font-weight: 700;letter-spacing: -0.02em; color: #fff; display: inline-block; padding-top: 17px; text-align: center;">닫기</span>
					</a>
					<a onclick="Layer_CLOSE('.popup_event_close_alert')" href="javascript:void(0);" style="display: inline-block; width:50%; height: 56px; border-radius: 0 0 18px 0; z-index: 1; text-align: center; background-color: #302cc8;">
						<span style="font-size: 15px; font-weight: 700;letter-spacing: -0.02em; color: #fff; display: inline-block; padding-top: 17px; text-align: center;">돌아가기</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="popup_all">
	<div class="popup_gnb_event_complete2">
		<div class="outter_box">
			<div class="inner_box" style="position: relative; width: 328px; height: 504px; background: none; border-radius: 0;">
				<div style="margin-bottom: 11px; height: 32px; overflow: hidden;">
					<div class="btn_box" style="display: inline-block;float: right; cursor: pointer;">
						<img src="${pageContext.request.contextPath}/pc/images/gnb_event_close.svg" onclick="popupGnbEventComplete2Close()">
						<span class="blind">닫기</span>
					</div>
				</div>
				<img src="${pageContext.request.contextPath}/pc/images/event_adopt_complete3.svg">
				<label class="checkbox_event_agree"><input name="eventAgree" style="display: none;" type="checkbox" value="Y"/><span></span></label>
				<div class="btn_box" style="width: 100%; position: absolute; left: 0; bottom: 0;">
					<a class="joinMojiReward" href="javascript:void(0);">
						<span style="font-size: 15px; font-weight: 700;letter-spacing: -0.02em; color: #fff; display: inline-block; padding-top: 17px; text-align: center;">MOJI 경품 응모하기 <em>></em></span>
					</a>
				</div>
				<div class="btn_box" style="position: absolute;width: 52px; height: 16px; bottom: 86px; right: 37px;">
					<a href="javascript:void(0);" onclick="detailAgreeView()" style="display: inline-block; width:100%; height: 100%;"><span class="blind">자세히보기</span></a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="popup_all">
	<div class="popup_event_close_alert2">
		<div class="outter_box">
			<div class="inner_box" style="position: relative; width: 328px; height: 346px; background: none; border-radius: 0;">
				<div style="margin-bottom: 11px; height: 32px; overflow: hidden;">
					<div class="btn_box" style="display: inline-block;float: right; cursor: pointer;">
						<img src="${pageContext.request.contextPath}/pc/images/gnb_event_close.svg" onclick="Layer_CLOSE('.popup_event_close_alert2')">
						<span class="blind">닫기</span>
					</div>
				</div>
				<img src="${pageContext.request.contextPath}/pc/images/event_complete_close_alert.svg">
				<div class="btn_box" style="width: 100%; position: absolute; left: 0; bottom: 0;">
					<a onclick="closePopupAll2()" href="javascript:void(0);" style="display: inline-block; width:50%; height: 56px; border-radius: 0 0 0 18px; z-index: 1; text-align: center; background-color: #A8B2D3; float: left;">
						<span style="font-size: 15px; font-weight: 700;letter-spacing: -0.02em; color: #fff; display: inline-block; padding-top: 17px; text-align: center;">닫기</span>
					</a>
					<a onclick="Layer_CLOSE('.popup_event_close_alert2')" href="javascript:void(0);" style="display: inline-block; width:50%; height: 56px; border-radius: 0 0 18px 0; z-index: 1; text-align: center; background-color: #302cc8;">
						<span style="font-size: 15px; font-weight: 700;letter-spacing: -0.02em; color: #fff; display: inline-block; padding-top: 17px; text-align: center;">돌아가기</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="popup_all">
	<div class="popup_event_final">
		<div class="outter_box">
			<div class="inner_box" style="position: relative; width: 300px; height: 162px; background: none; border-radius: 0;">
				<img src="${pageContext.request.contextPath}/pc/images/event_adopt_real_complete.svg" style="width: 100%;">
			</div>
		</div>
	</div>
</div>

<div class="popup_all">
	<div class="popup_detail_agree">
		<div class="outter_box">
			<div class="inner_box" style="position: relative; width: 328px; height: 376px; background: none; border-radius: 0;">
				<div style="margin-bottom: 11px; height: 32px; overflow: hidden;">
					<div class="btn_box" style="display: inline-block;float: right; cursor: pointer;">
						<img src="${pageContext.request.contextPath}/pc/images/gnb_event_close.svg" onclick="Layer_CLOSE('.popup_detail_agree')">
						<span class="blind">닫기</span>
					</div>
				</div>
				<img src="${pageContext.request.contextPath}/pc/images/event_join_popup.svg" style="width: 100%;">
				<div class="btn_box" style="width: 100%; position: absolute; left: 0; bottom: 0;">
					<a onclick="Layer_CLOSE('.popup_detail_agree')" href="javascript:void(0);" style="display: inline-block; width:100%; height: 56px; border-radius: 0 0 18px 18px; z-index: 1; text-align: center; background-color: #302cc8;">
						<span style="font-size: 15px; font-weight: 700;letter-spacing: -0.02em; color: #fff; display: inline-block; padding-top: 17px; text-align: center;">확인</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="popup_all">
	<div class="popupWinnerInfo">
		<div class="outter_box">
			<div class="inner_box" style="position: relative; max-height: 594px; background: none; border-radius: 0;width: calc(100% - 32px);max-width: 360px;">
				<div style="margin-bottom: 11px; height: 32px; overflow: hidden;">
					<div class="btn_box" style="display: inline-block;float: right; cursor: pointer;">
						<img src="${pageContext.request.contextPath}/pc/images/gnb_event_close.svg" onclick="Layer_CLOSE('.popupWinnerInfo')">
						<span class="blind">닫기</span>
					</div>
				</div>
				<img src="${pageContext.request.contextPath}/pc/images/event_winner_notice_popup2.svg" style="width: 100%;">
				<div class="btn_box">
					<a onclick="Layer_CLOSE('.popupWinnerInfo')" href="javascript:void(0);" style="display: inline-block; width:100%; height: 56px; border-radius: 0 0 18px 18px; z-index: 1; text-align: center; background-color: #302cc8;">
						<span style="font-size: 15px; font-weight: 700;letter-spacing: -0.02em; color: #fff; display: inline-block; padding-top: 17px; text-align: center;">확인</span>
					</a>
				</div>
				<div class="btn_box goToMojiBtn">
					<a href="https://moji.etoos.com" target='_blank' style="display: inline-block; width:100%; height: 100%;"><span class="blind">https://moji.etoos.com</span></a>
				</div>
			</div>
		</div>
	</div>
</div>
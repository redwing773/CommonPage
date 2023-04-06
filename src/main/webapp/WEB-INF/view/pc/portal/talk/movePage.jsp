<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags/pc" %>
<t:noLayout>
    <jsp:attribute name="script_file">
		<script type="text/javascript">
		<%--top.window.$('head').append('<link rel="shortcut icon" href="${pageContext.request.contextPath}/pc/images/favicon/72x72.png">');--%>
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
           	$('.moji_move').css({'width': '400px', 'margin': '0 auto'});
     	}
 		
     	function appcss() {
     		top.window.$('head').append('<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">');
           	$('.moji_move').css({'width': '100%', 'margin': ''});
     	}
		function moveMoji(){
			location.href= contextPath + "/page/portal/talk/list"  + location.search;
		}
		</script>
	</jsp:attribute>
	<jsp:body>
		<div class="moji_move" style="text-align: center; top: 200px; position: relative;">
			<div style="">
				<img src="${pageContext.request.contextPath}/pc/images/computer_potal.png" style="width: 126px;">
			</div>
			<br>
			<div style="font-size: 18px; font-weight: bold;">	
				사용량이 많아 접속이 지연되고 있어요.<br>
				잠시 후 다시 이용해 주세요.
			</div>
			<br>
			<button style="width: 160px;height: 40px; border-radius: 6px; background-color: #302cc8; font-weight: 500; color: #fff;" onclick="moveMoji()">확인</button>
		</div>
	</jsp:body>
</t:noLayout>
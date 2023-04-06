<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="headerCategoryTmpl" type="text/x-jquery-tmpl">
<h2 style="font-size:20px; font-weight:500; transform:translateY(10px);">\${categoryName}</h2>
</script>

<script id="infoListTmpl" type="text/x-jquery-tmpl">
<div class="point_box">
	<img src="${pageContext.request.contextPath}/apps/images/ico_01.png">
	<p class="money">포인트 </p>
</div>
<div class="remove_box">
	<p class="txt_13 goods">내 상품</p>
	<img src="${pageContext.request.contextPath}/apps/images/ic_arrow_right.png">
</div>
</script>

<script id="brandListTmpl" type="text/x-jquery-tmpl">
<li class="btn_select" data-tab="1" data-no=\${brandCode}>
	<img src=\${brandIconImg} class="brandIconImg">
	<p class="brandName txt_11">\${brandName}</p>
</li>
</script>

<script id="shopListTmpl" type="text/x-jquery-tmpl">
<li data-no=\${goodsCode} onClick="moveGoodsDetail(this);">
	<div class="goods_box">
		<img src=\${goodsImgS} class="goodsImgS">
		<p class="brandName" data-no=\${brandCode}>\${brandName}</p>
		<p class="goodsName">[\${brandName}] \${goodsName}</p>
		<div class="price_box">
			<img src="${pageContext.request.contextPath}/apps/images/ico_01.png">
			<p class="realPrice txt_13">\${realPrice}</p>
		</div>							
	</div>
</li>
</script>

<script id="popupPurchaseTmpl" type="text/x-jquery-tmpl">
<h2 class="title"><span class="realPrice">\${realPrice}</span>포인트가 차감됩니다.</h2>
<p class="mb5" style="font-size:15px;><span class="brandName">[\${brandName}]</span><span class="goodsName">\${goodsName}</span></p>
<div class="noti_box" style="padding-bottom:0px;">
    <img src=\${goodsImgS}>
    <p style="text-align:center;font-size:16px;"><span class="realPrice">\${realPrice}</span>P</p>
</div>
</script>

<script id="popupConfirmTmpl" type="text/x-jquery-tmpl">
<h2 class="title">구매완료!</h2>
<p class="mb5" style="font-size:15px;">
	<span class="brandName">[\${brandName}]</span><span class="goodsName">\${goodsName}</span>
	<br>구매가 완료되었어요
	<br>구매한 상품을 확인하실래요?
	<br>계속 쇼핑하실래요?
</p>
</script>

<script id="searchNoDataTmpl" type="text/x-jquery-tmpl">
    <li id="mentoListNoData"><div>조회된 결과가 없습니다.</div></li>
</script>

<script id="admissionListTmpl" type="text/x-jquery-tmpl">
    <p>\${universityNm}</p>
</script>

<script id="specialSelfInfoTmpl" type="text/x-jquery-tmpl">
{{if isPurchase == true}}
	<div class="wrap_schoolRecord_complete mb10" data-no="\${hipId}" data-purchase="\${isPurchase}" data-productno="\${productNo}" data-categoryno="\${categoryNo}" style="opacity:0.5;">
		<div class="select_selfInfoBox">
			{{if numberPages > 0}}<p class="numberPages fw_500" >총 \${numberPages}장</p>{{/if}}
			<p class="university txt_141 fw_500 mb3"><span class="fw_600">\${universityNm}&ensp;</span> \${majorNm} | \${studentId}학번</p>
			<p class="acceptance txt_13 fw_500 mb5">\${acceptance}, \${areaSchoolNm}</p>
			{{if admissionCnt > 1}}
			    <p class="admission mt5">
			        <span class="admission_inner">
			         <span class="admission_inner2">
			                <span class="txt_141 ">총 \${admissionCnt}개</span>
			                <br> <span>수시 합격</span>
			           </span>
			        </span>
			    </p>
			{{/if}}
<%--			<p class="nickname txt_12 fw_500 mb3">\${nickname}</p>--%>
			<p class="grade txt_12">\${grade}</p>
			{{if admissionCnt > 1}}<div class="admissionList txt_12 mt5">{{html universityNmList}}</div>{{/if}}
			
		</div>
	</div>
{{else (isPurchase == false)}}
	{{if itemPurchaseCnt > 0}}
	<div class="wrap_schoolRecord_fragment mb10" data-no="\${hipId}" data-purchase="\${isPurchase}" data-productno="\${productNo}" data-categoryno="\${categoryNo}">
		<div class="purchase_complete">생기부의 일부 항목을 30일 이내에 구매한 적이 있습니다.</div>	
		<div class="select_selfInfoBox2">
			{{if numberPages > 0}}<p class="numberPages fw_500" >총 \${numberPages}장</p>{{/if}}
			<p class="university txt_141 fw_500 mb3"><span class="fw_600">\${universityNm}&ensp;</span> \${majorNm} | \${studentId}학번</p>
			<p class="acceptance txt_13 fw_500 mb5">\${acceptance}, \${areaSchoolNm}</p>
			{{if admissionCnt > 1}}
			    <p class="admission mt5">
			        <span class="admission_inner">
			            <span class="admission_inner2">
			              <span class="txt_141">총 \${admissionCnt}개</span>
			               <br> <span>수시 합격</span>
			            </span>
			        </span>
			    </p>
			{{/if}}
<%--			<p class="nickname txt_12 fw_500 mb3">\${nickname}</p>--%>
			<p class="grade txt_12">\${grade}</p>
			{{if admissionCnt > 1}}<div class="admissionList txt_12 mt5">{{html universityNmList}}</div>{{/if}}
		</div>
	</div>
	{{else}}
	<div class="wrap_schoolRecord_buyAll mb10" data-no="\${hipId}" data-purchase="\${isPurchase}" data-productno="\${productNo}" data-categoryno="\${categoryNo}">
		<div class="select_selfInfoBox">
			{{if numberPages > 0}}<p class="numberPages fw_500" >총 \${numberPages}장</p>{{/if}}
			<p class="university txt_141 fw_500 mb3"><span class="fw_600">\${universityNm}&ensp;</span> \${majorNm} | \${studentId}학번</p>
			<p class="acceptance txt_13 fw_500 mb5">\${acceptance}, \${areaSchoolNm}</p>
			{{if admissionCnt > 1}}
			    <p class="admission mt5">
			        <span class="admission_inner">
			            <span class="admission_inner2">
                            <span class="txt_141">총 \${admissionCnt}개</span>
                            <br> <span>수시 합격</span>
			            </span>
			        </span>
			    </p>
		    {{/if}}
<%--			<p class="nickname txt_12 fw_500 mb3">\${nickname}</p>--%>
			<p class="grade txt_12">\${grade}</p>
			{{if admissionCnt > 1}}<div class="admissionList txt_12 mt5">{{html universityNmList}}</div>{{/if}}
			
		</div>
	</div>
	{{/if}}
{{/if}}
</script>

<script id="specialPurchaseListTmpl" type="text/x-jquery-tmpl">
<div class="special_purchase_content mb15" data-no=\${mentorHipId}>
	{{if numberPages > 0}}<p class="numberPages txt_13 fw_500">총 \${numberPages}장</p>{{/if}}
	<p class="university txt_141 fw_500">\${universityNm} \${mentorMajorName} | \${mentorStudentId}학번</p>
	<p class="acceptance txt_141 fw_500">\${acceptance}, \${areaSchoolNm}</p>
	{{if admissionCnt > 0}}<p class="admission">총 \${admissionCnt}개 수시 합격</p>{{/if}}
	<p class="reward txt_141">{{if numberAward > 0}}수상내역: \${numberAward}개{{/if}} {{if serviceTimes > 0}}봉사활동: \${serviceTimes}시간{{/if}}</p>
</div> 
</script>

<script id="searchNoPurchaseDataTmpl" type="text/x-jquery-tmpl">
    <li id="mentoListNoData"><div>\${noDataMsg}</div></li>
</script>
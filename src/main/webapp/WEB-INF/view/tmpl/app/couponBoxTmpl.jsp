<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="useCouponListTmpl" type="text/x-jquery-tmpl">
<div class="list new" name="list" onClick="popupOpenFn(\${inventoryNo},this);">
	<div class="f_left" name="f_left">
		<p>\${itemMsg}&nbsp;(\${itemAmt}개)</p>
		<b>즉시 사용이 가능합니다!</b>
		<span class="date">\${regDt} ~ \${expireDt}</span>
	</div>
	<div class="f_right">
		<span class="ico_new" name="new"></span>
		<strong>사용<br/>가능</strong>
	</div>
</div>
</script>

<script id="endCouponListTmpl" type="text/x-jquery-tmpl">
<div class="list">
	<div class="f_left">
		<p>\${itemMsg}이 사용 되었습니다!</p>
		<b>발급된 쿠폰을 사용하셨습니다!</b>
		<span class="date">\${expireDt}</span>
	</div>
	<div class="f_right">
		<strong>사용<br/>완료</strong>
	</div>
</div>
</script>
<script id="useGoodsListTmpl" type="text/x-jquery-tmpl">
<li data-no=\${couponImgUrl}>
	<div class="goodsUse_box">
		<img src=\${couponImgUrl} class="mmsBrandThumImg">
		<div class="goodsNm">
			<span class="brandNm">\${brandNm}</span>
			<span class="goodsName" data-no=\${goodsCd}>\${goodsNm}</span>
		</div>
		<div class="price_box">
			<img src="${pageContext.request.contextPath}/apps/images/ico_01.png">
			<p class="sellPriceAmt">\${sellPriceAmt}</p>
		</div>	
	</div>
</li>
</script>

<script id="endGoodsListTmpl" type="text/x-jquery-tmpl">
<li data-no=\${couponImgUrl}>
	<div class="goodsEnd_box">
		<img src=\${couponImgUrl} class="mmsBrandThumImg">
		<div class="goodsNm">
			<span class="brandNm">\${brandNm}</span>
			<span class="goodsName" data-no=\${goodsCd}>\${goodsNm}</span>
		</div>
		<div class="price_box" >
			<img src="${pageContext.request.contextPath}/apps/images/ico_01.png">
				<p class="sellPriceAmt txt_13">\${sellPriceAmt}</p>
			</div>	
		</div>
</li>
</script>

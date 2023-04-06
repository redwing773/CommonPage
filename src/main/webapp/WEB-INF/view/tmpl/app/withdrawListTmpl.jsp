<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="withdrawListTmpl" type="text/x-jquery-tmpl">
    <ul class="list_style_01">
        <li>
            <a href="${pageContext.request.contextPath}/\${pathType}/withdraw/detail?payingSeq=\${payingSeq}">
                <span class="date">\${creDt}</span>
                {{if applyStatus == "APPLY"}}
                    <span class="badge_02">\${applyStatusNm}</span>
                {{else}}
                    <span class="badge_01">\${applyStatusNm}</span>
                {{/if}}
                <span class="price">\${applyAmt}</span>
            </a>
        </li>
    </ul>
</script>

<script id="noWithdrawListTmpl" type="text/x-jquery-tmpl">
    <ul class="no_list_01">출금 내역이 없습니다.</ul>
</script>

<script id="withdrawListTy2Tmpl" type="text/x-jquery-tmpl">
    <tr>
        <a href="${pageContext.request.contextPath}/\${pathType}/withdraw/detail?payingSeq=\${payingSeq}">
            <th>\${creDt}</th>

            <td>
            {{if applyStatus == "APPLY"}}
                <span class="apply">\${applyStatusNm}</span>
            {{else}}
                <span class="complete">\${applyStatusNm}</span>
            {{/if}}
            </td>
            <%-- 입급 취소 case는 cancel클래스 사용--%>

            <td>\${applyAmt}</td>
        </a>
    </tr>
</script>

<script id="noWithdrawListTy2Tmpl" type="text/x-jquery-tmpl">
    <tr>
        <td colspan="2">
            <div class="no_list_01">출금 내역이 없습니다.</div>
        </td>
    </tr>
</script>

<script id="withdrawInfoTmpl" type="text/x-jquery-tmpl">
	<div class="txt_13">
		* 출금 요청은 \${applyMinAmt}원부터 \${possibleAmtUnit}원 단위로 \${applyLimitPeriodNm} 1회 가능합니다.<br/>
		<span class="c_red">* 월~일요일까지 출금 신청 건</span>은 <span class="c_red">다음 주 \${depositStandWeekNm}요일</span>에 지급합니다.<br/>
		* 출금 시 이체 수수료가 발생하며, 이를 제외한 금액이 입금됩니다. 
	</div>
</script>
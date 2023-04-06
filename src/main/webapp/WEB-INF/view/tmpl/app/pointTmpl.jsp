<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="selectOption" type="text/x-jquery-tmpl">
    <option value="\${point_amt}" data-id="\${shop_item_id}" data-point="\${point_amt}" data-nm="\${item_name}" data-deduct="\${deduct_list[0].deduct_no}"> \${amt_txt}  원</option>
</script>

<script id="pointListTmpl" type="text/x-jquery-tmpl">
    <li>
        {{if purchase_type== 1}} <%-- 충전 --%>
            <p class="name"> \${item_name}</p>
            <p class="date"><span class="c_mint">충전</span> \${purchase_dt}</p>
            <p class="point">+ \${purchase_amount}</p>
        {{else}} <%-- 사용 --%>
            <p class="name"> \${item_name} (\${item_type_nm})</p>
            <p class="date"><span class="c_red">사용</span>

             {{if purchase_status == "purchase"}} <%-- 구매완료 --%>
                \${purchase_dt}
             {{else}} <%-- 구매취소 --%>
                \${purchase_cancel_dt}
             {{/if}}

             </p>

             {{if item_type == "99"}} <%-- 정산타입은 + 표시(멘토사용) --%>
                <p class="point">+ \${purchase_amount}</p>
             {{else}}
                <p class="point">- \${purchase_amount}</p>
             {{/if}}

		{{/if}}
    </li>
</script>

<script id="pointListTy2Tmpl" type="text/x-jquery-tmpl">
{{if purchase_status == "purchase"}}
	 <div class="list">
        {{if purchase_type== 1}} <%-- 충전 --%>
            <div class="f_left">
                <p>\${item_name} (\${item_type_nm})</p>
                <span class="status refill">충전</span>
                <span class="date">\${purchase_dt}</span>
            </div>
            <div class="f_right">
                <strong class="point">+\${purchase_amount}</strong>
            </div>
        {{else}} <%-- 사용 --%>
            <div class="f_left">
                <p>\${item_name} (\${item_type_nm})</p>
                <span class="status use">사용</span>
                {{if purchase_status == "purchase"}}
                    <span class="date">\${purchase_dt}</span>
                {{else}} <%-- 구매취소 --%>
                    <span class="date">\${purchase_cancel_dt}</span>
                {{/if}}
            </div>
            <div class="f_right">
                {{if item_type == "99"}} <%-- 정산타입은 + 표시(멘토사용) --%>
                    <strong class="point">+ \${purchase_amount}</strong>
                 {{else}}
                    <strong class="point">- \${purchase_amount}</strong>
                 {{/if}}
            </div>
        {{/if}}
    </div>
{{/if}}
</script>

<script id="itemListTmpl" type="text/x-jquery-tmpl">
    <li>
        <a href="#self" data-id="\${shop_item_id}">
            <span class="point_box">
                <span class="name">충전포인트</span>
                <span class="point">\${point_amt} P</span>
            </span>
            <span class="price_box">
                <span class="price">\${amt_txt} 원</span>
                <span class="btn_25">결제하기</span>
            </span>
        </a>
    </li>
</script>

<script id="itemListTmpl2" type="text/x-jquery-tmpl">
    <li>
        <a href="#self" data-id="\${shop_item_id}">
            <span class="point_box">
                <span class="name" style="margin-left:100px;">충전포인트</span>
                <span class="point" style="margin-left:100px;">\${point_amt} P</span>
            </span>
            <span class="price_box">
                <span class="price" style="margin-left:250px;">\${amt_txt} 원</span>
                <span class="btn_25" style="margin-left:250px;">결제하기</span>
            </span>
        </a>
    </li>
</script>
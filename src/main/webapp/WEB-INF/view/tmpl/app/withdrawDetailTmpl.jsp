<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="withdrawDetailTmpl" type="text/x-jquery-tmpl">
    {{if applyStatus == "APPLY"}}
        <div class="border_box_01 mb20">
            <div class="both_area mb10">
                <div class="fl_l">
                    <p class="txt_14">출금 신청일</p>
                </div>
                <div class="fl_r">
                    <p class="c_black">\${creDt}</p>
                </div>
            </div>
            <div class="line_02 mb20"></div>
            <div class="both_area mb10">
                <div class="fl_l">
                    <p class="txt_14">출금 금액</p>
                </div>
                <div class="fl_r">
                    <p class="c_black"><strong>\${applyAmt} 원</strong></p>
                </div>
            </div>
            <div class="both_area">
                <div class="fl_l">
                    <p class="txt_14">발생 수수료</p>
                </div>
                <div class="fl_r">
                    <p class="c_black"><strong>- \${chargeAmt} 원</strong></p>
                </div>
            </div>
        </div>
        <div class="gray_box pt15 mb20">
            <div class="both_area mb5 lh30">
                <div class="fl_l">
                    <p class="txt_14 c_black">입금 예정 금액</p>
                </div>
                <div class="fl_r">
                    <p class="txt_20 c_blue"><strong>\${totalAmt} 원</strong></p>
                </div>
            </div>
        </div>
        <div class="gray_box pt15 mb100">
            <div class="both_area mb5 lh30">
                <div class="fl_l">
                    <p class="txt_14 c_black">예금주명</p>
                </div>
                <div class="fl_r">
                    <p class="txt_20 c_blue"><strong>\${accountNm}</strong></p>
                </div>
            </div>
            <div class="both_area mb5 lh30">
                <div class="fl_l">
                    <p class="txt_14 c_black">은행명</p>
                </div>
                <div class="fl_r">
                    <p class="txt_20 c_blue"><strong>\${bankCdNm}</strong></p>
                </div>
            </div>
            <div class="both_area mb5 lh30">
                <div class="fl_l">
                    <p class="txt_14 c_black">계좌번호</p>
                </div>
                <div class="fl_r">
                    <p class="txt_20 c_blue"><strong>\${accountNumber}</strong></p>
                </div>
            </div>
        </div>
    {{else (applyStatus == "FINISHED")}}
        <div class="border_box_01 mb20">
            <div class="both_area mb10">
                <div class="fl_l">
                    <p class="txt_14">출금일</p>
                </div>
                <div class="fl_r">
                    <p class="c_black">\${payingoutDt}</p>
                </div>
            </div>
            <div class="both_area mb20">
                <div class="fl_l">
                    <p class="txt_14">출금신청일</p>
                </div>
                <div class="fl_r">
                    <p class="c_black">\${creDt}</p>
                </div>
            </div>
            <div class="line_02 mb20"></div>
            <div class="both_area mb10">
                <div class="fl_l">
                    <p class="txt_14">출금 금액</p>
                </div>
                <div class="fl_r">
                    <p class="c_black"><strong>\${applyAmt} 원</strong></p>
                </div>
            </div>
            <div class="both_area">
                <div class="fl_l">
                    <p class="txt_14">발생 수수료</p>
                </div>
                <div class="fl_r">
                    <p class="c_black"><strong>- \${chargeAmt} 원</strong></p>
                </div>
            </div>
        </div>
        <div class="gray_box pt15 mb20">
            <div class="both_area mb5 lh30">
                <div class="fl_l">
                    <p class="txt_14 c_black">최종 출금 금액</p>
                </div>
                <div class="fl_r">
                    <p class="txt_20 c_blue"><strong>\${totalAmt} 원</strong></p>
                </div>
            </div>
        </div>
        <div class="gray_box pt15 mb100">
            <div class="both_area mb5 lh30">
                <div class="fl_l">
                    <p class="txt_14 c_black">예금주명</p>
                </div>
                <div class="fl_r">
                    <p class="txt_20 c_blue"><strong>\${accountNm}</strong></p>
                </div>
            </div>
            <div class="both_area mb5 lh30">
                <div class="fl_l">
                    <p class="txt_14 c_black">은행명</p>
                </div>
                <div class="fl_r">
                    <p class="txt_20 c_blue"><strong>\${bankCdNm}</strong></p>
                </div>
            </div>
            <div class="both_area mb5 lh30">
                <div class="fl_l">
                    <p class="txt_14 c_black">계좌번호</p>
                </div>
                <div class="fl_r">
                    <p class="txt_20 c_blue"><strong>\${accountNumber}</strong></p>
                </div>
            </div>
        </div>
    {{else (applyStatus == "CANCEL")}}
        <div class="border_box_01 mb20">
            <div class="both_area mb10">
                <div class="fl_l">
                    <p class="txt_14">출금취소일</p>
                </div>
                <div class="fl_r">
                    <p class="c_black">\${calcelDt}</p>
                </div>
            </div>
            <div class="both_area mb20">
                <div class="fl_l">
                    <p class="txt_14">출금신청일</p>
                </div>
                <div class="fl_r">
                    <p class="c_black">\${creDt}</p>
                </div>
            </div>
            <div class="line_02 mb20"></div>
            <div class="both_area mb10">
                <div class="fl_l">
                    <p class="txt_14">취소사유</p>
                </div>
                <div class="fl_r">
                    <p class="c_black"><strong>\${calcelReason}</strong></p>
                </div>
            </div>
        </div>
    {{/if}}
</script>
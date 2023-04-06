<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<div class="layer-popup hide" id="error_popup">
    <div class="common-error-wrap">
        <div class="common-error-box">
            <img src="/resources/images/portalTok/icon_emoji_error_temporary.png" alt="" class="emoji error-temporary" />
            <p class="title">일시적인 오류가 발생했습니다.</p>
            <p class="desc">서비스 이용에 불편을 드려 매우 죄송합니다.</p>
        </div>
        <button type="button" class="btn-close-x popup-close">X</button>
    </div>
    <button type="button" class="btn-close popup-close">닫기</button>
</div>

<div class="layer-popup hide" id="inspection_popup">
    <div class="common-error-wrap">
        <div class="common-error-box">
            <img src="/resources/images/portalTok/icon_emoji_error_check.png" alt="" class="emoji error-check" />
            <p class="title">현재 점검 중입니다.</p>
            <p class="desc">안정적인 서비스를 위해 점검을 진행하고 있습니다.</p>
            <div class="notice-box">
                <p class="notice" id="inspection_message"></p>
            </div>
        </div>
        <button type="button" class="btn-close-x popup-close">X</button>
    </div>
    <button type="button" class="btn-close popup-close">닫기</button>
</div>
<%@tag pageEncoding="UTF-8" %>
<script id="popAlert" type="text/x-jquery-tmpl">
    <div class="\${popupClass} open pop_alert">
        <div class="outter_box">
            <div class="inner_box">
                <h2 class="title">{{html message}}</h2>
                <div class="btn_box">
                    <a href="javascript:void(0);" class="btn_40" style="width:100%;" onclick="Layer_CLOSE('.pop_alert')">확인</a>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="popConfirm" type="text/x-jquery-tmpl">
    <div class="popup_out">
        <div class="outter_box">
            <div class="inner_box">
                <h2 class="title">{{html message}}</h2>
                <div class="btn_box">
                    <a href="javascript:void(0);" class="btn_45 gray" style="width:127px;"><span class="txt_14">확인</span></a>
                    <a href="javascript:void(0);" class="btn_45" style="width:128px;" onclick="Layer_CLOSE('.popup_out')"><span class="txt_14">취소</span></a>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="popConfirm2" type="text/x-jquery-tmpl">
    <div class="popup_out">
        <div class="outter_box">
            <div class="inner_box">
                <p class="title" style="text-align:center;font-size:13px;">{{html message}}</p>
                <div class="btn_box">
 					<a href="javascript:void(0);" class="btn_45 gray" style="width:128px; background-color:\${bgColor};" onclick="Layer_CLOSE('.popup_out')"><span class="txt_14">\${btnNm}</span></a>
					<a href="javascript:void(0);" class="btn_45 confirm" style="width:127px; background-color:\${bgColor2};"><span class="txt_14">\${btnNm2}</span></a>
				</div>
            </div>
        </div>
    </div>
</script>

<script id="popConfirm3" type="text/x-jquery-tmpl">
    <div class="popup_out">
        <div class="outter_box">
            <div class="inner_box">
                <h2 class="title" style="width:77%;letter-spacing:-0.4px;">{{html message}}</h2>
                <div class="btn_box">
                    <a href="javascript:void(0);" class="btn_45 gray" style="width:127px;" onclick="Layer_CLOSE('.popup_out')"><span class="txt_13">취소</span></a>
                    <a href="javascript:void(0);" class="btn_45 yes" style="width:128px;"><span class="txt_13">확인</span></a>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="popConfirm4" type="text/x-jquery-tmpl">
    <div class="popup_out">
        <div class="outter_box">
            <div class="inner_box">
                <h2 class="title" style="width:77%;letter-spacing:-0.4px;">{{html message}}</h2>
                <div class="btn_box">
                    <a href="javascript:void(0);" class="btn_45 gray no" style="width:127px;"><span class="txt_13">취소</span></a>
                    <a href="javascript:void(0);" class="btn_45 yes" style="width:128px;"><span class="txt_13">확인</span></a>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="popConfirmNew" type="text/x-jquery-tmpl">
    <div class="popup_out">
        <div class="outter_box">
            <div class="inner_box" style="text-align: left; width: 324px; padding: 12px 10px 20px 12px; border-radius: 10px;">
                <h2 class="title" style="font-size:20px; font-weight: 500;">{{html title}}</h2>
                <div class="mt20" style="line-height: 1.33;">
                    <span style="font-size: 15px;">{{html contents}}</span><br>
                    <span style="font-size: 13px; color: #666;letter-spacing: -0.56px; display: block; margin-top: 5px; margin-bottom: 44px;">{{html subContents}}</span>
                </div>
                <div class="btn_box" style="width: 100%; position: absolute; left: 0px; bottom: 4px; font-size: 15px; text-align: center;">
	                <a href="javascript:void(0);" class="gray no" style="float:none; line-height: 38px; height: 38px;border: solid 1px #e1e1e1; display: inline-block; border-radius: 8px; width: 154px;">취소</a>
	                <a href="javascript:void(0);" class="btn_40 yes" style="float:none; display: inline-block; border-radius: 8px; width: 154px; font-size: 15px;">{{html btnNm}}</a>
	            </div>
            </div>
        </div>
    </div>
</script>

<script id="popBeforeChat" type="text/x-jquery-tmpl">
    <div class="popBeforeChat">
        <div class="outter_box">
            <div class="inner_box" style="text-align: left; width: 324px; padding: 12px 10px 20px 12px; border-radius: 10px;">
                <h2 class="title" style="font-size:20px; font-weight: 500; width:100%; margin-bottom:0;">{{html title}}</h2>
                <div class="mt20" style="line-height: 1.33;">
                    <span style="font-size: 15px;">{{html contents}}</span><br>
                    <span style="font-size: 13px; color: #666;letter-spacing: -0.56px; display: block; margin-top: 5px; margin-bottom: 44px;">{{html subContents}}</span>
                </div>
                <div class="popBeforeChat_btn_box" style="width: 100%; position: absolute; left: 0px; bottom: 4px; font-size: 15px; text-align: center;">
	                <a href="javascript:void(0);" class="gray no" style="float:none; line-height: 38px; height: 38px;border: solid 1px #e1e1e1; display: inline-block; border-radius: 8px; width: 154px;">취소</a>
	                <a href="javascript:void(0);" class="btn_40 yes" style="float:none; display: inline-block; border-radius: 8px; width: 154px; font-size: 15px;">{{html btnNm}}</a>
	            </div>
            </div>
        </div>
    </div>
</script>

<script id="popCancel" type="text/x-jquery-tmpl">
    <div class="popup_out">
        <div class="outter_box">
            <div class="inner_box">
                <p class="title" style="text-align:center;font-size:13px;">{{html message}}</p>
                <div class="btn_box">
					<a href="javascript:void(0);" class="btn_45" style="width:127px;" onclick="Layer_CLOSE('.popup_out')"><span class="txt_14">취소</span></a>
                	<a href="javascript:void(0);" class="btn_45 gray" style="width:128px; background-color:\${bgColor};"><span class="txt_14">\${btnNm}</span></a>
				</div>
            </div>
        </div>
    </div>
</script>

<script id="popCancel2" type="text/x-jquery-tmpl">
    <div class="popup_out">
        <div class="outter_box">
            <div class="inner_box">
                <p class="title" style="text-align:center;">{{html message}}</p>
                <div class="btn_box">
                	<a href="javascript:void(0);" class="btn_45 gray" style="width:256px; background-color:\${bgColor};"><span class="txt_14">\${btnNm}</span></a>
				</div>
            </div>
        </div>
    </div>
</script>
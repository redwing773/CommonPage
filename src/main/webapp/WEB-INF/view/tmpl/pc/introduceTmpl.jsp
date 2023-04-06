<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="previewTmpl" type="text/x-jquery-tmpl">
    <div class="popup_all" id="privewPhonePop">
        <div class="popup_phone">
            <div class="outter_box">
                <div class="inner_box">
                    <div class="in_box">
                        <div class="title">
                            <p class="name">\${title}</p>
                        </div>
                        <div id="pre_cont" class="phone_cont">
                            <div id="watermark" class="watermark"></div>
                        </div>
                    </div>
                    <button type="button" class="btn_close"><span class="blind">닫기</span></button>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="previewQnATmpl" type="text/x-jquery-tmpl">
    <div class="txt_box">
        <div class="pre">
            <h2 class="no"><span>\${pre_no}</span>번 항목</h2>
            <p class="q">Q. <span>\${pre_question}</span></p>
            <p class="a">A. <span style="white-space:pre-wrap;word-break:break-all;">\${pre_answer}</span></p>
        </div>
    </div>
</script>
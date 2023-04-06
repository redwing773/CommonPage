<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="mainListTmpl" type="text/x-jquery-tmpl">
    <li class="mainList" onclick="Layer_OPEN('.popup_app')">
        <a href="#self">
            <span class="img_box_custom">
                <span class="img"><img src="\${resourceUri}" alt="" /></span>
                <%--<span class="label">Live</span>--%>
            </span>
            <span class="txt_box">
                <span class="time"><strong>\${startDate} - \${endDate}</strong></span>
                <span class="name">\${title}</span>
                <span class="txt_01">\${nickname}</span>
                <span class="txt_02">\${viewNumber}명 참여 중</span>
            </span>
        </a>
    </li>
</script>

<script id="myListTmpl" type="text/x-jquery-tmpl">
    <li>
        <a href="#self">
            <span class="img_box_custom">
                <span class="img"><img src="\${resourceUri}" alt=""></span>
                <%--<span class="label bg_gray">작성 중</span>--%>
            </span>
            <span class="txt_box">
                <span class="name">\${channelTitle}</span>
                <span class="txt_01">\${startDate}</span>
            </span>
            <input type="hidden" class="blind" name="channelKey" value="\${channelKey}"></span>
        </a>
    </li>
</script>

<script id="qnaListTmpl" type="text/x-jquery-tmpl">
    <li class="li_qna" data-no="\${pollNo}">
        <p class="no">Q&A <span class="qna_no"></span> <button type="button" class="btn_del"><span class="blind">삭제</span></button></p>
        <div class="it">
            <input type="text" class="question" name="question" value="\${question}"/>
        </div>
        <div class="radio_box">
            <span class="type"><span>A</span>답변유형</span>
            <span class="ml50">
                <label class="answer_radio mr30"><input type="radio" name="messageType_\${radioKey}" value="TEXT" {{if messageType == 'TEXT'}}checked="checked"{{/if}} onclick="changeTypeText(this);"/><em></em><span>텍스트 직접입력</span></label>
                <label class="answer_radio"><input type="radio" name="messageType_\${radioKey}" value="FILE" {{if messageType == 'FILE'}}checked="checked"{{/if}} onclick="changeTypeFile(this);"/><em></em><span>이미지 업로드</span></label>
            </span>
        </div>
        <div class="answer_box">
            {{if messageType == 'TEXT'}}
                <textarea name="answer" class="answer" cols="" rows="">\${answer}</textarea>
            {{else}}
                <textarea name="answer" class="answer" cols="" rows="" style="display:none"></textarea>
            {{/if}}

            {{if messageType == 'FILE' && answer != ''}}
                <div class="img_box">
            {{else}}
                <div class="img_box" style="display:none">
            {{/if}}

                <a href="#self" class="img">
                    {{if messageType == 'FILE' && answer != ''}}
                        <img src="\${answer}" alt=""/>
                    {{/if}}
                </a>
                <a href="#self" class="btn_delete"></a>
            </div>
            <div class="it_file" style="display:none;">
                <input type="file" name="file1" accept="image/jpg, image/jpeg, image/png"/>
                <span class="ico"></span>
                <span class="txt">이미지 파일을 업로드해주세요.<br/>(파일타입 : JPG, JPEG, PNG | 최대용량 : 2MB)</span>
                <input type="hidden" name="fileUrl" value="\${answer}" />
            </div>
        </div>
    </li>
</script>

<script id="previewTmpl" type="text/x-jquery-tmpl">
    <div class="popup_all" id="privewPhonePop">
        <div class="popup_phone">
            <div class="outter_box">
                <div class="inner_box">
                    <div class="in_box">
                        <div class="title">
                            <p class="name pre_title"></p>
                            <span class="label">질문</span>
                        </div>
                        <div id="pre_cont" class="cont">
                        </div>
                    </div>
                    <button type="button" class="btn_close"/><span class="blind">닫기</span></button>
                </div>
            </div>
        </div>
    </div>
</script>

<script id="previewQnATmpl" type="text/x-jquery-tmpl">
    <div class="txt_box">
        <div class="q">
            <p class="no">\${pre_no}</p>
            <p class="txt">\${pre_question}</p>
        </div>
        <div class="a">
            <div class="profile">
                <div class="fl_r">
                    <%--<span class="label bg_gray">생기부</span>--%>
                    <span class="label bg_blue">멘토</span>
                    <span class="name">\${pre_nickname}</span>
                    <%--<span class="photo"><img class="pre_profile" src="" alt="" /></span>--%>
                </div>
            </div>
            <p class="txt">{{html pre_answer}}</p>
            <p class="time">오전 10:00</p>
        </div>
    </div>
</script>
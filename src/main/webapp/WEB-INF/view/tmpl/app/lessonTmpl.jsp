<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="subjectTmpl" type="text/x-jquery-tmpl">
    <p class="txt_15 op8 mb10" data-no="\${codeNo}">\${codeNm}</p>
    <div class="list_style_03 mb10">
        <ul class="chk_list">
        </ul>
    </div>
</script>

<script id="subjectListTmpl" type="text/x-jquery-tmpl">
    <li><label class="checkbox style_03"><input type="checkbox" name="subject" value="\${codeNo}" /><em></em><span>\${codeNm}</span></label></li>
</script>

<script id="dayListTmpl" type="text/x-jquery-tmpl">
    <li>
        <p class="name" data-nm="\${codeNm}">\${codeNm}요일</p>
        <div class="check_day chk_list">
        </div>
    </li>
</script>

<script id="dayItemTmpl" type="text/x-jquery-tmpl">
    <label class="checkbox style_03"><input type="checkbox" name="day" value="\${codeNo}"/><em></em><span>\${codeValue}</span></label>
</script>

<script id="commonCodeTmpl" type="text/x-jquery-tmpl">
    <option value="\${codeNo}">\${codeNm}</option>
</script>

<script id="addrListTmpl" type="text/x-jquery-tmpl">
    <li><button type="button" data-no=\${areaNo} >\${areaNm}</button></li>
</script>

<script id="addrChoiceItemTmpl" type="text/x-jquery-tmpl">
    <li>\${areaNm}<button type="button" class="btn_del" data-no=\${areaCd}><span class="blind">삭제</span></button></li>
</script>

<script id="addrSelectedItemTmpl" type="text/x-jquery-tmpl">
    <li><div>\${areaNm} <a href="#self" class="btn_del" data-no="\${areaCd}"><span class="blind">삭제</span></a></div></li>
</script>


<script id="careerTmpl" type="text/x-jquery-tmpl">
    <div class="tutor_career_box">
        <div class="date_box">
            <p class="tit pr10" style="text-align:right;"><button type="button" class="btn_del" onclick="btnDeleteCareer(this);"><span style="color:#6e6e6e">삭제</span></button></p>
            <div>
                <p class="name">시작일</p>
                <input type="date" name="startDate" class="it" value="\${startDate}" style="width:145px;"/>
            </div>
            <div>
                <p class="name">종료일</p>
                <input type="date" name="endDate" class="it" value="\${endDate}" style="width:145px;"/>
            </div>
        </div>
        <div class="cont_box">
            <p class="name">과외내용</p>
            <span class="txt_length"><span class="learnCnt">0</span>/100 자</span>
            <textarea name="lessonContent" cols="" rows="" maxlength="100" onkeyup="return tms.checkMaxLength(this, '.cont_box', '.learnCnt', 2000);" placeholder="-과외 대상과 과외 효과 위주로 입력해주세요">\${lessonContent}</textarea>
        </div>
    </div>
</script>
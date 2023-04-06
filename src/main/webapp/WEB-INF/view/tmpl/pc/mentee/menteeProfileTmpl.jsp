<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 멘토 상세팝업 (프로필) -->
<script id="menteePopupProfileTmpl" type="text/x-jquery-tmpl">
    <div class="photo_box">
        <div class="photo"><img src="\${resourceUri}" alt=""></div>
    </div>
    <div class="name_box">
        <span class="name">\${nickname}</span>
        <span class="label">멘티</span>
    </div>
    <ul class="txt_info_01">
        <li>\${schoolNm}</li>
        <li>\${schoolLevel}</li>
    </ul>
    <div class="txt_info_02">\${schoolAddress}</div>
</script>


<!-- 멘토 상세팝업 (과외 과목) -->
<script id="consultSubjectListTmpl" type="text/x-jquery-tmpl">
    <li>
        <label class="checkbox style_01" style="cursor:default;">
            <span class="code_info">\${codeNm}</span>
        </label>
    </li>
</script>
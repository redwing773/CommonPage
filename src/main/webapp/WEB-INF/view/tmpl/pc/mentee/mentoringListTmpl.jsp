<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 멘토 리스트 (멘토링 & 과외) -->
<script id="mentorListTmpl" type="text/x-jquery-tmpl">
    <li>
        <div class="mentorList" data-no=\${hipId}>
            <div class="photo_box">
                {{if resourceUri != null && resourceUri != ""}}
                    <div class="photo" style="background: url(\${resourceUri}) center center no-repeat; background-size:cover"></div>
                {{else}}
                    <div class="photo"></div>
                {{/if}}
                <div class="label">
                    {{if menteeCd == 0}}
                        <span class="blue">학생</span>
                    {{/if}}
                    {{if menteeCd == 1}}
                        <span class="blue">학부모</span>
                    {{/if}}
                </div>
            </div>
            <div class="name">\${nickname} | \${schoolLevel}</div>
            <ul class="txt_info_01">
                <li>\${schoolNm} (\${schoolAddress})</li>
            </ul>
            {{if listType == "MENTORING"}}
                <div class="txt_info_02">\${mentoringList}</div>
            {{else}}
                <div class="txt_info_02">\${subjectList}</div>
            {{/if}}
        </div>
    </li>
</script>


<!-- 멘토링 유형 상세 검색 -->
<script id="mentoringTypeSearchPopupTmpl" type="text/x-jquery-tmpl">
    {{if isChecked}}
        <label class="select_checkbox mb10"><input type="checkbox" name="mentoringCd" value="\${codeNo}" checked="checked"><em></em><span class="style_01">\${codeNm}</span></label>
    {{else}}
        <label class="select_checkbox mb10"><input type="checkbox" name="mentoringCd" value="\${codeNo}"><em></em><span class="style_01">\${codeNm}</span></label>
    {{/if}}

</script>

<!-- 멘티 유형 검색 -->
<script id="menteeTypeSearchPopupTmpl" type="text/x-jquery-tmpl">
    <label class="select_radiobox style_01 mb10"><input type="radio" name="menteeCd" value="" checked="checked"><em></em><span class="style_01">멘티유형 전체</span></label>
    <label class="select_radiobox style_01 mb10"><input type="radio" name="menteeCd" value="0"><em></em><span class="style_01">학생</span></label>
    <label class="select_radiobox style_01 mb10"><input type="radio" name="menteeCd" value="1"><em></em><span class="style_01">학부모</span></label>
</script>

<!-- 조검검색 : 필요학습 과목 -->
<script id="subjectCdListPopupTmpl" type="text/x-jquery-tmpl">
    {{if isChecked}}
        <li><label class="checkbox style_01"><input type="checkbox" name="subjectCd" value="\${codeNo}" checked="checked"><span>\${codeNm}</span></label></li>
    {{else}}
        <li><label class="checkbox style_01"><input type="checkbox" name="subjectCd" value="\${codeNo}"><span>\${codeNm}</span></label></li>
    {{/if}}

</script>


<script id="nickNmSearchTmpl" type="text/x-jquery-tmpl">
    <a href="#self" class="profile_area" data-no=\${hipId}>
        <div class="photo_box">
            {{if resourceUri != ""}}
                <div class="photo"><img src="\${resourceUri}" alt=""></div>
            {{else}}
                <div class="photo"><img src="../../pc/images/sample_profile_01.png" alt=""></div>
            {{/if}}
        </div>
        <div class="name_box">
            <span class="name">\${nickname}</span>
        </div>
        <div class="txt_box">\${schoolNm}</div>
    </a>
</script>


<script id="searchNoDataTmpl" type="text/x-jquery-tmpl">
    <li id="menteeListNoData"><div>조회된 결과가 없습니다.</div></li>
</script>

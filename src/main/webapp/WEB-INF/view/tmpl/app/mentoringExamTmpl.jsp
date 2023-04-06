<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script id="universityTmpl" type="text/x-jquery-tmpl">
<div class="mentoring_box submentring_box">
    <p class="tit pr10" style="text-align:right;"><button type="button" class="btn_del"><span style="color:#6e6e6e">삭제</span></button></p>
    <div class="both_area mb5">
        <div class="search_box_02 fl_l" style="width:100%;">
            <input type="text" name="universityNm" class="it" placeholder="학교검색" autocomplete="off" data-mapping="universityNm"/>
            <a href="#self" class="btn_search"><span class="blind">검색</span></a>
            <div style="max-height:100px; overflow:auto;">
                <ul class="list-group schoolList">
                </ul>
            </div>
        </div>
    </div>
    <div class="both_area mb5">
        <div class="fl_l" style="width:100%;">
            <select name="department" class="select_style_03" style="width:100%;" data-mapping="departmentLineCd">
                <option value="">학과계열 선택</option>
            </select>
        </div>
    </div>
    <input type="text" name="majorNm" class="it_02 mb5" placeholder="학과" data-mapping="majorNm"/>
    <div class="both_area">
        <div class="fl_l">
            <select name="admissionType" class="select_style_03" style="width:150px;" data-mapping="acceptanceType">
                <option value="">합격유형 선택</option>
            </select>
        </div>
        <div class="fl_r">
            <select name="admissionTypeDetail" class="select_style_03" style="width:150px;" data-mapping="acceptanceTypeCd">
                <option value="">합격전형 선택</option>
            </select>
        </div>
    </div>
</div>
</script>

<script id="commonCodeTmpl" type="text/x-jquery-tmpl">
    <option value="\${codeNo}">\${codeNm}</option>
</script>
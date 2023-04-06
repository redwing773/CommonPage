<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="addrListTmpl" type="text/x-jquery-tmpl">
    <li><button type="button" data-no=\${areaNo} >\${areaNm}</button></li>
</script>

<script id="addrChoiceItemTmpl" type="text/x-jquery-tmpl">
    <li class="mb5">\${areaNm}<button type="button" class="btn_del" data-no=\${areaCd}><span class="blind">삭제</span></button></li>
</script>

<script id="btnSearchTmpl" type="text/x-jquery-tmpl">
    <li><button type="button" class="btn_search areaPop"><span>지역 찾기</span></button></li>
</script>

<script id="subjectTmpl" type="text/x-jquery-tmpl">
    <li data-no="\${codeNo}">
        <p class="name">\${codeNm}</p>
        <ul class="chk_list"></ul>
    </li>
</script>

<script id="subjectListTmpl" type="text/x-jquery-tmpl">
    <li><label class="checkbox style_01"><input type="checkbox" name="subject" value="\${codeNo}" /><span>\${codeNm}</span></label></li>
</script>

<script id="dayListTmpl" type="text/x-jquery-tmpl">
    <li>
        <p class="name" data-nm="\${codeNm}">\${codeNm}요일</p>
        <ul class="chk_list">
        </ul>
    </li>
</script>

<script id="dayItemTmpl" type="text/x-jquery-tmpl">
    <li><label class="checkbox style_01"><input type="checkbox" name="day" value="\${codeNo}" /><span>\${codeValue}</span></label></li>
</script>

<script id="commonCodeTmpl" type="text/x-jquery-tmpl">
    <option value="\${codeNo}">\${codeNm}</option>
</script>

<script id="careerTmpl" type="text/x-jquery-tmpl">
    <tr class="careerTr">
        <th class="vt">
            <p class="tit pt15">과외 경력(선택) <button type="button" class="btn_del" onclick="btnDeleteCareer(this);"><span class="blind">삭제</span></button></p>
        </th>
        <td>
            <div class="it_box_01 mb10">
                <div class="it">
                    <input type="text" name="startDate" placeholder="날짜 선택" value="\${startDate}" />
                </div>
                <div class="it">
                    <input type="text" name="endDate" placeholder="날짜 선택" value="\${endDate}" />
                </div>
            </div>
            <div class="textarea_box_01">
                <p class="name">과외내용</p>
                <textarea name="lessonContent" cols="0" rows="0" style="height:92px;" placeholder="과외 대상과 과외 효과 위주로 입력해주세요.">\${lessonContent}</textarea>
                <p class="ta_r txt_13"><span>0</span>/100자</p>
            </div>
        </td>
    </tr>
</script>

<script id="careerAddBtnTmpl" type="text/x-jquery-tmpl">
    <div class="add_box">
        <button type="button" class="btn_36 mb20 btnAddCareer" style="width:182px;">+ 경력 추가</button>
        <p class="txt_13">- 경력이 없는 경우,  입력하지 않고 넘어갈 수 있습니다.</p>
    </div>
</script>


<script id="memtoGuideTmpl" type="text/x-jquery-tmpl">
    <div data-no="1">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/ff95c0be428240619cf2812c1c383861.png" alt="링커" />
        </div>
    </div>

    <div data-no="2">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/93f30deed0384cc9859b5a99080d1262.png" alt="입시정보" />
        </div>
    </div>

    <div data-no="3">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/ddbfa2c50d394df086fe026faa2bad1c.png" alt="멘토링" />
        </div>
    </div>

	<div data-no="4">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/fa95f6141c044c2783bb99fe92a3f34a.png" alt="과외" />
        </div>
    </div>

    <div data-no="5">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/119ad73e4a9445669661676100cb8cab.png" alt="생활기록부" />
        </div>
    </div>
    <div data-no="6">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/7b806fd0b14947efa0aa3262cbf2608d.png" alt="자소서" />
        </div>
    </div>
</script>

<script id="memteeGuideTmpl" type="text/x-jquery-tmpl">
    <div data-no="1">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/ff95c0be428240619cf2812c1c383861.png" alt="링커" />
        </div>
    </div>

    <div data-no="2">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/93f30deed0384cc9859b5a99080d1262.png" alt="입시정보" />
        </div>
    </div>

    <div data-no="3">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/ddbfa2c50d394df086fe026faa2bad1c.png" alt="멘토링" />
        </div>
    </div>

	<div data-no="4">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/fa95f6141c044c2783bb99fe92a3f34a.png" alt="과외" />
        </div>
    </div>

    <div data-no="5">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/1aa96d42fa3c476e9225ac95a9a07350.png" alt="생활기록부" />
        </div>
    </div>

	<div data-no="6">
        <div class="guide_img">
            <img src="https://d9f2e26giax13.cloudfront.net/etc/7c1fc77544af47b8833965183efa1908.png" alt="자소서" />
        </div>
    </div>
</script>

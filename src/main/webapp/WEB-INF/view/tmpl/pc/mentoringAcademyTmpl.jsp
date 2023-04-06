<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="subjectTmpl" type="text/x-jquery-tmpl">
    <li class="li_subject">
        <p class="name" style="display:none;">수강과목</p>
        <div class="it_add">
            <input type="text" name="subjectNm" placeholder="입력" value="\${mainSubject}"/>
            <button type="button" class="btn_remove"></button>
        </div>
    </li>
</script>

<script id="academyTmpl" type="text/x-jquery-tmpl">
    <tr class="tr_academy">
        <th class="vt">
            <p class="tit">출신 학원 정보 <button type="button" class="btn_del"><span class="blind">삭제</span></button></p>
        </th>
        <td class="pt20 pb15">
        <ul class="it_list_02">
            <li>
                <p class="name">학원명</p>
                <div class="it_search">
                    <input type="text" name="academyNm" value="\${academyNm}"/>
                    <input type="text" name="academyPartyNo" value="\${academyPartyNo}" style="display:none;" />
                    <button type="button" class="btn_search"><span class="blind">검색</span></button>
                    <div style="max-height:100px; overflow:auto;">
                        <ul class="list-group academyList">
                        </ul>
                    </div>
                </div>
            </li>
            <li class="add_subject">
                <div class="line_01 mb10"></div>
                <button type="button" class="btn_32 ico_01 btn_subject" style="width:103px;"><span>과목 추가</span></button>
            </li>
            <li>
                <p class="name">재원시기</p>
                <select name="periodCode">
                    <option value="">재원시기</option>
                    <option value="203">초등부</option>
                    <option value="204">중등부</option>
                    <option value="205">고등부</option>
                    <option value="206">N입시</option>
                </select>
            </li>
            <li>
                <p class="name">재원기간</p>
                <div class="both_area">
                    <div class="fl_l">
                        <select name="periodYear" style="width:230px;">
                            <option value="0">년</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select>
                    </div>
                    <div class="fl_r">
                        <select name="periodMonth" style="width:230px;">
                            <option value="0">개월</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                        </select>
                    </div>
                </div>
            </li>
        </ul>
    </td>
    </tr>
</script>
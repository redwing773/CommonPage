<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script id="universityTmpl" type="text/x-jquery-tmpl">
<tr class="tr_admission">
	<th class="vt">
		<p class="tit">대학교 <button type="button" class="btn_del"><span class="blind">삭제</span></button></p>
	</th>
	<td class="pt20 pb15">
		<ul class="it_list_01">
			<li>
				<div class="both_area">
					<div class="fl_l">
						<div class="it_search">
							<input type="text" name="universityNm" style="width:470px;" value="" placeholder="학교검색" autocomplete="off"/>
							<button type="button" class="btn_search"><span class="blind">검색</span></button>
							<div style="max-height:100px; overflow:auto;">
							    <ul class="list-group schoolList">
                                </ul>
                            </div>
						</div>
					</div>
				</div>
			</li>
			<li>
				<div class="both_area">
					<div class="fl_l">
					    <div class="it_search">
							<select name="department" style="width:470px;">
								<option value="" selected>학과계열 선택</option>
							</select>
						</div>
					</div>
				</div>
			</li>
			<li>
				<input name="majorNm" type="text" value="" placeholder="학과"/>
			</li>
			<li>
				<div class="both_area">
					<div class="fl_l">
						<select name="admissionType" style="width:291px;">
							<option value="" selected>합격유형 선택</option>
						</select>
					</div>
					<div class="fl_r">
						<select name="admissionTypeDetail" style="width:291px;">
							<option value="" selected>합격전형 선택</option>
						</select>
					</div>
				</div>
			</li>
		</ul>
	</td>
</tr>
</script>
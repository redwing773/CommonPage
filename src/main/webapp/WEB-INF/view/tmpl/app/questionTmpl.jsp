<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="userInfoTmpl" type="text/x-jquery-tmpl">
	<p class="txt_13">\${nickname}님의 최근 관심사로 멘토를 매칭합니다.</p>
	<p class="txt_13">변경이 필요하면 아래 항목을 조정하세요</p>
</script>

<script id="renewMenteeQuestionMentoringTmpl" type="text/x-jquery-tmpl">
<div class="mentoring_question" id="mentoringArea" style="display:none;">
						<div class="question_university" style="margin-bottom: 24px;">
							<div class="quest_tit" style="display: grid;grid-template-columns: 1fr 1fr;margin-bottom: 12px;">
								<h2 style="font-size: 15px; font-weight: 500;color: #000000;">· 최근 관심대학</h2>
								<p class="btn_univs" style="display: flex;justify-content: flex-end; font-size: 12px;color: #4169e1;">수정할래요? &gt;</p>
							</div>
   							<div class="university_search" style="display:none; margin-bottom: 12px;">
								<input type="text" name="universitySchool" style="width: 100%;height: 30px;font-size: 12px;border-radius: 8px;border: solid 1px #4169e1;padding: 6px 8px;" name="universitySchool" placeholder="관심대학을 입력하세요">
								<button type="button" class="btn_search" style="right: 10px;top: 5px;width: 20px;height: 20px;"><span class="blind">검색</span></button>
								<div style="max-height:100px; overflow:auto;">
									<ul class="list-group" id="universitySchool"></ul>
								</div>
							</div>
							<div class="quest_univs" style="display: grid; grid-template-columns: 1fr 1fr 1fr; grid-gap: 4.5px;">
								<p data-no="1921" style=" display: flex; justify-content: center;border-radius: 14.5px; border: solid 1px #e5e5e5; background-color: #fff; font-size: 11px;font-weight: 500; line-height: 1.55;color: #000000; padding: 6px 25px;">한국과학기</p>
								<p data-no="1922" style=" display: flex; justify-content: center;border-radius: 14.5px; border: solid 1px #e5e5e5; background-color: #fff; font-size: 11px;font-weight: 500; line-height: 1.55;color: #000000; padding: 6px 25px;">한국과학기</p>
								<p data-no="1923" style=" display: flex; justify-content: center;border-radius: 14.5px; border: solid 1px #e5e5e5; background-color: #fff; font-size: 11px;font-weight: 500; line-height: 1.55;color: #000000; padding: 6px 25px;">한국과학기</p>
							</div>
						</div>
						<div class="question_lines">
							<div class="quest_tit" style="display: grid;grid-template-columns: 1fr 1fr;margin-bottom: 12px;">
								<h2 style=" font-size: 15px; font-weight: 500;color: #000000;">· 최근 관심계열</h2>
								<p class="btn_lines" style=" display: flex;justify-content: flex-end; font-size: 12px; color: #4169e1;">수정할래요? &gt;</p>
							</div>
							<div class="line_search" style="display:none;">
								 <div class="search" style="margin-bottom: 12px;">
								 <select name="department" class="select_style_03" style="width:100%;height: 30px;font-size: 12px;border-radius: 8px;border: solid 1px #4169e1;" data-mapping="departmentLineCd">
					                <option value="">계열을 선택하세요.</option>
					            </select>
							</div>
							</div>
							<div class="quest_lines" style="display: grid; grid-template-columns: 1fr 1fr 1fr; grid-gap: 4.5px;">
								<p data-no="1924" style="display: flex;justify-content: center;border-radius: 14.5px;border: solid 1px #e5e5e5;background-color: #fff;font-size: 11px;font-weight: 500;line-height: 1.55;color: #000000;padding: 6px 20px;">인문사회계열</p>
								<p data-no="1925" style="display: flex;justify-content: center;border-radius: 14.5px;border: solid 1px #e5e5e5;background-color: #fff;font-size: 11px;font-weight: 500;line-height: 1.55;color: #000000;padding: 6px 20px;">예체능계열</p>
								<p data-no="1926" style="display: flex;justify-content: center;border-radius: 14.5px;border: solid 1px #e5e5e5;background-color: #fff;font-size: 11px;font-weight: 500;line-height: 1.55;color: #000000;padding: 6px 20px;">교육계열(문과)</p>
							</div>
						</div>
					</div>
</script>

<script id="renewMenteeQuestionPrivateClassTmpl" type="text/x-jquery-tmpl">
<div class="privateClass_question" id="privateClassArea">
<div class="question_subject" style="margin-bottom: 24px;">
	<div class="quest_tit" style="display: grid;grid-template-columns: 1fr 1fr;margin-bottom: 12px;">
		<h2 style="font-size: 15px; font-weight: 500;color: #000000;">· 과외과목</h2>
		<p class="btn_sub" style="display: flex;justify-content: flex-end; font-size: 12px;color: #4169e1;">수정할래요? &gt;</p>
	</div>
		<div class="subject_search" style="display:none; margin-bottom: 12px;">
		<input type="text" style="width: 100%;height: 30px;font-size: 12px;border-radius: 8px;border: solid 1px #4169e1;padding: 6px 8px;" name="universitySchool" placeholder="과외 과목을 선택하세요">
		<button type="button" class="btn_search" style="right: 10px;top: 5px;width: 20px;height: 20px;"><span class="blind">검색</span></button>
		<div style="max-height:100px; overflow:auto;">
			<ul class="list-group" id="subject"></ul>
		</div>
	</div>
	<div class="quest_subject" style="display: grid; grid-template-columns: 1fr 1fr 1fr; grid-gap: 4.5px;">
		<p data-no="1921" style=" display: flex; justify-content: center;border-radius: 14.5px; border: solid 1px #e5e5e5; background-color: #fff; font-size: 11px;font-weight: 500; line-height: 1.55;color: #000000; padding: 6px 20px;">외국어공인인증</p>
		<p data-no="1922" style=" display: flex; justify-content: center;border-radius: 14.5px; border: solid 1px #e5e5e5; background-color: #fff; font-size: 11px;font-weight: 500; line-height: 1.55;color: #000000; padding: 6px 20px;">영어</p>
		<p data-no="1923" style=" display: flex; justify-content: center;border-radius: 14.5px; border: solid 1px #e5e5e5; background-color: #fff; font-size: 11px;font-weight: 500; line-height: 1.55;color: #000000; padding: 6px 20px;">IT/컴퓨터</p>
	</div>
</div>
<div class="question_region">
	<div class="quest_tit" style="display: grid;grid-template-columns: 1fr 1fr;margin-bottom: 12px;">
		<h2 style="font-size: 15px; font-weight: 500;color: #000000;">· 과외지역</h2>
	</div>
	<div class="choice_box" style="display:grid; grid-template-columns:1fr 1fr; grid-gap:12px;">
		<a href="#self" class="btn_type btn_major" style="display:flex; justify-content:center; padding:3px 0px;"><span>시도 전체</span></a>
		<a href="#self" class="btn_type btn_minor" style="display:flex; justify-content:center; padding:3px 0px;"><span>전체</span></a>
	</div>
	<div class="list">
		<ul id="lessonList">
		</ul>
	</div>
</div>
</div>
</script>

<script id="mentorQuestionPrivateClassTmpl" type="text/x-jquery-tmpl">
<div class="question_privateClass" id="privateClassArea" style="display:none;">
	<div style="display:flex; margin-bottom:20.5px;">
		<p class="txt_13" style="margin-right:25px; font-wieght:500; padding:10px 0px;">과목</p>
		<select name="subjectNm" style=" width: 85%;border: solid 1px #4169e1;" data-mapping="subjectCd">
			<option value="">과목 선택</option>
		</select>
	</div>
	<div style="display:flex; magin-bottom:20.5px;">
		<p class="txt_13" style="margin-right:25px; font-wieght:500; padding:10px 0px;">지역</p>
		<div class="choice_box">
			<a href="#self" class="btn_type btn_major"><span>시도 전체</span></a>
			<a href="#self" class="btn_type btn_minor"><span>전체</span></a>
		</div>
	</div>
	<div style="display: flex; margin-bottom: 20.5px;">
		<p class="txt_13" style="margin-right: 21px;">고교유형</p>
		<ul class="txt_13" style="display: flex;">
			<li name="schoolFeature">\${schoolFeature},</li>
			<li name="schoolLevel">\${schoolLevel}</li>
		</ul>
	</div>
	<div class="privateClass_qna">
		<p class="txt_13" style="font-weight:500;">문의내용</p>
		<p class="fl_r" style="font-size:12px; font-wieght:500; color:#cdcdcd;"><span>0</span>/ 200</p>
		<textarea name="question" class="question" maxlength="200" placeholder="자세한 질문 내용을 적어주세요." cols="" rows="7" style=" border-radius: 8px; border: solid 1px #000000;"></textarea>
	</div>
</div>	
</script>


<script id="commonCodeTmpl" type="text/x-jquery-tmpl">
    <option value="\${codeNo}">\${codeNm}</option>
</script>

<script id="myQuestionListTmpl" type="text/x-jquery-tmpl">
<li>
	<div class="awl_myList" data-no="1619">
		<div class="tit mb9">
	    	<h2>우리의 밤은 당신의 낮보다 아름답다</h2>
		</div>
		<div class="profile">
        	<div class="date">2019.06.18.</div>
			<div class="profile_img">
				<img class="awl_img" src="https://d3520qxzbk1an7.cloudfront.net/profile/921_2347a553-df90-478a-85d0-2811be7bfff8.jpg">
			</div>
			<p class="nickname"><span>학생</span>닉네임은여덟글자</p>
			<p class="school">자율고(서울 용산구),고2(특성화)</p>
			<p class="status">구하는 중</p>
		</div>
		<div class="content" style="font-size: 12px;">
	    	<p class="txt_13 mb4">관심대학  :  <span class="txt_13">중앙대,홍익대,서강대</span></p>
	    	<p class="txt_13 mb4">관심계열  :  <span class="txt_13">자연과학계열,의치한계열,교육계열(이과)</span></p>
		</div>
	</div>
</li>
</script>

<script id="menteeQuestionListTmpl" type="text/x-jquery-tmpl">
<li>
	<div class="awl_menteeList" data-no="\${talkNo} data-hipid=\${hipId}">
		<div class="tit mb9">
		    <h2>\${talkTitle}</h2>
		</div>
		<div class="profile">
        	<div class="date">\${regDt}</div>
			{{if resourceUri != ""}}
				<div class="profile_img">
					<img class="awl_img" src="\${resourceUri}">
				</div>
            {{else}}
				<div class="profile_img">
					<img class="awl_img" src="${pageContext.request.contextPath}/apps/images/ico_37.png">
				</div>
			{{/if}}
			<p class="nickname">
				{{if mentorCd == 1}}
					<span>학생</span>
				{{/if}}
				{{if mentorCd == 2}}
					<span>학부모</span>
				{{/if}}
				\${nickname}</p>
			<p class="school">\${feature}, \${schoolLvelNm}</p>
    		{{if statusCd == 2}}
				<p class="status">구하는 중</p>
			{{/if}}
			{{if statusCd == 3}}
				<p class="status">완료</p>
			{{/if}}
		</div>
		{{if consultCd == 3}}
			<div class="content" style="font-size: 12px;">
				<p class="txt_13 mb4">관심대학  :  <span class="txt_13">\${univs}</span></p>
				<p class="txt_13 mb4">관심계열  :  <span class="txt_13">\${lines}</span></p>
			</div>
		{{/if}}
		{{if consultCd == 2}}
			<div class="content" style="font-size: 12px;">
				<p class="txt_13 mb4">관심대학  :  <span class="txt_13">\${univs}</span></p>
				<p class="txt_13 mb4">관심계열  :  <span class="txt_13">\${lines}</span></p>
				<p class="subject txt_13 mb4">과외과목  :  <span class="txt_13">\${subjects}</span></p>
				<p class="subject txt_13 mb4">과외지역  :  <span class="txt_13">\${areas}</span></p>
			</div>
		{{/if}}

	</div>
</li>
</script>

<script id="mentorQuestionListTmpl" type="text/x-jquery-tmpl">
<li>
	<div class="awl_mentorList" data-no=\${talkNo} data-hipid=\${hipId}>
		<div class="tit mb9">
			<h2>\${talkTitle}</h2>
		</div>
		<div class="profile">
			<div class="date">\${regDt}</div>
			{{if resourceUri != ""}}
				<div class="profile_img">
					<img class="awl_img" src="\${resourceUri}">
				</div>
            {{else}}
				<div class="profile_img">
					<img class="awl_img" src="${pageContext.request.contextPath}/apps/images/ico_37.png">
				</div>
			{{/if}}
			<p class="nickname"><span>\${acceptanceLine}</span>\${nickname}</p>
			<p class="school">\${universityNm} \${majorNm} | \${studentId}</p>
			<p class="status">도움 가능</p>
			</div>
			<div class="content">
				<div class="badge">
					<p class="record">생기부</p>
					<p class="private">과외 2건</p>
					<p class="selfInfo">자소서</p>
				</div>
    		<div class="info">
                <p class="txt_13 mb8">출신고교  :  <span class="txt_13">경기 군포시,일반고</span></p>
                <p class="txt_13 mb8">합격유형사례  :  
					<span class="txt_13">
					 {{if fixed > 0}}
                                            정시 \${fixed}건
                     {{/if}}
                     {{if nonscheduled > 0}}
                                           수시 \${nonscheduled}건
                     {{/if}}
                     {{if paper > 0}}
                       ,서류 \${paper}건
                     {{/if}}
					</span>
				</p>
                <p class="txt_13 subject">과외과목  :  <span class="txt_13">수학,영어,국어,과학,사회</span></p>
    		</div>
		</div>
	</div>
</li>
</script>
<script id="questionNoDataTmpl" type="text/x-jquery-tmpl">
<li>작성된 질문이 없습니다.</li>
</script>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="h1_P_Tmpl" type="text/x-jquery-tmpl">
<div class="box-card-score">
    <div class="card-item">
        <h3 class="text-title-card">국어</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" class="input-box" id="koreanTypeScore1" name="koreanTypeScore1" placeholder="원점수" maxlength="3" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_korean" class="error_txt_empty" style="visibility: hidden;">국어 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">수학</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" class="input-box" id="mathTypeScore1" name="mathTypeScore1" placeholder="원점수" maxlength="3" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_math" class="error_txt_empty" style="visibility: hidden;">수학 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">영어</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" class="input-box" id="englishScore" name="englishScore" class="unit-input" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_english" class="error_txt_empty" style="visibility: hidden;">영어 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">한국사</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" class="input-box" id="historyScore" name="historyScore" class="unit-input" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_history" class="error_txt_empty" style="visibility: hidden;">한국사 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">사회</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled" style="display: none;">
                <select  class="input-box" name="">
                    <option value="사회">사회</option>
                </select>
            </div>
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" id="otherTypeScore1" name="otherTypeScore1" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore1" class="error_txt_empty" style="visibility: hidden;">사회 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">과학</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled" style="display: none;">
                <select  class="input-box" name="">
                    <option value="과학">과학</option>
                </select>
            </div>
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" id="otherTypeScore2" name="otherTypeScore2" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore2" class="error_txt_empty" style="visibility: hidden;">과학 원점수를 입력해주세요.</div>
    </div>
</div>
</script>

<script id="h1_G_Tmpl" type="text/x-jquery-tmpl">
 <div class="box-card-score">
    <div class="card-item">
        <h3 class="text-title-card">국어</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" class="input-box" id="koreanTypeScore1" name="koreanTypeScore1" placeholder="표준점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_korean" class="error_txt_empty" style="visibility: hidden;">국어 표준점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">수학</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" class="input-box" id="mathTypeScore1" name="mathTypeScore1" placeholder="표준점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_math" class="error_txt_empty" style="visibility: hidden;">수학 표준점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">영어</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" class="input-box" id="englishScore" name="englishScore" class="unit-input" placeholder="등급입력" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">등급</span>
            </div>
        </div>
        <div id="error_english" class="error_txt_empty" style="visibility: hidden;">영어 등급을 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">한국사</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" class="input-box" id="historyScore" name="historyScore" class="unit-input" placeholder="등급입력" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">등급</span>
            </div>
        </div>
        <div id="error_history" class="error_txt_empty" style="visibility: hidden;">한국사 등급을 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">사회</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled" style="display: none;">
                <select  class="input-box" name="">
                    <option value="사회">사회</option>
                </select>
            </div>
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" id="otherTypeScore1" name="otherTypeScore1" placeholder="등급입력" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">등급</span>
            </div>
        </div>
        <div id="error_otherTypeScore1" class="error_txt_empty" style="visibility: hidden;">사회 등급을 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">과학</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled" style="display: none;">
                <select  class="input-box" name="">
                    <option value="과학">과학</option>
                </select>
            </div>
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" id="otherTypeScore2" name="otherTypeScore2" placeholder="등급입력" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">등급</span>
            </div>
        </div>
        <div id="error_otherTypeScore2" class="error_txt_empty" style="visibility: hidden;">과학 등급을 입력해주세요.</div>
    </div>
</div>
</script>

<script id="h2_P_Tmpl" type="text/x-jquery-tmpl">
<div class="box-card-score">
    <div class="card-item">
        <h3 class="text-title-card">국어</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width:100%;">
                <input type="text" id="koreanTypeScore1" name="koreanTypeScore1" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_korean" class="error_txt_empty" style="visibility: hidden;">국어 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">수학</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width:100%;">
                <input type="text" class="input-box" id="mathTypeScore1" name="mathTypeScore1" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_math" class="error_txt_empty" style="visibility: hidden;">수학 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">영어</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" id="englishScore" name="englishScore" class="unit-input input-box" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_english" class="error_txt_empty" style="visibility: hidden;">영어 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">한국사</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" id="historyScore" name="historyScore" class="unit-input input-box" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_history" class="error_txt_empty" style="visibility: hidden;">한국사 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">탐구1</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="selectOtherType1">
                    <option value="0">과목선택</option>
                    <option value="생활과윤리">생활과윤리</option>
                    <option value="윤리와사상">윤리와사상</option>
                    <option value="한국지리">한국지리</option>
                    <option value="세계지리">세계지리</option>
                    <option value="동아시아사">동아시아사</option>
                    <option value="세계사">세계사</option>
                    <option value="경제">경제</option>
                    <option value="정치와법">정치와법</option>
                    <option value="사회문화">사회문화</option>
                    <option value="물리학1">물리학I</option>
                    <option value="화학1">화학I</option>
                    <option value="지구과학1">지구과학I</option>
                    <option value="생명과학1">생명과학I</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="otherTypeScore1" name="otherTypeScore1" placeholder="원점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore1" class="error_txt_empty" style="visibility: hidden;">탐구1 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">탐구2</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="selectOtherType2">
                    <option value="0">과목선택</option>
                    <option value="생활과윤리">생활과윤리</option>
                    <option value="윤리와사상">윤리와사상</option>
                    <option value="한국지리">한국지리</option>
                    <option value="세계지리">세계지리</option>
                    <option value="동아시아사">동아시아사</option>
                    <option value="세계사">세계사</option>
                    <option value="경제">경제</option>
                    <option value="정치와법">정치와법</option>
                    <option value="사회문화">사회문화</option>
                    <option value="물리학1">물리학I</option>
                    <option value="화학1">화학I</option>
                    <option value="지구과학1">지구과학I</option>
                    <option value="생명과학1">생명과학I</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="otherTypeScore2" name="otherTypeScore2" placeholder="원점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore2" class="error_txt_empty" style="visibility: hidden;">탐구2 원점수를 입력해주세요.</div>
    </div>
</div>
</script>

<script id="h2_G_Tmpl" type="text/x-jquery-tmpl">
<div class="box-card-score">
    <div class="card-item">
        <h3 class="text-title-card">국어</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width: 100%">
                <input type="text" class="input-box" id="koreanTypeScore1" name="koreanTypeScore1" placeholder="표준점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_korean" class="error_txt_empty" style="visibility: hidden;">국어 표준점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">수학</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width: 100%">
                <input type="text" class="input-box" id="mathTypeScore1" name="mathTypeScore1" placeholder="표준점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_math" class="error_txt_empty" style="visibility: hidden;">수학 표준점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">영어</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" id="englishScore" name="englishScore" class="unit-input input-box" placeholder="등급입력" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">등급</span>
            </div>
        </div>
        <div id="error_english" class="error_txt_empty" style="visibility: hidden;">영어 등급을 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">한국사</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" id="historyScore" name="historyScore" class="unit-input input-box" placeholder="등급입력" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">등급</span>
            </div>
        </div>
        <div id="error_history" class="error_txt_empty" style="visibility: hidden;">한국사 등급을 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">탐구1</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="selectOtherType1">
                    <option value="0">과목선택</option>
                    <option value="생활과윤리">생활과윤리</option>
                    <option value="윤리와사상">윤리와사상</option>
                    <option value="한국지리">한국지리</option>
                    <option value="세계지리">세계지리</option>
                    <option value="동아시아사">동아시아사</option>
                    <option value="세계사">세계사</option>
                    <option value="경제">경제</option>
                    <option value="정치와법">정치와법</option>
                    <option value="사회문화">사회문화</option>
                    <option value="물리학1">물리학I</option>
                    <option value="화학1">화학I</option>
                    <option value="지구과학1">지구과학I</option>
                    <option value="생명과학1">생명과학I</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="otherTypeScore1" name="otherTypeScore1" placeholder="표준점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore1" class="error_txt_empty" style="visibility: hidden;">탐구1 표준점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">탐구2</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="selectOtherType2">
                    <option value="0">과목선택</option>
                    <option value="생활과윤리">생활과윤리</option>
                    <option value="윤리와사상">윤리와사상</option>
                    <option value="한국지리">한국지리</option>
                    <option value="세계지리">세계지리</option>
                    <option value="동아시아사">동아시아사</option>
                    <option value="세계사">세계사</option>
                    <option value="경제">경제</option>
                    <option value="정치와법">정치와법</option>
                    <option value="사회문화">사회문화</option>
                    <option value="물리학1">물리학I</option>
                    <option value="화학1">화학I</option>
                    <option value="지구과학1">지구과학I</option>
                    <option value="생명과학1">생명과학I</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="otherTypeScore2" name="otherTypeScore2" placeholder="표준점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore2" class="error_txt_empty" style="visibility: hidden;">탐구2 표준점수를 입력해주세요.</div>
    </div>
</div>
</script>

<script id="h3_P_Tmpl" type="text/x-jquery-tmpl">
<div class="box-card-score">
    <div class="card-item" style="height: 162px;">
        <h3 class="text-title-card">한국사</h3>
        <div class="wrap-score-item" style="margin-top: 38px;">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" id="historyScore" name="historyScore" class="unit-input input-box" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_history" class="error_txt_empty" style="visibility: hidden;">한국사 원점수를 입력해주세요.</div>
    </div>
    <div class="card-item" style="height: 162px;">
        <h3 class="text-title-card">국어</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" class="input-box" id="koreanTypeScore1" name="koreanTypeScore1" placeholder="공통점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="koreanSubject">
                    <option value="0">과목선택</option>
                    <option value="화법과작문">화법과작문</option>
                    <option value="언어와매체">언어와매체</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="koreanTypeScore2" name="koreanTypeScore2" placeholder="선택점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_korean" class="error_txt_empty" style="visibility: hidden;">국어 점수를 입력해주세요.</div>
    </div>
    <div class="card-item" style="height: 162px;">
        <h3 class="text-title-card">수학</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="box-input-sufix is-disabled" style="width: 100%;">
                <input type="text" class="input-box" id="mathTypeScore1" name="mathTypeScore1" placeholder="공통점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled"><select  class="input-box" id="mathSubject">
                <option value="0">과목선택</option>
                <option value="확률과통계">확률과통계</option>
                <option value="미적분">미적분</option>
                <option value="기하">기하</option>
            </select></div>
            <div class="box-input-sufix disabled">
                <input type="text" id="mathTypeScore2" name="mathTypeScore2" placeholder="선택점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_math" class="error_txt_empty" style="visibility: hidden;">수학 점수를 입력해주세요.</div>
    </div>
    <div class="card-item" style="height: 162px;">
        <h3 class="text-title-card">영어</h3>
        <div class="wrap-score-item" style="margin-top: 38px;">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" id="englishScore" name="englishScore" class="unit-input input-box" placeholder="원점수" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_english" class="error_txt_empty" style="visibility: hidden;">영어 점수를 입력해주세요.</div>
    </div>
    <div class="card-item" style="height: 162px;">
        <h3 class="text-title-card">탐구1</h3>
        <div class="wrap-score-item wrap-score-title" style="margin-top: 38px;">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="selectOtherType1">
                    <option value="0">과목선택</option>
                    <option value="생활과윤리">생활과윤리</option>
                    <option value="윤리와사상">윤리와사상</option>
                    <option value="한국지리">한국지리</option>
                    <option value="세계지리">세계지리</option>
                    <option value="동아시아사">동아시아사</option>
                    <option value="세계사">세계사</option>
                    <option value="경제">경제</option>
                    <option value="정치와법">정치와법</option>
                    <option value="사회문화">사회문화</option>
                    <option value="물리학1">물리학I</option>
                    <option value="물리학2">물리학II</option>
                    <option value="화학1">화학I</option>
                    <option value="화학2">화학II</option>
                    <option value="지구과학1">지구과학I</option>
                    <option value="지구과학2">지구과학II</option>
                    <option value="생명과학1">생명과학I</option>
                    <option value="생명과학2">생명과학II</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="otherTypeScore1" name="otherTypeScore1" placeholder="원점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore1" class="error_txt_empty" style="visibility: hidden;">탐구1 점수를 입력해주세요.</div>
    </div>
    <div class="card-item" style="height: 162px;">
        <h3 class="text-title-card">탐구2</h3>
        <div class="wrap-score-item wrap-score-title" style="margin-top: 38px;">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="selectOtherType2">
                    <option value="0">과목선택</option>
                    <option value="생활과윤리">생활과윤리</option>
                    <option value="윤리와사상">윤리와사상</option>
                    <option value="한국지리">한국지리</option>
                    <option value="세계지리">세계지리</option>
                    <option value="동아시아사">동아시아사</option>
                    <option value="세계사">세계사</option>
                    <option value="경제">경제</option>
                    <option value="정치와법">정치와법</option>
                    <option value="사회문화">사회문화</option>
                    <option value="물리학1">물리학I</option>
                    <option value="물리학2">물리학II</option>
                    <option value="화학1">화학I</option>
                    <option value="화학2">화학II</option>
                    <option value="지구과학1">지구과학I</option>
                    <option value="지구과학2">지구과학II</option>
                    <option value="생명과학1">생명과학I</option>
                    <option value="생명과학2">생명과학II</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="otherTypeScore2" name="otherTypeScore2" placeholder="원점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore2" class="error_txt_empty" style="visibility: hidden;">탐구2 점수를 입력해주세요.</div>
    </div>
    <div class="card-item" style="height: 20px;">
        <h3 class="text-title-card" style="position: relative;width: 100%;">
            제2외국어
            <span style="display: inline-block; font-weight: 500; color: #9a9a9a; position: absolute;right: 0;">
        <label class="checkbox"><input type="checkbox" class="input-box" id="SLScoreYn" value="1"><em style="transform: translate(3px, 0);"></em><span>응시</span></label>
    </span>
        </h3>
        <div class="wrap-score-item" style="margin-top: 38px; display:none;">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="secondLanguageSubject">
                    <option value="0">과목 선택</option>
                    <option value="독일어1">독일어I</option>
                    <option value="프랑스어1">프랑스어I</option>
                    <option value="스페인어1">스페인어I</option>
                    <option value="중국어1">중국어I</option>
                    <option value="일본어1">일본어I</option>
                    <option value="러시아어1">러시아어I</option>
                    <option value="베트남어1">베트남어I</option>
                    <option value="아랍어1">아랍어I</option>
                    <option value="한문1">한문I</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="SLScore" name="SLScore" class="unit-input input-box" placeholder="원점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_SLScore" class="error_txt_empty" style="visibility: hidden;">제2외국어 점수를 입력해주세요.</div>
    </div>
</div>
</script>

<script id="h3_G_Tmpl" type="text/x-jquery-tmpl">
<div class="box-card-score">
    <div class="card-item">
        <h3 class="text-title-card">한국사</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" id="historyScore" name="historyScore" class="unit-input input-box" placeholder="등급입력" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">등급</span>
            </div>
        </div>
        <div id="error_history" class="error_txt_empty" style="visibility: hidden;">한국사 등급을 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">국어</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="koreanSubject">
                    <option value="0">과목선택</option>
                    <option value="화법과작문">화법과작문</option>
                    <option value="언어와매체">언어와매체</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="koreanTypeScore2" name="koreanTypeScore2" placeholder="표준점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_korean" class="error_txt_empty" style="visibility: hidden;">국어 표준점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">수학</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled"><select  class="input-box" id="mathSubject">
                <option value="0">과목선택</option>
                <option value="확률과통계">확률과통계</option>
                <option value="미적분">미적분</option>
                <option value="기하">기하</option>
            </select></div>
            <div class="box-input-sufix disabled">
                <input type="text" id="mathTypeScore2" name="mathTypeScore2" placeholder="표준점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_math" class="error_txt_empty" style="visibility: hidden;">수학 표준점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">영어</h3>
        <div class="wrap-score-item">
            <div class="box-input-sufix is-disabled single-score">
                <input type="text" id="englishScore" name="englishScore" class="unit-input input-box" placeholder="등급입력" pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">등급</span>
            </div>
        </div>
        <div id="error_english" class="error_txt_empty" style="visibility: hidden;">영어 등급을 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">탐구1</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="selectOtherType1">
                    <option value="0">과목선택</option>
                    <option value="생활과윤리">생활과윤리</option>
                    <option value="윤리와사상">윤리와사상</option>
                    <option value="한국지리">한국지리</option>
                    <option value="세계지리">세계지리</option>
                    <option value="동아시아사">동아시아사</option>
                    <option value="세계사">세계사</option>
                    <option value="경제">경제</option>
                    <option value="정치와법">정치와법</option>
                    <option value="사회문화">사회문화</option>
                    <option value="물리학1">물리학I</option>
                    <option value="물리학2">물리학II</option>
                    <option value="화학1">화학I</option>
                    <option value="화학2">화학II</option>
                    <option value="지구과학1">지구과학I</option>
                    <option value="지구과학2">지구과학II</option>
                    <option value="생명과학1">생명과학I</option>
                    <option value="생명과학2">생명과학II</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="otherTypeScore1" name="otherTypeScore1" placeholder="표준점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore1" class="error_txt_empty" style="visibility: hidden;">탐구1 표준점수를 입력해주세요.</div>
    </div>
    <div class="card-item">
        <h3 class="text-title-card">탐구2</h3>
        <div class="wrap-score-item wrap-score-title">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="selectOtherType2">
                    <option value="0">과목선택</option>
                    <option value="생활과윤리">생활과윤리</option>
                    <option value="윤리와사상">윤리와사상</option>
                    <option value="한국지리">한국지리</option>
                    <option value="세계지리">세계지리</option>
                    <option value="동아시아사">동아시아사</option>
                    <option value="세계사">세계사</option>
                    <option value="경제">경제</option>
                    <option value="정치와법">정치와법</option>
                    <option value="사회문화">사회문화</option>
                    <option value="물리학1">물리학I</option>
                    <option value="물리학2">물리학II</option>
                    <option value="화학1">화학I</option>
                    <option value="화학2">화학II</option>
                    <option value="지구과학1">지구과학I</option>
                    <option value="지구과학2">지구과학II</option>
                    <option value="생명과학1">생명과학I</option>
                    <option value="생명과학2">생명과학II</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="otherTypeScore2" name="otherTypeScore2" placeholder="표준점수" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">점</span>
            </div>
        </div>
        <div id="error_otherTypeScore2" class="error_txt_empty" style="visibility: hidden;">탐구2 표준점수를 입력해주세요.</div>
    </div>
    <div class="card-item" style="height:20px;">
        <h3 class="text-title-card" style="position: relative;width: 100%;">
            제2외국어
            <span style="display: inline-block; font-weight: 500; color: #9a9a9a; position: absolute;right: 0;">
        <label class="checkbox"><input type="checkbox" class="input-box" id="SLScoreYn" value="1"><em style="transform: translate(3px, 0);"></em><span>응시</span></label>
    </span>
        </h3>
        <div class="wrap-score-item" style="display: none;">
            <div class="wrap-option is-disabled">
                <select  class="input-box" id="secondLanguageSubject">
                    <option value="0">과목 선택</option>
                    <option value="독일어I">독일어I</option>
                    <option value="프랑스어I">프랑스어I</option>
                    <option value="스페인어I">스페인어I</option>
                    <option value="중국어I">중국어I</option>
                    <option value="일본어I">일본어I</option>
                    <option value="러시아어I">러시아어I</option>
                    <option value="베트남어I">베트남어I</option>
                    <option value="아랍어I">아랍어I</option>
                    <option value="한문I">한문I</option>
                </select>
            </div>
            <div class="box-input-sufix disabled">
                <input type="text" id="SLScore" name="SLScore" class="unit-input input-box" placeholder="등급입력" disabled pattern="[0-9]*" inputmode="numeric" />
                <span class="text-sufix">등급</span>
            </div>
        </div>
        <div id="error_SLScore" class="error_txt_empty" style="visibility: hidden;">제2외국어 등급을 입력해주세요.</div>
    </div>
</div>
</script>
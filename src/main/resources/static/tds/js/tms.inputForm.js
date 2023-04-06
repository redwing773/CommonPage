/*
* 해당 js는 javascript util 모음 입니다.
* 목록
* 1. isEmpty: 공백 체크
* 2. isNotEmpty: 비어있지 않음 체크
* 3. LPad: 자리수 채워지지 않았을 경우 특정문자로 자리수 채우기(왼쪽)
* 3. RPad: 자리수 채워지지 않았을 경우 특정문자로 자리수 채우기(오른쪽)
* 4. setComma: 세자리수마다 콤마(,)표시
* 5. removeComma: 문자열 콤마(,)삭제
* 6 currentDate: 현재 날짜 가져오기
*
*
* ****jquery 필수 *****
* initInputTxt: input box초기화
* checkboxControl
* checkboxAllControl
* 8. ajaxPostHelper: ajax post방식 호출
* 9. ajaxGetHelper: ajax get방식 호출
*
* */
var tmsInput = (function ($, win, doc) {

    /*
    * 각 요소에 id, name값 필수
    * 원하는 필드명으로 mapping시 data-mapping 속성 추가
    * ex) data-mapping="comp_nm"
    * */
    var detailMapping = function(data, parentNode){
        var obj = $("[data-mapping]");
        if(typeof parentNode !== 'undefined' && parentNode != ""){
            obj = $(parentNode).find("[data-mapping]");
        }

        obj.each(function(key, value){
            var $this = $(this);
            var $value = $(value);

            var objNm = $this.data("mapping");

            if($value.context.tagName.toUpperCase() == "INPUT" || $value.context.tagName.toUpperCase() == "TEXTAREA" || $value.context.tagName.toUpperCase() == "SELECT"){
                if($value.context.type == "checkbox"){
                    var sel = (tms.isNotEmpty($value.context.id))? "#"+$value.context.id : "[name="+$value.context.name+"]";
                    if(data[objNm] == $(sel).val()){
                        $(sel).prop("checked", true);
                    }
                } else if($value.context.type == "radio"){
                    $("input:radio[name="+$value.context.name+"]:input[value="+data[objNm]+"]").prop("checked", true);
                } else {
                    if($this.hasClass("convert")){
                        $this.val(tms.convertHtml(data[objNm]));
                    } else {
                        $this.val(data[objNm]);
                    }
                }
            } else if($value.context.tagName.toUpperCase() == "IMG"){
                $this.attr("src", data[objNm]);
            } else {
                $this.html(data[objNm]);
            }
        });
    }

    return {
        detailMapping: detailMapping
    }
}(jQuery, window, document));

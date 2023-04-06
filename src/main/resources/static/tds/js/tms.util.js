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
var tms = (function ($, win, doc) {

    var isEmpty = function(str){
        if (typeof str === 'undefined' || str == null || !str || str.length === 0 || str === "" || !/[^\s]/.test(str) || /^\s*$/.test(str) || ( str != null && typeof str == "object" && !Object.keys(str).length )) {
            return true;
        } else {
            return false;
        }
    }
    var isEmptyStr = function(str, replaceStr){
        if (typeof str === 'undefined' || str == null || !str || str.length === 0 || str === "" || !/[^\s]/.test(str) || /^\s*$/.test(str) || ( str != null && typeof str == "object" && !Object.keys(str).length )) {
            return  tms.isEmpty(replaceStr)? "": replaceStr;
        } else {
            return str;
        }
    }
    var isNotEmpty = function(str){
        return !isEmpty(str);
    }
    var LPad = function(obj, charator, num){
        var str = obj+"";
        if (! str || ! charator || str.length >= num) {
            return str;
        }

        var max = (num - str.length)/charator.length;
        for (var i = 0; i < max; i++) {
            str = charator + str;
        }

        return str;
    }
    var RPad = function(obj, charator, num){
        var str = obj+"";
        if (! str || ! charator || str.length >= num) {
            return str;
        }

        var max = (num - str.length)/charator.length;
        for (var i = 0; i < max; i++) {
            str += charator;
        }

        return str;
    }
    var setComma = function(obj){
        return obj.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

    }
    var removeComma = function(obj){
        return obj.replace(/,\s?/g, "");
    }
    var dateFormat = function(dt, format){
        var d = dt;
        var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
        return format.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
            switch ($1) {
                case "yyyy": return d.getFullYear();
                case "yy": return (LPad(d.getFullYear() % 1000), '0', 2);
                case "MM": return LPad(d.getMonth() + 1, '0', 2);
                case "dd": return LPad(d.getDate(), '0', 2);
                case "E": return weekName[d.getDay()];
                case "HH": return LPad(d.getHours(), '0', 2);
                case "hh": return (h = d.getHours() % 12) ? LPad(h, '0', 2) : 12;
                case "mm": return LPad(d.getMinutes(), '0', 2);
                case "ss": return LPad(d.getSeconds(), '0', 2);
                case "a/p": return d.getHours() < 12 ? "오전" : "오후";
                default: return $1;
            }
        });
    }
    var currentDate = function (format) {
        if(this.isEmpty(format)){
            format = 'yyyy-MM-dd';
        }
        return this.dateFormat(new Date(), format);
    }

    /* sDate: YYY-mm-dd 형식
     * sDate: 추가 일자 */
    var dateAdd = function(sDate, nDays) {
        var yy = parseInt(sDate.substr(0, 4), 10);
        var mm = parseInt(sDate.substr(5, 2), 10);
        var dd = parseInt(sDate.substr(8), 10);

        var d = new Date(yy, mm - 1, dd + nDays);
        yy = d.getFullYear();
        mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
        dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;

        return yy + '.' +  mm  + '.' + dd;
    }

    /* @description 두 날짜 사이의 날짜 조회
     *  @param startDate 시작일
     *  @param endDate 종료일
     *  @return array
     *  */
    var getDateRange = function(startDate, endDate) {
        var listDate = [];
        var dateMove = new Date(startDate);
        var strDate = startDate;
        if (startDate == endDate) {
            var strDate = dateMove.toISOString().slice(0,10);
            listDate.push(strDate);
        } else {
            while (strDate < endDate) {
                var strDate = dateMove.toISOString().slice(0, 10);
                listDate.push(strDate);
                dateMove.setDate(dateMove.getDate() + 1);
            }
        }
        return listDate;
    };

    /* @description 두 날짜 사이의 월 조회
     *  @param startDate 시작일
     *  @param endDate 종료일
     *  @return array
     *  */
    var getDateRange = function(startDate, endDate) {
        var listDate = [];
        var dateMove = new Date(startDate);
        var strDate = startDate;
        if (startDate == endDate) {
            var strDate = dateMove.toISOString().slice(0,10);
            listDate.push(strDate);
        } else {
            while (strDate < endDate) {
                var strDate = dateMove.toISOString().slice(0, 10);
                listDate.push(strDate);
                dateMove.setDate(dateMove.getDate() + 1);
            }
        }
        return listDate;
    };

    /* @description 일, 월, 년 날짜 세팅
     *  @param type 타입 (D - 일, M - 월, Y - 년)
     *  @param day 일자
     *  @return array
     *  */
    var setDate = function(type, day, format){
        var setDate = new Date();
        if(type === "D"){
            setDate.setDate(setDate.getDate() - day);
        } else if(type === "M"){
            setDate.setMonth(setDate.getMonth() - day);
        } else if(type === "Y"){
            setDate.setFullYear(setDate.getFullYear() - day);
        }

        if(this.isEmpty(format)){
            format = 'yyyy-MM-dd';
        }
        return this.dateFormat(setDate, format);
    }

    var isIe = function(){
        var agent = navigator.userAgent.toLowerCase();
        if (agent.indexOf("msie") != -1) {
            return true;
        }
        return false;
    }

    var initInputTxt = function(parentNode){
        var obj = $("input[type=text], input[type=number], input[type=tel], input[type=email], textarea, select, input[type=file], input[type=password]");
        var fileObj = $("input[type=file]");
        var checkObj = $("input[type=checkbox], input[type=radio]");
        if(typeof parentNode !== 'undefined'){
            obj = $(parentNode).find("input[type=text], input[type=number], input[type=tel], input[type=email], textarea, select, input[type=file], input[type=password]");
            fileObj = $(parentNode).find("input[type=file]"); //ie대응
            checkObj = $(parentNode).find("input[type=checkbox], input[type=radio]");
        }
        obj.val("");
        checkObj.prop('checked', false);

        if(isIe()){
            fileObj.replaceWith(fileObj.clone(true));
        }
    }
    var checkboxControl = function(allObj, subObj){
        var size = $(subObj).size();
        var checkSize = $(subObj+":checked").length;
        if ($(allObj).is(":checked")) {
            if(size != checkSize){
                $(allObj).prop("checked", false);
            }
        } else {
            if(size == checkSize){
                $(allObj).prop("checked", true);
            }
        }
    }
    var checkboxAllControl = function(allObj, subObj){
        if ($(allObj).is(":checked")) {
            $(subObj).prop("checked", true);
        } else {
            $(subObj).prop("checked", false);
        }
    }

    var confirmMsg = function(msg, okFunc, noFunc){
        if (confirm(msg)) {
            if (typeof okFunc == 'function') {
                okFunc();
            }
        } else {
            if (typeof noFunc == 'function') {
                noFunc();
            }
        }
    }

    var isCookie = function(nm){
        var gookieNm = getCookie(nm);
        if (gookieNm != "") {
            return true;
        } else {
            return false;
        }
    }

    var getCookie = function(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    var setCookie = function(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";path=/";
    }

    var ajaxDefaults = {
        async:true
        , urlChk: true
        , contentType: 'application/json;charset=UTF-8'
        , showLoding: false
        , showLodingMsg: ''
        , headers:{
            'authorization':authorization,
            'appVersion' : appVersion,
            'hipId':hipId,
            'osType' : osType,
            'deviceId' : deviceId
        }
    }

    var setAjaxDefaults = function(hipId, authorization) {
        ajaxDefaults.headers.hipId = hipId;
        ajaxDefaults.headers.authorization = authorization;
    }

    var getArray = new Array();
    var postArray = new Array();
    var putArray = new Array();
    var deleteArray = new Array();

    var urlCheck = function(url, array){
        var idx = $.inArray(url, array);
        if(idx != -1) {
            return false;
        }
        array.push(url);
        return idx;
    }

    var ajaxHelper = function(url, type, data, options, beforeFunc, sucessFunc, errorFunc){
        var checkArry = new Array();
        /* 이중 클릭을 막기위한 처리 */
        switch (type.toLocaleString()) {
            case "POST" : checkArry = postArray
                break;
            case "GET": checkArry = getArray;
                break;
            case "PUT": checkArry = putArray;
                break;
            case "DELETE" : checkArry = deleteArray;
                break;
        }

        options = options || {};
        for (var prop in ajaxDefaults)  {
            options[prop] = typeof options[prop] !== 'undefined' ? options[prop] : ajaxDefaults[prop];
        }
        if(options.urlChk){
            var idx = urlCheck(url, checkArry);
            if(!idx){
                return;
            }
        }

        $.ajax({
            url: portalProxyUrl(url),
            type: type,
            dataType : options.dataType,
            async : options.async,
            contentType: options.contentType,
            traditional: true,
            data: data,
            cache: false,
            crossDomain:true,
            headers: options.headers,
            beforeSend: function(xhr){
                if(options.showLoding){
                    showLodingPopup();
                }
                if (typeof beforeFunc == 'function') {
                    beforeFunc();
                }
            },
            success: function(result){
                checkArry.splice(idx, 1);
                if (typeof sucessFunc == 'function') {
                    sucessFunc(result);
                }
                if(options.showLoding) {
                    hideLodingPopup();
                }
            },
            error: function (jqXHR, textStauts, errorThrown) {
                checkArry.splice(idx, 1);
                hideLodingPopup();

                if (typeof errorFunc == 'function') {
                    errorFunc(jqXHR, textStauts, errorThrown);
                } else {
                    // if (jqXHR.status === 0) {
                    //     location.href = errorUrl.network
                    // }
                    // else if (jqXHR.status == 400) {
                    //     location.href = errorUrl.com+"?code=400&msg=Server understood the request, but request content was invalid"
                    // }
                    // else if (jqXHR.status == 401) {
                    //     location.href = errorUrl.com+"?code=401&msg=Unauthorized access."
                    // }
                    // else if (jqXHR.status == 403) {
                    //     location.href = errorUrl.com+"?code=403&msg=Forbidden resource can not be accessed."
                    // }
                    // else if (jqXHR.status == 404) {
                    //     location.href = errorUrl.notFound
                    // }
                    // else if (jqXHR.status == 500) {
                    //     //location.href = errorUrl.internal
                    // }
                    // else if (jqXHR.status == 503) {
                    //     //location.href = errorUrl.internal
                    // }
                    // else if (errorThrown === 'parsererror') {
                    //     location.href = errorUrl.com+"?code=Failed&msg=Requested JSON parse failed"
                    // }
                    // else if (errorThrown === 'timeout') {
                    //     location.href = errorUrl.com+"?code=Timeout&msg=Time out error."
                    // }
                    // else if (errorThrown === 'abort') {
                    //     location.href = errorUrl.com+"?code=Aborted&msg=Ajax request aborted."
                    // }
                    // else {
                    //     //location.href = errorUrl.internal
                    // }
                }
            }
        });
    }

    var ajaxMulitpartHelper = function(url, data, options, sucessFunc, errorFunc){

        var idx = urlCheck(url, postArray);
        if(!idx){
            return false;
        }

        // var idx = $.inArray(url, aFlagArray);
        // if(idx != -1) {
        //     return false;
        // }

        //postArray.push(url);

        options = options || {};
        for (var prop in ajaxDefaults)  {
            options[prop] = typeof options[prop] !== 'undefined' ? options[prop] : ajaxDefaults[prop];
        }

        if(options.showLoding){
            showLodingPopup();
        }

        $.ajax({
            type: 'POST',
            enctype: 'multipart/form-data',
            url: url,
            data: data,
            // xhrFields: {withCredentials: true},
            processData: false,
            contentType: false,
            cache: false,
            headers: options.headers,
            timeout: 900000,
            success: function (result) {
                if (typeof sucessFunc == 'function') {
                    sucessFunc(result);
                }
                postArray.splice(idx, 1);
                hideLodingPopup();
            },
            error: function(jqXHR, textStauts, errorThrown) {
                postArray.splice(idx, 1);
                if (typeof errorFunc == 'function') {
                    errorFunc(jqXHR, textStauts, errorThrown);
                }
                hideLodingPopup();
            }
        });
    }
    var ajaxPostHelper = function(url, data, option, sucessFunc, errorFunc) {
        ajaxHelper(url, 'POST', data, option, null, sucessFunc, errorFunc);
    }
    var ajaxGetHelper = function(url, data, option, sucessFunc, errorFunc){
        ajaxHelper(url, 'GET', data, option, null, sucessFunc, errorFunc);
    }
    var ajaxPutHelper = function(url, data, option, sucessFunc, errorFunc) {
        ajaxHelper(url, 'PUT', data, option, null, sucessFunc, errorFunc);
    }
    var ajaxDeleteHelper = function(url, data, option, sucessFunc, errorFunc) {
        ajaxHelper(url, 'DELETE', data, option, null, sucessFunc, errorFunc);
    }
    var ajaxPostBeforeHelper = function(url, data, option, beforeSend, sucessFunc, errorFunc){
        ajaxHelper(url, 'POST', data, option, beforeSend, sucessFunc, errorFunc);
    }
    var ajaxGetBeforeHelper = function(url, data, option, beforeSend, sucessFunc, errorFunc){
        ajaxHelper(url, 'POST', data, option, beforeSend, sucessFunc, errorFunc);
    }

    var serializeData = function(formObj) {
        var dataObj = {};
        var $this = formObj;
        try {
            if($this[0].tagName && $this[0].tagName.toUpperCase() == "FORM" ) {
                var valArray = $this.serializeArray();
                if(valArray){
                    $.each(valArray, function(key, obj) {
                        dataObj[obj.name] = obj.value;
                    });
                }
            }
        }catch(e) {
            alert(e.message);
        }finally  {}
        return dataObj;
    };

    var showLodingPopup = function(){
        //var html = '<div class="loading-box tmsDimPop"><div class="loding-wrap"><img src="/front/pc/images/common/logo_02.png" alt="로딩중" width="54" height="54" /></div></div>';
        var html = '<div class="popup loading-box tmsDimPop" style="display: block"> <div class="loader"><div class="loader_green"></div> <div class="loader_blue"></div> <div class="loader-logo"></div> </div> <div></div>';
        $(document).find("body").append(html);

        //$(document).find(".tmsDimPop").show();
    }
    var hideLodingPopup = function(msg){
        $(document).find(".tmsDimPop").remove();
    }

    var getbrowser = function(){
        var agent = navigator.userAgent.toLowerCase(),
            name = navigator.appName,
            browser;

        // MS 계열 브라우저를 구분하기 위함.
        if(name === 'Microsoft Internet Explorer' || agent.indexOf('trident') > -1 || agent.indexOf('edge/') > -1) {
            browser = 'ie';
            if(name === 'Microsoft Internet Explorer') { // IE old version (IE 10 or Lower)
                agent = /msie ([0-9]{1,}[\.0-9]{0,})/.exec(agent);
                browser += parseInt(agent[1]);
            } else { // IE 11+
                if(agent.indexOf('trident') > -1) { // IE 11
                    browser += 11;
                } else if(agent.indexOf('edge/') > -1) { // Edge
                    browser = 'edge';
                }
            }
        } else if(agent.indexOf('safari') > -1) { // Chrome or Safari
            if(agent.indexOf('opr') > -1) { // Opera
                browser = 'opera';
            } else if(agent.indexOf('chrome') > -1 || agent.indexOf('crios') > -1) { // Chrome
                browser = 'chrome';
            } else { // Safari
                browser = 'safari';
            }
        } else if(agent.indexOf('firefox') > -1) { // Firefox
            browser = 'firefox';
        }

        return  browser;
    }

    var isMobile = {
        Android: function () {
            return navigator.userAgent.match(/Android/i) == null ? false : true;
        },
        BlackBerry: function () {
            return navigator.userAgent.match(/BlackBerry/i) == null ? false : true;
        },
        IOS: function () {
            return navigator.userAgent.match(/iPhone|iPad|iPod/i) == null ? false : true;
        },
        Opera: function () {
            return navigator.userAgent.match(/Opera Mini/i) == null ? false : true;
        },
        Windows: function () {
            return navigator.userAgent.match(/IEMobile/i) == null ? false : true;
        },
        any: function () {
            return (isMobile.Android() || isMobile.BlackBerry() || isMobile.IOS() || isMobile.Opera() || isMobile.Windows());
        }
    };

    var convertHtml = function(str){
        if(str == null)
            return null;

        //특수문자
        var returnStr = str;
        returnStr = returnStr.replace(/<br>/g,"\n");
        returnStr = returnStr.replace(/&gt;/g,">");
        returnStr = returnStr.replace(/&lt;/g,"<");
        returnStr = returnStr.replace(/&quot;/g,"\"");
        returnStr = returnStr.replace(/&#34;/g,"\"");
        returnStr = returnStr.replace(/&apos;/g,"\'");
        returnStr = returnStr.replace(/&#39;/g,"\'");
        returnStr = returnStr.replace(/&nbsp;/g," ");
        returnStr = returnStr.replace(/&amp;/g, "&");

        return returnStr;

    }

    /*
     * html 로딩
     * obj: 붙여넣을 위치 param
     * path: include 경로
     * callBack: callback 함수
     * */
    var includeHtml = function(obj, path, callBack){
        $(obj).load(path, null, function(){
            if(typeof callBack == "function"){
                callBack();
            }
        });

    }

    var getParameterByName = function(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    var toFixed = function(no, fixed){
        no = Number(no);
        return no.toFixed(fixed)
    }

    var numberToWon = function(number){
        var inputNumber  = number < 0 ? false : number;
        var unitWords    = ['', '만', '억', '조', '경'];
        var splitUnit    = 10000;
        var splitCount   = unitWords.length;
        var resultArray  = [];
        var resultString = '';

        for (var i = 0; i < splitCount; i++){
            var unitResult = (inputNumber % Math.pow(splitUnit, i + 1)) / Math.pow(splitUnit, i);
            unitResult = Math.floor(unitResult);
            if (unitResult > 0){
                resultArray[i] = unitResult;
            }
        }

        for (var i = 0; i < resultArray.length; i++){
            if(!resultArray[i]) continue;
            if(i > 1){
                resultString = String(tms.setComma(resultArray[i])) + unitWords[i] + resultString;
            }
        }

        return resultString;
    }

    var setFormatCntrol = function(){
        $("[data-check]").off().bind("keyup", function(){
            var $this = $(this);
            var set = $this.data("check");
            var value = $this.val();

            if((set & 0x01) == 0x01) { // 공백허용안함
                value = value.replace(/ /gi, "");
            }
            if((set & 0x02) == 0x02) { //숫자만
                value = value.replace(/[^0-9]/gi,"");
            }
            if((set & 0x04) == 0x04) { //숫자콤마
                value = tms.setComma(tms.removeComma(value));
            }
            if((set & 0x08) == 0x08) { //영문+숫자
                value = value.replace(/[^a-zA-Z0-9]/gi,"");
            }
            $this.val(value);
        });
    }

    var checkMaxLength = function(obj, parentObjNm, myObjNm, maxLength) {
        var max = $(obj).attr('maxlength');
        if(tms.isEmpty(max) || max == 0) {
            max = maxLength;
        }
        var length = $(obj).val().length;
        if(length > max){
            $(obj).val($(obj).val().substr(0, max));
        } else {
            $(obj).parents(parentObjNm).find(myObjNm).text(length);
        }
    };

    var checkFileSize = function(file, size){
        // 사이즈체크
        var maxSize  = size * 1024 * 1024; //MB
        var fileSize = 0;
        // 브라우저 확인
        var browser=navigator.appName;
        // 익스플로러일 경우
        if (browser=="Microsoft Internet Explorer") {
            var oas = new ActiveXObject("Scripting.FileSystemObject");
            fileSize = oas.getFile( file.value ).size;
        } else  {
            fileSize = file.files[0].size;
        }

        if(fileSize > maxSize) {
            return false;
        }

        return true;
    };

    var getExtensionOfFilename = function (filename) {
    	alert("filename: "+filename);
        var fileLength = filename.length;
        var lastDot = filename.lastIndexOf('.');

        // 확장자 명만 추출한 후 소문자로 변경
        var fileExt = filename.substring(lastDot+1, fileLength).toLowerCase();
        alert("fileExt: "+fileExt);
        return fileExt;
    }

    var checkFileExt = function (filename) {
        var fileExt = getExtensionOfFilename(filename);

        if("jpg" == fileExt.toLowerCase() || "jpeg" == fileExt.toLowerCase() || "png" == fileExt.toLowerCase()) {
            return true;
        } else {
            return false;
        }
    }
    
    var checkFilePdfExt = function (filename) {
        var fileExt = getExtensionOfFilename(filename);

        if("pdf" == fileExt.toLowerCase()) {
            return true;
        } else {
            return false;
        }
    }

    var preveiwImg = function(obj, size, imgSize, callback){
        if (obj.files && obj.files[0]) {
            var reader = new FileReader();
            var code = 0;
            reader.onload = function(e) {
                EXIF.getData(obj.files[0], function() {
                    if(tms.isNotEmpty(size)){
                        if(!tms.checkFileSize(obj, size)){ //size error
                            code = 100;
                            if(typeof callback === "function"){
                                callback(code, "");
                            }
                        } else {
                            var orientation = EXIF.getTag(this, "Orientation");
                            loadImage(
                                obj.files[0],
                                function(img) {
                                    if(typeof callback === "function"){
                                        callback(code, img.toDataURL());
                                    }
                                },
                                { maxWidth: imgSize.width
                                    , maxHeight: imgSize.height
                                    , orientation: orientation
                                    , crop: true
                                } // Options
                            );

                        }
                    }
                });
            };
            reader.readAsDataURL(obj.files[0]);
        }
    }

    var timer = {
        second: 0
        , timerTxtObj: ''
        , fnTimer: ''
        , callback: function(){}
        , action: function(){
            var m = Math.floor(timer.second / 60) + ":" + (timer.second % 60);	// 남은 시간 계산
            timer.second--;// 1초씩 감소
            $(timer.timerTxtObj).text(m);
            if (timer.second < 0) { //시간종료
                clearInterval(timer.fnTimer);// 타이머 해제
                timer.callback();
            }
        },
        start: function(second, timerTxtObj, callback){
            timer.second = second;
            timer.timerTxtObj = timerTxtObj;
            timer.callback = callback;
            timer.fnTimer = setInterval(function(){timer.action()},1000);
        },
        stop: function(){
            clearInterval(timer.fnTimer);// 타이머 해제
            timer.callback();
        }
    }

    var dataFomatCheck = function(obj){
        var $this = $(obj);
        var set = $this.data("check");
        var value = $this.val();

        if((set & 0x01) == 0x01) { // 공백허용안함
            value = value.replace(/ /gi, "");
        }
        if((set & 0x02) == 0x02) { //숫자만
            value = value.replace(/[^0-9]/gi,"");
        }
        if((set & 0x04) == 0x04) { //숫자콤마
            var maxLength = $this.attr("maxlength");
            if(typeof maxLength !== "undefined"){
                maxLength = Number(maxLength);
                if(value.length >= maxLength){
                    var commaCnt = maxLength % 3;
                    value = value.substring(0, maxLength-commaCnt);
                }
            }
            value = tms.setComma(tms.removeComma(value));
        }
        $this.val(value);
    };

    var portalProxyUrl = function(url) {
        const origin = location.origin;
        
        let mode = "dev";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            mode = "stage";
        } else if (origin === 'https://portal.etoos.com') {
            mode = "live";
        }

        const regex = /^http(s):\/\/([a-z0-9-_\.]*)/i;
        const regProtocol = /^http(s)?:\/\//i;
        if(url.indexOf('http') > -1 || url.indexOf('https') > -1){
            if(mode == "dev"){
                url = url.replace(regProtocol, '');
                url = '/api/v1.0/proxy/linker' + url.substring(url.indexOf('/'), url.length);
            }
        } else {
            if (mode == "stage") {
                // url = 'https://stage-linker.etoos.com' + url;
                url = '/api/v1.0/proxy/linker' + url;
            } else if (mode == "live") {
                // url = 'https://linker.etoos.com' + url;
                url = '/api/v1.0/proxy/linker' + url;
            } else {
                url = '/api/v1.0/proxy/linker/front' + url;
            }
        }

        return url
    }

    var removeEmoji = function(str){
        const regex = /(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])/g;
        if(regex.test(str)) {
            str = str.replace(regex,'');
        }
        return str;
    }

    var isEmoji = function(str){
        const regex = /(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff]|[\u0023-\u0039]\ufe0f?\u20e3|\u3299|\u3297|\u303d|\u3030|\u24c2|\ud83c[\udd70-\udd71]|\ud83c[\udd7e-\udd7f]|\ud83c\udd8e|\ud83c[\udd91-\udd9a]|\ud83c[\udde6-\uddff]|\ud83c[\ude01-\ude02]|\ud83c\ude1a|\ud83c\ude2f|\ud83c[\ude32-\ude3a]|\ud83c[\ude50-\ude51]|\u203c|\u2049|[\u25aa-\u25ab]|\u25b6|\u25c0|[\u25fb-\u25fe]|\u00a9|\u00ae|\u2122|\u2139|\ud83c\udc04|[\u2600-\u26FF]|\u2b05|\u2b06|\u2b07|\u2b1b|\u2b1c|\u2b50|\u2b55|\u231a|\u231b|\u2328|\u23cf|[\u23e9-\u23f3]|[\u23f8-\u23fa]|\ud83c\udccf|\u2934|\u2935|[\u2190-\u21ff])/g;
        if(regex.test(str)) {
            return true;
        }
        return false;
    }

    var isBriefing = function(){
        const briefingHide = {
            "service" : ["eci"],
            "detail-service" : [],
            "branch-code" : []
        };
        const urlSearch = new URLSearchParams(location.search);
        const gnbService = urlSearch.getAll('gnbService')[0];
        const gnbDetailService = urlSearch.getAll('gnbDetailService')[0];
        const gnbBranch = urlSearch.getAll('gnbBranch')[0];

        let isHide = false;
        briefingLoop:
        for(const bKey in briefingHide){
            let target = "";

            switch (bKey) {
                case "service" :
                    target = gnbService;
                    break;
                case "detail-service" :
                    target = gnbDetailService;
                    break;
                case "branch-code" :
                    target = gnbBranch;
                    break;
                default:
                    break;
            }

            for(let idx in briefingHide[bKey]){
                if(target == briefingHide[bKey][idx]){
                    isHide = true;
                    break briefingLoop;
                }
            }
        }

        try {
            if (isHide) {
                $("#btn_briefing").css('display', 'none');
            } else {
                $("#btn_briefing").css('display', '');
            }
        }catch (e){
        }
        return isHide;
    }

    return {
        isEmpty: isEmpty,
        isEmptyStr: isEmptyStr,
        isNotEmpty: isNotEmpty,
        LPad: LPad,
        RPad: RPad,
        setComma: setComma,
        removeComma: removeComma,
        dateFormat: dateFormat,
        ajaxPostHelper : ajaxPostHelper,
        ajaxGetHelper : ajaxGetHelper,
        ajaxPutHelper: ajaxPutHelper,
        ajaxDeleteHelper: ajaxDeleteHelper,
        ajaxPostBeforeHelper: ajaxPostBeforeHelper,
        ajaxMulitpartHelper: ajaxMulitpartHelper,
        currentDate: currentDate,
        dateAdd: dateAdd,
        getDateRange:getDateRange,
        setDate:setDate,
        initInputTxt: initInputTxt,
        confirmMsg: confirmMsg,
        checkboxControl: checkboxControl,
        checkboxAllControl: checkboxAllControl,
        serializeData: serializeData,
        setAjaxDefaults: setAjaxDefaults,
        isCookie: isCookie,
        getCookie: getCookie,
        setCookie: setCookie,
        getbrowser: getbrowser,
        isMobile: isMobile,
        convertHtml: convertHtml,
        includeHtml:includeHtml,
        getParameterByName:getParameterByName,
        toFixed:toFixed,
        numberToWon:numberToWon,
        showLodingPopup:showLodingPopup,
        hideLodingPopup:hideLodingPopup,
        setFormatCntrol:setFormatCntrol,
        checkMaxLength: checkMaxLength,
        checkFileSize: checkFileSize,
        checkFileExt: checkFileExt,
        checkFilePdfExt: checkFilePdfExt,
        preveiwImg: preveiwImg,
        dataFomatCheck: dataFomatCheck,
        portalProxyUrl: portalProxyUrl,
        removeEmoji: removeEmoji,
        isEmoji: isEmoji,
        isBriefing: isBriefing,
        timer: function(){return timer;}

    }
}(jQuery, window, document));

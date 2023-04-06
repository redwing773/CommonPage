(function($){

    var setting = {
        type : '1'
        ,typeSeq : 1
        ,orderBy : 'creDt'
        ,currentPage : 1
        ,cntPerPage : 5
    };

    var isLoading=true;

    //댓글 초기화
    $.fn.tmsComment = function(params){
        $.extend(setting, params);

        comment_wrap.html('');
        comment_wrap.append(comment_form);
        comment_wrap.append(comment_summary);
        comment_wrap.append(comment_list);
        comment_wrap.append(comment_pagination);

        $(this).html(comment_wrap);

        comment_wrap.find('.comment_sort a').click(function(){
            var sort = $(this).data('sort');
            if(sort==='recent'){setting.orderBy='REG_DT';}
            if(sort==='recommend'){setting.orderBy='LIKE_CNT';}
            list(1);
        });

        list(1);

        //댓글창에 붙여넣기 했을 시 이벤트
        var onpaste = function(e){

        };

        $('.tms_comment_content').off('keyup');
        $('.tms_comment_content').off('paste');
        $('.tms_comment_content').on('keyup',onpaste);
        $('.tms_comment_content').on('paste',onpaste);
    };

    //댓글 div
    var comment_wrap = $('<div class="comment_wrap"></div>');

    //댓글 등록창 템플릿
    var comment_form = '<form class="comment_form">' +
                            '<fieldset>' +
                                '<textarea class="tms_comment_content"></textarea>'+
                                '<div>' +
                                    '<button type="button" class="comment_write">등록</button>'+
                                '</div>'+
                            '</fieldset>'+
                        '</form>';

    //대댓글 등록창 템플릿
    var comment_reply_template = function(v){

        return '<div class="comment_reply_wrap">' +
                    '<form class="comment_form">' +
                        '<fieldset>' +
                            '<textarea class="tms_comment_content'+v+'"></textarea>' +
                            '<div>' +
                                '<button type="button" class="comment_write" data-parent-no="'+v+'">등록</button>' +
                            '</div>' +
                        '</fieldset>' +
                    '</form>' +
                    '<div class="comment_reply_list"></div>' +
                    '<div class="comment_pagination_wrap"></div>' +
                '</div>';
    }

    //댓글 요약창 템플릿
    var comment_summary='<div class="comment_summary">' +
                            '<div class="comment_cnt">' +
                                '총 <strong class="tot">0</strong>개의 네티즌 의견이 있습니다.' +
                            '</div>' +
                            '<div class="comment_sort">' +
                                // '<span class="blind">댓글 정렬 옵션 선택</span>' +
                                // '<a href="#self" data-sort="recent">최근순</a>' +
                                // '<a href="#self" data-sort="recommend">추천순</a>' +
                            '</div>' +
                        '</div>';

    //댓글 리스트 템플릿
    var comment_list = '<div class="comment_list_wrap"></div>';

    //댓글 페이징 템플릿
    var comment_pagination = '<div class="comment_pagination"><ul class="pagination_template"></ul></div>';


    //댓글 상세내용 템플릿
    var content_template = function(v){

        return '<div class="user_wrap">' +
                    '<span class="best_cmt">' +
                    //'<img alt="베스트 댓글">' +
                    '</span>' +
                    //'<a class="user"><strong><span class="username">'+v.regId+'</span>님</strong></a>' +
                '</div>' +

                '<div class="content_wrap">' +
                    '<p class="content_txt">' +
                        v.contents +
                    '</p>' +
                '</div>'+

                '<div class="comment_bottom">' +

                    '<div class="comment_info_wrap">' +
                        // '<time class="time">' + v.regDt + '</time>' +
                        // '<a href="#self" class="report">신고</a>' +
                        '<div>' +
                            '<a href="#self" class="update_btn" data-comment-seq="'+ v.commentSeq +'">수정</a>' +
                            '<a href="#self" class="delete_btn" data-comment-seq="'+ v.commentSeq +'">삭제</a>' +
                        '</div>' +
                    '</div>' +

                    '<div class="comment_btn_wrap">' +
                        // '<a href="#self" class="like_btn" data-comment-seq="'+v.commentSeq+'" data-flag="like">' +
                        //     '<span class="blind">좋아요</span>' +
                        //     '<strong class="like_cnt">'+v.LIKE_CNT+'</strong>' +
                        // '</a>' +
                        // '<a href="#self" class="dislike_btn" data-comment-seq="'+v.commentSeq+'" data-flag="dislike">' +
                        //     '<span class="blind">싫어요</span>' +
                        //     '<strong class="dislike_cnt">'+v.DISLIKE_CNT+'</strong>' +
                        // '</a>' +
                        '<a href="#self" class="reply_btn" data-comment-seq="'+v.commentSeq+'">' +
                            '<span class="fix">답글</span>' +
                        //    '<strong class="reply_cnt">'+v.REPLY_CNT+'</strong>' +
                        '</a>' +
                    '</div>' +

                '</div>';
    };

    //댓글 리스트 페이징 세팅
    var list  = function(no){
        setting.currentPage=no;
        delete setting.parentSeq;
        commentList(setting).done(function(list){
            comment_wrap.find('.comment_list_wrap').html(list);
            comment_wrap.find(".comment_write").click(commentWrite);
        });

    };

    //댓글 불러오기 return <ul></ul>
    var commentList = function (params) {
        var deferred = $.Deferred();

        //댓글 불러오기
        asyncTemplate('/api/comment', params, 'get', function (rs) {
            var list = rs.data.list;
            var comment_ul = $('<ul></ul>');

            if(list.length){

                $.each( list , function(k,v){
                    var li_cont = $('<li class="reply_li reply_li'+v.commentSeq+'"></li>');

                    var content = content_template(v);
                    li_cont.html(content);

                    comment_ul.append(li_cont);
                });

                if(setting.parentSeq==null||setting.parentSeq==''){

                    var totalCnt=rs.data.totalCnt;
                    //총 댓글수 표현
                    comment_wrap.find('.tot').text(totalCnt);

                    //페이징
                    var pagination_obj={
                        totalCnt: totalCnt                  // 총 데이터 수
                        ,countPerPage:params.cntPerPage     // 한 페이지에 나타낼 데이터 수
                        ,pageCount:5                        // 한 화면에 나타낼 페이지 수
                        ,pageNo:params.currentPage          // 현재 페이지 수
                        ,id:'.pagination_template'          // 페이징이 들어갈 id
                        ,activeClass:'active'               // 활성화표시
                    };
                    pagingType1(pagination_obj);
                }

                //답글 작성
                comment_ul.find('.reply_btn').click(function(e){
                    e.preventDefault();

                    var no = $(this).data('comment-seq');
                    var reply_li = $('.reply_li'+no);
                    var reply_wrap = reply_li.find('.comment_reply_wrap');

                    if( reply_wrap.length !== 0 ){
                        reply_wrap.remove();
                    }else{

                        reply_li.append( comment_reply_template(no) );
                        comment_ul.find('.comment_write').click( commentWrite );

                        setting.parentSeq=no;
                        commentList(setting).done(function(list){
                            reply_li.find('.comment_reply_list').html(list);
                            reply_li.find('.comment_reply_list .reply_btn').remove(); //2뎁스 답글금지
                            reply_li.find('.comment_reply_list .like_btn').remove(); //2뎁스 좋아요금지
                            reply_li.find('.comment_reply_list .dislike_btn').remove(); //2뎁스 싫어요금지
                        });

                    }

                });

                //수정
                comment_ul.find('.update_btn').click(function(e){
                    e.preventDefault();

                    var no = $(this).data('comment-seq');
                    var content_wrap = $('.reply_li'+no+' .content_wrap');

                    if( content_wrap.find('.update_textarea').length>0){
                        var txt = content_wrap.find('.update_textarea').val();
                        content_wrap.html('<p class="content_txt">'+txt+'</p>');
                    }else{
                        var content = content_wrap.find('.content_txt').text();
                        content_wrap.html('<textarea class="update_textarea"></textarea>' +
                            '<a href="#self" class="update_finish" data-comment-seq="'+no+'">수정</a>');
                        content_wrap.find('.update_textarea').val(content);

                        content_wrap.find('.update_finish').click(function(e){
                            e.preventDefault();

                            var no = $(this).data('comment-seq');
                            var txt = $(this).siblings('textarea').val();

                            var updInfo = {
                                commentSeq : no
                                ,contents : txt
                            }

                            asyncTemplate('/api/comment/update', JSON.stringify(updInfo), 'post', function (rs) {
                                console.log(rs);
                                $('.reply_li'+no+' .content_wrap').html('<p class="content_txt">'+txt+'</p>');
                            });

                        });

                    }

                });

                //삭제
                comment_ul.find('.delete_btn').click(function(e){
                    e.preventDefault();

                    if(confirm('삭제하시겠습니까?')){
                        var no = $(this).data('comment-seq');
                        var delInfo = {
                            commentSeq : no
                        }
                        asyncTemplate('/api/comment/delete', JSON.stringify(delInfo), 'post', function (rs) {
                            console.log(rs);
                            $('.reply_li'+no).remove();
                        });
                    }

                });

            }else{
                comment_ul.append('<li>등록된 댓들이 없습니다.</li>');
            }

            deferred.resolve(comment_ul);
        });

        return deferred.promise();

    };

    var commentWrite = function (e) {
        e.preventDefault();

        delete setting.parentSeq;
        var parent_no = $(this).data('parent-no');
        if(parent_no!=null && parent_no !=''){
            setting.parentSeq=parent_no;
        }

        setting.contents=(parent_no!=null && parent_no !='') ?
            $('.tms_comment_content'+parent_no).val() : $('.tms_comment_content').val();

        //검증
        if( !exp_contents() ){
            return ;
        }

        var contents = setting.contents;
        if(contents==null || contents=='' || contents.length<10){
            alert('댓글을 10자이상 등록해주세요.');
            return ;
        }

        asyncTemplate('/api/comment', JSON.stringify(setting), 'post', function (data) {
            commentList(setting).done(function(list){
                if(parent_no!=null && parent_no !=''){
                    var comment_reply_list = $('.reply_li'+parent_no +' .comment_reply_list');
                    comment_reply_list.find('ul').html(list);
                    comment_reply_list.find('.reply_btn').remove();
                    comment_reply_list.find('.like_btn').remove();
                    comment_reply_list.find('.dislike_btn').remove();
                }else{
                    comment_wrap.find('.comment_list_wrap').html(list);
                }
            });
        });
    };

    //댓글 페이지가 페이징을 가져갈 경우
    var pagingType1 = function (obj) {

        var totalData = obj.totalCnt;           // 총 데이터 수
        var dataPerPage = obj.countPerPage;     // 한 페이지에 나타낼 데이터 수
        var pageCount = obj.pageCount;          // 한 화면에 나타낼 페이지 수
        var currentPage = obj.pageNo;           // 현재 페이지 수
        var fn = obj.fn;                        // 페이징 호출함수
        var id = obj.id;                        // 페이징이 들어갈 id
        var activeClass = obj.activeClass;      // 활성화표시

        // 페이지 카운트
        var pageCnt = totalData % dataPerPage;
        if (pageCnt == 0) {
            pageCnt = Math.floor(totalData / dataPerPage);
        } else {
            pageCnt = Math.floor(totalData / dataPerPage) + 1;
        }

        var pRCnt = Math.floor(currentPage / pageCount);
        if (currentPage % pageCount == 0) {
            pRCnt = Math.floor(currentPage / pageCount) - 1;
        }

        var last = (pRCnt + 1) * pageCount + 1;
        if (last > pageCnt) {
            last = pageCnt + 1;
        }

        var html = '';

        if (currentPage > pageCount) {
            var s2;
            if (currentPage % pageCount == 0) {
                s2 = currentPage - pageCount;
            } else {
                s2 = currentPage - currentPage % pageCount;
            }
            html += '<li><a href="#self" class="prev" data-prev="'+s2+'"><span>&laquo;</span></a></li>';
        }

        for (var index = pRCnt * pageCount + 1; index < last; index++) {

            var aTag = '<a href="#self">' + index + '</a>';

            if (currentPage == index) {
                html += '<li class="' + activeClass + '">' + '<a href="#self">' + index + '</a>' + '</li>';
            } else {
                html += '<li>' + aTag + '</li>';
            }
        }

        if (pageCnt > (pRCnt + 1) * pageCount)
            html += '<li><a href="#self" class="next" data-next="'+((pRCnt + 1) * pageCount + 1)+'"><span>&raquo;</span></a></li>';

        $(id).html(html);

        $(id).find('a').click(function(e){
            e.preventDefault();
            var cnt ='';
            if($(this).hasClass('prev')){
                cnt = $(this).data('prev');
            }else if($(this).hasClass('next')){
                cnt = $(this).data('next');
            }else{
                cnt = $(this).text();
            }
            list( cnt );
        });
    }

    var pagingType2 = function(){
        //페이징 안쓰고 스크롤링 시 사용
        $('.comment_list_wrap').scroll(function(){
            //댓글화면이 닫히면 스크롤 막기
            if( $('#commnetArea').css('display')=='none' ){return ;}
            //리스트 길이가 짧으면 스크롤 이벤트 막기
            if($(window).height()>$('.comment_list_div').height()){return ;}
            //리스트가 마지막 페이지면 이베트 막기
            if(setting.isLast){ return ; }

            if($(window).scrollTop() + $(window).height() > $(document).height() - 500) {

                var totalData=setting.totalCnt;
                var dataPerPage=setting.cntPerPage;
                if(totalData!=0){
                    var pageCnt = totalData % dataPerPage;
                    pageCnt= (pageCnt == 0) ? Math.floor(totalData / dataPerPage) : Math.floor(totalData / dataPerPage) + 1;

                    if(setting.currentPage>=pageCnt) {
                        setting.isLast = true;
                    }
                }

                if(isLoading){
                    isLoading=false;
                    setting.currentPage=setting.currentPage+1;
                    commentList(setting).done(function(list){
                        var li=list.find('li');
                        comment_wrap.find('.comment_list_div .comment_list').append(li);

                        isLoading=true;
                    });
                }
            }
        });
    };

    //댓글 검증
    var exp_contents = function(){
        var replyId=setting.ReplyId;

        var contents = setting.contents;
        var contents_exp=contents.replace(replyId,'');
        if(contents_exp==null || contents_exp==''){
            alert('댓글을 입력해주세요.');
            return false;
        }

        if(contents_exp.length>1000){
            alert('댓글을 1000자 이내로 입력해주세요.');
            return false;
        }

        var finish = true;
        // tms.ajaxPostHelper(apiHost + "/api/com/prohibit", null, { async:false }, function (result) {
        //
        //     if(result.data){
        //         var words=result.data.words;
        //
        //         if(words!=null && words.length>0){
        //
        //             $.each(words,function(k,v){
        //                 if( contents_exp.indexOf(v) != -1 ){
        //                     $("#popupTxt").html(i18next.t('feed:feed.alert.msg30'));
        //                     window.layer_OPEN(".popup_alert_confirm_type1");
        //                     finish = false;
        //                 }
        //             });
        //
        //         }
        //     }
        //
        // });

        return finish;
    };

    //ajax 모듈
    function asyncTemplate(url, data, method, success ) {

        $.ajax({
            url: url,
            type: method,
            data: data,
            dataType: 'json',
            contentType : 'application/json;charset=UTF-8',
            success: success,
            error: function () {}
        });
    }

})(jQuery);
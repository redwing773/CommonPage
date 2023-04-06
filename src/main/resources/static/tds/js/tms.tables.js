function tableType1(id, data, info) {
    //컬럼 data 정의
    var cols = Object.keys(data[0]);
    if (info.colsInfo != null && info.colsInfo != undefined) {
        info.colsInfo.sort(function (a, b) { // 오름차순
            return a['no'] - b['no'];
        });
        cols = info.colsInfo;
    }

    //초기 테이블 생성
    if ($(id).find('table').length == 0) {
        var tableTemplate = $('<table cellpadding="0" cellspacing="0" class="table_list_style1"><colgroup><col/><col/><col/><col/></colgroup><thead><tr></tr></thead><tbody></tbody></table>');

        $.each(cols, function (k, v) {
            if (typeof v == 'object')
                v = v.name;
            tableTemplate.find('thead tr').append('<th scope="col">' + v + '</th>');
        });

        $(id).append(tableTemplate);
    }

    //data empty
    $(id).find('table tbody').empty();

    //data 넣기
    $.each(data, function (k, v) {
        var obj = v;

        var tr = $('<tr></tr>');

        $.each(cols, function (key, val) {
            var td = $('<td></td>');

            //colsInfo 값이 있을 경우
            if (typeof val == 'object') {
                var col = obj[val.col]; //컴럼에 일치하는 값
                if (val.class != null && typeof val.class == 'function') {
                    td.addClass(val.class(col));
                }

                var html = '';
                if (val.custom != null && typeof val.custom == 'function') {
                    html = val.custom(obj);
                } else {
                    html = col;
                }

                td.html(html);
            }

            //colsInfo 가 들어오지 않았을 경우
            if (typeof val == 'string') {
                td.html(obj[val]);
            }

            tr.append(td);
        });

        $(id).find('table tbody').append(tr);
    });

    //paging
    if (info.paging != null && info.paging != undefined) {
        var type = info.paging.type;
        if (type == 'type1') {
            pagingType1(info.paging);
        }
        if (type == 'type2') {
            pagingType2(info.paging);
        } else {
            pagingType1(info.paging);
        }
    }
}

function tableType2(id, data, contents, info) {
    if (data == null || data.length == 0) {
        alert('데이터가 없습니다.');
        return;
    }

    //init table
    if ($(id).find('ul').length == 0) {
        var ulTemplate = $('<ul></ul>');
        $(id).append(ulTemplate);
    }

    //data empty
    $(id).find('ul').empty();

    //data insert
    $.each(data, function (k, v) {
        var li = $('<li></li>');

        var result = null;
        if (contents != null && typeof contents == 'function') {
            result = contents(v);
        } else {
            result = v;
        }

        li.append(result);
        $(id).find('ul').append(li);
    });

    //paging
    if (info.paging != null && info.paging != undefined) {
        var type = info.paging.type;
        if (type == 'type1') {
            pagingType1(info.paging);
        }
        if (type == 'type2') {
            pagingType2(info.paging);
        } else {
            pagingType3(info.paging);
        }
    }

}

var setting = {
    countPerPage: 10,
    pageCount: 5,
    fn: null,
    activeClass: 'on'
}

function pagingType1(info) {
    var mix = [setting, info ],
        obj =  mix.reduce(function (r, o) {
            Object.keys(o).forEach(function (k) {
                r[k] = o[k];
            });
            return r;
        }, {});

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
        html += '<a href="#self" class="btn_page_first" onclick="' + fn + '(1)"><span class="blind">첫페이지</span></a>';
        html += '<a href="#self" class="btn_page_prev" onclick="' + fn + '(' + s2 + ')"><span class="blind">전페이지</span></a>';
    }

    html += '<span class="number">';
    for (var index = pRCnt * pageCount + 1; index < last; index++) {
        var aTag = '<a href="#self" onclick="' + fn + '(' + index + ')" >' + index + '</a>';

        if (currentPage == index) {
            html += '<a href="#self" class="' + activeClass + '">' + index + '</a>';
        } else {
            html += aTag;
        }
    }
    html += '</span>';

    var lastPage = Math.floor(totalData / dataPerPage);
    if(!(totalData % dataPerPage == 0)){ // 나머지가 없음
        lastPage = lastPage+1;
    }
    if (pageCnt > (pRCnt + 1) * pageCount){
        html += '<a href="#self" class="btn_page_next" onclick="' + fn + '(' + ((pRCnt + 1) * pageCount + 1) + ')"><span class="blind">다음페이지</span></a>';
        html += '<a href="#self" class="btn_page_last" onclick="' + fn + '(' + (lastPage) + ')"><span class="blind">마지막페이지</span></a>';
    }

    $(id).html(html);
}

function pagingType2(info) {
    var mix = [setting, info ],
    obj =  mix.reduce(function (r, o) {
        Object.keys(o).forEach(function (k) {
            r[k] = o[k];
        });
        return r;
    }, {});

    var totalData = obj.totalCnt;           // 총 데이터 수
    var dataPerPage = obj.countPerPage;     // 한 페이지에 나타낼 데이터 수
    var pageCount = obj.pageCount;          // 한 화면에 나타낼 페이지 수
    var currentPage = obj.pageNo;           // 현재 페이지 수
    var fn = obj.fn;                        // 페이징 호출함수
    var id = obj.id;                        // 페이징이 들어갈 id
    var activeClass = obj.activeClass;      // 활성화표시

    var totalPage = Math.ceil(totalData / dataPerPage);    // 총 페이지 수
    var pageGroup = Math.ceil(currentPage / pageCount);    // 페이지 그룹

    var last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호 1*10
    if (last > totalPage)
        last = totalPage;

    var first = last - (pageCount - 1);    // 화면에 보여질 첫번째 페이지 번호
    if (0 >= first)
        first = 1;

    var next = last + 1;
    var prev = first - 1;

    var html = "";
    if (prev > 0)
        html += '<li><a href="#self" onclick="' + fn + '(' + prev + ')"><span>&laquo;</span></a></li>';

    for (var i = first; i <= last; i++) {
        var aTag = '<a href="#self" onclick="' + fn + '(' + i + ')" >' + i + '</a>';

        if (currentPage == i) {
            html += '<li class="' + activeClass + '">' + '<a href="#self">' + i + '</a>' + '</li>';
        } else {
            html += '<li>' + aTag + '</li>';
        }
    }

    if (last < totalPage)
        html += '<li><a href="#self" onclick="' + fn + '(' + next + ')"><span>&raquo;</span></a></li>';

    $(id).html(html);
}

function tableType3(id, data, info, colspan, noMessage, tableWidth) {
    //컬럼 data 정의
    //var cols = Object.keys(data[0]);
    var cols = {};
    if (info.colsInfo != null && info.colsInfo != undefined) {
        info.colsInfo.sort(function (a, b) { // 오름차순
            return a['no'] - b['no'];
        });
        cols = info.colsInfo;
    }

    //초기 테이블 생성
    if ($(id).find('table').length == 0) {
        var tableTemplate = "";
        if(tms.isEmpty(tableWidth)) {
            tableTemplate = $('<table cellpadding="0" cellspacing="0"><thead><tr></tr></thead><tbody></tbody></table>');
        } else {
            tableTemplate = $("<table cellpadding='0' cellspacing='0' style='width:"+tableWidth+"'><thead><tr></tr></thead><tbody></tbody></table>");
        }

        $.each(cols, function (k, v) {
            var value = "";
            var width = "";
            if (typeof v == 'object') {
                value = v.name;
                width = v.width;
            }

            if(tms.isEmpty(width)) {
                tableTemplate.find('thead tr').append("<th scope='col' style='text-align:center;'>" + value + '</th>');
            } else {
                tableTemplate.find('thead tr').append("<th scope='col' style='text-align:center;width:"+width+"'>" + value + '</th>');
            }

        });

        $(id).append(tableTemplate);
    }

    //data empty
    $(id).find('table tbody').empty();

    if (data == null || data.length == 0) {
        var tr = $('<tr></tr>');
        var td = $("<td class='nodata' colspan='"+colspan+"'  style='text-align:center;'>"+noMessage+"</td>");
        tr.append(td);
        $(id).find('table tbody').append(tr);
    } else {
        //data 넣기
        $.each(data, function (k, v) {
            var obj = v;

            var tr = $('<tr></tr>');

            $.each(cols, function (key, val) {
                var td = $('<td></td>');

                //colsInfo 값이 있을 경우
                if (typeof val == 'object') {
                    var col = obj[val.col]; //컴럼에 일치하는 값
                    if (val.class != null && typeof val.class == 'function') {
                        td.addClass(val.class(col));
                    }

                    var html = '';
                    if (val.custom != null && typeof val.custom == 'function') {
                        html = val.custom(obj);
                    } else {
                        html = col;
                    }

                    if(html == null || html == "null" || html == "undefined") {
                        html = "";
                    }

                    td.html(html);

                }

                //colsInfo 가 들어오지 않았을 경우
                if (typeof val == 'string') {
                    td.html(obj[val]);
                }

                tr.append(td);
            });

            $(id).find('table tbody').append(tr);
        });
    }


    //paging
    if (info.paging != null && info.paging != undefined) {
        var type = info.paging.type;
        if (type == 'type1') {
            pagingType1(info.paging);
        } else if (type == 'type2') {
            pagingType2(info.paging);
        } else {
            pagingType3(info.paging);
        }
    }
}

function pagingType3(info) {
    var mix = [setting, info ],
    obj =  mix.reduce(function (r, o) {
        Object.keys(o).forEach(function (k) {
            r[k] = o[k];
        });
        return r;
    }, {});

    var totalData = obj.totalCnt;           // 총 데이터 수
    var dataPerPage = obj.countPerPage;     // 한 페이지에 나타낼 데이터 수
    var pageCount = obj.pageCount;          // 한 화면에 나타낼 페이지 수
    var currentPage = obj.pageNo;           // 현재 페이지 수
    var fn = obj.fn;                        // 페이징 호출함수
    var id = obj.id;                        // 페이징이 들어갈 id
    var activeClass = obj.activeClass;      // 활성화표시

    var totalPage = Math.ceil(totalData / dataPerPage);    // 총 페이지 수
    var pageGroup = Math.ceil(currentPage / pageCount);    // 페이지 그룹

    var last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호 1*10
    if (last > totalPage)
        last = totalPage;

    var first = last - (pageCount - 1);    // 화면에 보여질 첫번째 페이지 번호
    if (0 >= first)
        first = 1;

    var next = last + 1;
    var prev = first - 1;

    var html = "";
    if (prev > 0)
        html += '<a href="#self" class="prev" onclick="' + fn + '(' + prev + ')">이전 페이지</a>';

    for (var i = first; i <= last; i++) {
        var aTag = '<a href="#self" onclick="' + fn + '(' + i + ')" >' + i + '</a>';

        if (currentPage == i) {
            html += '<strong>' + i + '</strong>';
        } else {
            html += aTag;
        }
    }

    if (last < totalPage)
        html += '<a href="#self" class="next" onclick="' + fn + '(' + next + ')">다음 페이지</a>';

    $(id).html(html);
}

function tableType4(id, data, contents, info) {
    $(id).empty();

    $.each(data, function (k, v) {
        var result = null;
        if (contents != null && typeof contents == 'function') {
            result = contents(v);
        } else {
            result = v;
        }
        $(id).append(result);
    });

    //paging
    if (info.paging != null && info.paging != undefined) {
        var type = info.paging.type;
        if (type == 'type1') {
            pagingType1(info.paging);
        }
        if (type == 'type2') {
            pagingType2(info.paging);
        } else {
            pagingType1(info.paging);
        }
    }

}

function tableMoreType1(id, data, info, colspan, noMessage, tableWidth) {

    //컬럼 data 정의
    //var cols = Object.keys(data[0]);
    var cols = {};
    if (info.colsInfo != null && info.colsInfo != undefined) {
        info.colsInfo.sort(function (a, b) { // 오름차순
            return a['no'] - b['no'];
        });
        cols = info.colsInfo;
    }

    //초기 테이블 생성
    if ($(id).find('table').length == 0) {
        var tableTemplate = "";
        if(tms.isEmpty(tableWidth)) {
            tableTemplate = $('<table cellpadding="0" cellspacing="0" class="table_style_02 mb15"><thead><tr></tr></thead><tbody></tbody></table>');
        } else {
            tableTemplate = $("<table cellpadding='0' cellspacing='0' class='table_style_02 mb15' style='width:"+tableWidth+"'><thead><tr scope='col'></tr></thead><tbody></tbody></table>");
        }

        $.each(cols, function (k, v) {
            var value = "";
            var width = "";
            if (typeof v == 'object') {
                value = v.name;
                width = v.width;
            }

            if(tms.isEmpty(width)) {
                tableTemplate.find('thead tr').append("<th scope='col' style='text-align:center;'>" + value + '</th>');
            } else {
                tableTemplate.find('thead tr').append("<th scope='col' style='text-align:center;width:"+width+"'>" + value + '</th>');
            }

        });

        $(id).append(tableTemplate);
    }

    if (data == null || data.length == 0) {
        var tr = $('<tr></tr>');
        var td = $("<td colspan='"+colspan+"'  style='text-align:center;'>"+noMessage+"</td>");
        tr.append(td);
        $(id).find('table tbody').append(tr);
    } else {
        //data 넣기
        $.each(data, function (k, v) {
            var obj = v;

            var tr = $('<tr></tr>');

            $.each(cols, function (key, val) {
                var td = $('<td></td>');

                //colsInfo 값이 있을 경우
                if (typeof val == 'object') {
                    var col = obj[val.col]; //컴럼에 일치하는 값
                    if (val.class != null && typeof val.class == 'function') {
                        td.addClass(val.class(col));
                    }

                    var html = '';
                    if (val.custom != null && typeof val.custom == 'function') {
                        html = val.custom(obj);
                    } else {
                        html = col;
                    }

                    if(html == null || html == "null" || html == "undefined") {
                        html = "";
                    }

                    td.html(html);

                }

                //colsInfo 가 들어오지 않았을 경우
                if (typeof val == 'string') {
                    td.html(obj[val]);
                }

                tr.append(td);
            });

            $(id).find('table tbody').append(tr);
        });
    }
}

function tableMoreType2(id, data, isEmpty, contents, info) {
    if(isEmpty || info.currentPage == 1){
        $(id).empty();
    }

    if(data == null){
        $(id).append(contents);
    } else {
        $.each(data, function (k, v) {
            var result = null;
            if (contents != null && typeof contents == 'function') {
                result = contents(v);
            } else {
                result = v;
            }
            $(id).append(result);
        });
    }
}
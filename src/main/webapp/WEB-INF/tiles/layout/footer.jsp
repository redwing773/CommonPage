<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:choose>
    <c:when test="${device eq 'web'}">
        <footer id="footer" style="display: none;">
            <div class="inner">
                <div class="left_box">
                    <p class="tit">이투스에듀 주식회사</p>
                    <p class="txt">
                        서울시 서초구 남부순환로 2547 (서초동 1354-3) | Fax 02-6442-7637 | 고객센터 1599-6405<br>
                        사업자등록번호 : 722-85-02352 | 통신판매업신고 : 제 2022-서울서초-1710호 <a
                            href="javascript:window.open('https://www.ftc.go.kr/bizCommPop.do?wrkr_no=7228502352','' ,'scrollbars=yes, width=750, height=700'); void(0);">정보확인</a>
                        | 대표이사 : 정선욱<br>
                        학원설립 운영등록번호 : 제 10269호 이투스원격학원 <a href="javascript:;"
                                                          onclick="fnG_FOOTER_IMG('https://img.etoos.com/home/main2016/common/etoosimg_0609.jpg');">정보조회</a>
                        | 신고기관명 : 서울특별시 강남서초교육지원청<br>
                        개인정보보호책임자 : 정미상
                    </p>
                    <p class="txt txt2">
                        Copyright (c) ETOOS Allright reserved. <a href="mailto:etoos@etoos.com">etoos@etoos.com</a><br>
                        2023-01-26 14:00:00
                    </p>
                </div>
                <script>
                    function fnG_FOOTER_IMG(img_src) {
                        let img_view = img_src;
                        let x = 20;
                        let y = 30;
                        let shight = screen.height - 150; //전체화면에서 창여백주기
                        let swidth = screen.width - 50; //전체화면에서 창여백주기
                        htmlz = "<html><head><title>이미지크게보기</title><style>body{margin:0;cursor:hand;}</style></head><body scroll=auto onload='width1=document.all.Timage.width;if(width1>"
                            + swidth + ")width1=" + swidth
                            + ";height1=document.all.Timage.height;if(height1>" + shight + ")height1="
                            + shight
                            + ";top.window.resizeTo(width1+40,height1+100);' onclick='top.window.close();'><img src='"
                            + img_view + "'  title='클릭하시면 닫힙니다.' name='Timage' id='Timage'></body></html>"
                        imagez = window.open('', "image", "width=" + 120 + ", height=" + 160
                            + ", top=0,left=0,scrollbars=auto,resizable=1,toolbar=0,menubar=0,location=0,directories=0,status=1");
                        imagez.document.open();
                        imagez.document.write(htmlz);
                        imagez.document.body.focus();
                        imagez.document.close();
                    }
                </script>
            </div>
        </footer>
    </c:when>
    <c:otherwise>
        <footer id="footer" style="display: none;">
            <div class="inner">
                <p class="tit">이투스에듀 주식회사</p>
                <p class="txt">
                    서울시 서초구 남부순환로 2547 (서초동 1354-3) <br>| Fax 02-6442-7637 | 고객센터 1599-6405<br>
                    사업자등록번호 : 722-85-02352 | 통신판매업신고 : 제 2022-서울서초-1710호 | 대표이사 : 정선욱<br>
                    학원설립 운영등록번호 : 제 10269호 이투스원격학원 |<br> 신고기관명 : 서울특별시 강남서초교육지원청<br>
                    개인정보보호책임자 : 정미상
                </p>
                <p class="txt txt2">
                    Copyright (c) ETOOS Allright reserved. <br><a href="mailto:etoos@etoos.com">etoos@etoos.com</a><br>
                    2023-01-26 14:00:00
                </p>
            </div>
        </footer>
    </c:otherwise>
</c:choose>
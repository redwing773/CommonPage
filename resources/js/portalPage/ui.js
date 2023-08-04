// portalPageGate js
import { CONSTANT, LOGINGNBURL, TOPBANNERURL, TOPCONTENTURL, SERVICE, SERVICETYPE } from './modules/Constant.js';
import TabsFunc from './modules/TabsFunc.js';
import { DdayCounter, rippleEffect } from './modules/Util.js';
import { CommonPage3pTop } from './modules/3p.js'
import ContestTop from './modules/Contest.js';
import { CommonPage6pTop } from './modules/6p.js'
import NewTeacherTop from './modules/Newteacher.js';
import CommonPage9pExam8 from './modules/9p.js'

export const isIE = navigator.userAgent.search('Trident') != -1 ? true : false;

async function fetchHtmlAsText(url, tar) {
    if (url === null) {
        return;
    }
    let data = await fetch(url).then(response => response.text());
    if (tar) {
        document.querySelector(tar).innerHTML = data;
    }
    return data;
}
async function importPage() {
    // 로그인 GNB
    if (document.querySelector('#loginGnb')) {
        await fetchHtmlAsText(LOGINGNBURL, '#loginGnb');
    }

    // 탑 배너
    if (document.querySelector('#topBn')) {
        await fetchHtmlAsText(TOPBANNERURL[SERVICE], '#topBn')
            .then(() => {
                if (SERVICE === "CommonPage6p") { DdayCounter('#topBn .count_wrap .num', '2023-06-01T23:59:59') }
            })
    }

    // 탑 콘텐츠
    let div = document.createElement('div');
    div.id = 'tempDiv';
    const topCont = document.querySelector(`#top_content`);
    topCont.prepend(div);

    if (SERVICE) {
        // function getValue(varName) { return CONSTANT[varName]; } // 함수 인자로 전달된 변수 값을 접근 
        // const serviceUrl = getValue(service); // 함수 호출 시 변수 값을 전달
        fetchHtmlAsText(TOPCONTENTURL[SERVICE])
            .then(response => {
                if (response) {
                    document.querySelector('#tempDiv').outerHTML = response;
                };
            })
            .then((response) => {
                // ie일 경우 webp를 png로 변경
                if (isIE) {
                    document.querySelector('.top_container > div').classList.add('ie');
                }
                // 3평
                if (SERVICE === "CommonPage") {
                    CommonPage3pTop();
                };

                // 문항공모전
                if (SERVICE === "ContestPage") {
                    ContestTop();
                };

                // 6평
                if (SERVICE === "CommonPage6p") {
                    CommonPage6pTop();
                };

                // 강사채용
                if (SERVICE === "NewTeacher") {
                    NewTeacherTop();
                };

                // 7월 수시 - null

                // 9평
                if (SERVICE === "CommonPage9p") {
                    CommonPage9pExam8();
                };
            })
            .then(() => {
                if (!document.querySelector('.tab_wrap')) {
                    rippleEffect();
                }
            })
    }

    // 푸터
    if (document.querySelector('#footer')) {
        await fetchHtmlAsText(`./modules/${CONSTANT.SUBFILENAME}CommonPageFooter.html`, '#footer');
    }
}
importPage();

//  주소에 ?tab=num > 해당 탭으로
const getUrlParam = (() => {
    const url = new URL(window.location.href);
    let urlParam = url.searchParams.get('tab')
    if (urlParam) { urlParam = Number(urlParam) - 1; }
    return urlParam;
})();

// tab
let tabWrap = document.querySelector('.tab_wrap');
if (tabWrap) {
    document.addEventListener('DOMContentLoaded', new TabsFunc(SERVICE, getUrlParam));
}

// top버튼 컨트롤
const toTop = document.querySelector('.toTop');
function toTopFn() {
    // top 클릭
    toTop.querySelectorAll('button').forEach(i => {
        i.addEventListener('click', e => {
            if (e.currentTarget.classList == '') {
                window.scroll({ top: 0, behavior: 'smooth' });
            }
            else if (e.currentTarget.classList.contains('toolBtn')) {
                e.currentTarget.classList.toggle('is-show');
                e.currentTarget.parentNode.querySelectorAll('.toolBox a').forEach(ii => {
                    ii.onclick = ee => {
                        ee.stopPropagation();
                    };
                })

            }
        });
    });

    // top 노출
    let winTop;
    window.addEventListener('scroll', () => {
        winTop = window.pageYOffset || document.documentElement.scrollTop;
        if (winTop > 0) {
            toTop.classList.add('on');
        } else {
            toTop.classList.remove('on');
        }
    });
}
if (toTop) { toTopFn(); }

// 새로고침 시 항상 scroll top0
history.scrollRestoration = 'manual';

// 포털GNB로드 후 스크롤
const portalGnb = document.querySelector('#portalGnb');
if (portalGnb) {
    const observer = new MutationObserver((mutations) => {
        // console.log(mutations);
        mutations.forEach((mutation) => {
            if (mutation.addedNodes.length > 0 && portalGnb) {
                const disconnectObserver = function () { observer.disconnect(); };
                function observerFn(callback) {
                    window.scroll({ top: CONSTANT.DEVICE == 'WEB' ? 100 : 50, behavior: 'smooth' });
                    callback();
                };
                observerFn(disconnectObserver);
            };
        });
    });
    // observer를 특정 요소에 연결합니다.
    observer.observe(portalGnb, { childList: true, subtree: true });
};

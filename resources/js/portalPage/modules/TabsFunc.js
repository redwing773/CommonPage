import { CONSTANT, TABURLS, SERVICE, SERVICETYPE } from './Constant.js';
import { TabScripts3p } from './3p.js';
import { TabScripts6p } from './6p.js';
import { TabScripts7s } from './7s.js';
import { rippleEffect } from './Util.js';

// tab
export default class TabsFunc {
    constructor(tabType, getUrlParam) {
        this.urls = TABURLS[tabType]; // 탭 url
        this.tabInit = true; // 최초실행 여부
        this.tabLoad = []; // 탭의 로드여부
        for (let i = 1; i <= this.urls.length; i++) {
            this.tabLoad.push(false); // 처음이니 모두 탭 로드 false
        }
        let random = (Math.floor(Math.random() * this.urls.length));
        if (getUrlParam !== null) {
            random = getUrlParam;
        }

        // if (random == 1) { // 5.15 오픈 시 탭2, 3은 비활성 
        //     random = random - 1;
        // } else if (random == 2) {
        //     random = random + 1;
        // };

        this.tabsFn(this.urls[random], random);
        document.querySelectorAll('.tab_head li a')[random].classList.add('on');
        this.eventTabClick();
        this.eventTabHead();
        // this.eventTabHeadTooltip();
        this.sibilingTab(this.urls, random)
    }

    tabsFn(url, index) {
        // 최초실행 체크
        if (this.tabInit == true) {
            let urlLen = this.urls.length;
            for (let i = 1; i <= urlLen; i++) {
                let div = document.createElement('div');
                div.classList.add('tab-content-wrap');
                document.querySelector('.tab_wrap .tab_body').append(div);
            }
            this.tabInit = false;
        }

        // 탭 변경
        function tabChange(index) {
            const tabContWrap = document.querySelectorAll('.tab_wrap .tab_body .tab-content-wrap');
            tabContWrap[index].style.display = 'block';
            let thisSiblings = function () {
                return [...tabContWrap[index].parentElement.children].filter(e => e != tabContWrap[index]);
            }();
            thisSiblings.forEach(i => {
                i.style.display = "none";
            })
            TabsFunc.eventTabScript(index);
        };

        // 탭 로드 체크 후 로드
        if (this.tabLoad[index] == false) {
            // 탭 호출
            fetch(url)
                .then(response => response.text())
                .then(data => {
                    document.querySelectorAll(".tab_wrap .tab_body .tab-content-wrap")[index].innerHTML = data;
                    this.tabLoad[index] = true;
                    tabChange(index);
                })
        } else {
            tabChange(index);
        }
    }

    // 탭 클릭
    eventTabClick() {
        const _tabHeadBtn = document.querySelectorAll('.tab_wrap .tab_head ul li a');
        _tabHeadBtn.forEach((i, index) => {
            i.addEventListener('click', e => {
                if (!i.classList.contains('on')) {
                    setTimeout(() => {
                        let tabBodyTop = document.querySelector('.tab_wrap').offsetTop;
                        window.scroll({ top: tabBodyTop, behavior: 'smooth' });
                    }, 50)
                }
                _tabHeadBtn.forEach((ii) => {
                    ii.classList.remove('on');
                });
                i.classList.add('on');
                this.tabsFn(this.urls[index], index);
            })
        });
    }

    // 각 탭 스크립트
    static eventTabScript(idx) {
        if (SERVICE === "CommonPage") {
            TabScripts3p(idx)
        }
        if (SERVICE === "CommonPage6p") {
            TabScripts6p(idx);
        }
        if (SERVICE === "CommonPage7s") {
            TabScripts7s(idx);
        }
        rippleEffect();
    }

    eventTabHead() {
        const tabHead = document.querySelector('.tab_head');
        let winTop;

        window.addEventListener('scroll', () => {
            winTop = window.pageYOffset || document.documentElement.scrollTop;
            const tabHeadY = tabHead.parentElement.offsetTop >= 0 ? tabHead.parentElement.offsetTop : 0;
            if (winTop > tabHeadY) {
                tabHead.classList.add('fixed');
            } else {
                tabHead.classList.remove('fixed');
            }
            if (document.querySelector('.tab_head .tooltip')) {
                if (winTop - (CONSTANT.DEVICE == 'WEB' ? 60 : 30) >= tabHeadY) {
                    tabHead.classList.add('hide');
                } else {
                    tabHead.classList.remove('hide');
                }
            }
        });
    }

    // eventTabHeadTooltip() {
    //     const tar = document.querySelectorAll('.tab_head li');
    //     tar.forEach(i => {
    //         if (CONSTANT.DEVICE == 'WEB') {
    //             i.addEventListener('mouseover', () => {
    //                 if (!i.querySelector('a').classList.contains('on')) {
    //                     document.querySelector('.tab_head li a.on .tooltip').style.opacity = '0';
    //                 }
    //                 i.querySelector('a .tooltip').style.opacity = '1';
    //             });

    //             i.addEventListener('mouseout', () => {
    //                 if (!i.querySelector('a').classList.contains('on')) {
    //                     document.querySelector('.tab_head li a.on .tooltip').style.opacity = '1';
    //                 } else {
    //                     return false;
    //                 }
    //                 i.querySelector('a .tooltip').style.opacity = '0';
    //             });
    //         } else {
    //             i.addEventListener('click', () => {
    //                 if (!i.querySelector('a').classList.contains('on')) {
    //                     document.querySelector('.tab_head li a.on .tooltip').style.opacity = '1';
    //                 } else {
    //                     return false;
    //                 }
    //                 i.querySelector('a .tooltip').style.opacity = '0';
    //             });
    //         }
    //     })
    // }

    sibilingTab(urls, index) {
        for (let i = 0; i <= urls.length - 1; i++) {
            if (index !== i) {
                // 나머지 탭 호출
                fetch(urls[i])
                    .then(response => response.text())
                    .then(data => {
                        document.querySelectorAll(".tab_wrap .tab_body .tab-content-wrap")[i].innerHTML = data;
                    });
                this.tabLoad[i] = true;
            }
        }
    }
}

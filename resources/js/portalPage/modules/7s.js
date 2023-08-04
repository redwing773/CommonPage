import { CONSTANT, SERVICETYPE } from './Constant.js';
import { DdayCounter, tabControl, quickMenu } from './Util.js';
// import TabsFunc from './TabsFunc.js'

// 탭 스크립트
function TabScripts(idx) {
    const scripts = {
        0: () => {
            console.log('탭1 스크립트')

            // 진입 모션
            function initMotion() {
                document.querySelectorAll('.tab1 .balloons').forEach((i, index) => {
                    let timing = 100 + index * 150;
                    setTimeout(() => {
                        i.classList.add('on');
                    }, timing)
                });
            };
            document.addEventListener('DOMContentLoaded', initMotion());
            document.removeEventListener('DOMContentLoaded', initMotion);

            // d-day 카운터
            if (!document.querySelector('.tab1 .count_wrap .num').classList.contains('hasDday')) {
                DdayCounter('.tab1 .count_wrap .num', '2023-09-11T23:59:59');
                document.querySelector('.tab1 .count_wrap .num').classList.add('hasDday');
            }

            // 스크롤 시 대상 움직였다 돌아옴
            function scrollMotion() {
                const targetDelay = document.querySelector('.tab1 .delayimg_box');
                const targetMain = document.querySelector('.tab1 .main_box:not(.mob)');
                let _scrollPosition = document.documentElement.scrollTop || 0;
                window.addEventListener('scroll', (e) => {
                    let winTop = document.documentElement.scrollTop;
                    let direction = winTop - _scrollPosition >= 0 ? "" : "-";
                    let mainMove = (winTop) / 5;

                    if (winTop >= 0) {
                        targetDelay.style.transform = `translateY(${direction}10px)`;
                        targetDelay.style.transition = 'transform .3s ease-in-out';
                        if (targetMain) {
                            targetMain.style.transform = `translateY(${mainMove}px)`;
                        }
                        setTimeout(() => {
                            targetDelay.style.transform = `translateY(0)`;
                            targetDelay.style.transition = 'transform .6s ease-in-out';

                        }, 400);
                    }
                    _scrollPosition = winTop;
                });
            };
            scrollMotion();

            //뷰포트 진입 시 대상 노출
            function motionBoxOn() {
                let options = { threshold: 0 };
                let observer = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (!entry.isIntersecting) return;
                        const target = entry.target;
                        target.classList.add('on');
                        observer.unobserve(target);
                    });
                }, options);
                const obTarget = Array.from(document.querySelectorAll('.tab1 .motion_box .frames:not(.img)'));
                obTarget.push(document.querySelector('.strategy'));
                obTarget.forEach(elem => observer.observe(elem));
            };
            motionBoxOn();

            const option1 = {
                loop: true,
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false,
                },
                slidesPerView: 'auto',
                observer: true,
                observeParents: true,
                // pagination: {
                //     el: ".swiper-pagination",
                //     // type: 'fraction',
                // },
                // navigation: {
                //     prevEl: ".swiper-button-prev",
                //     nextEl: ".swiper-button-next",
                // },
                observer: true,
                observeParents: true,
            }
            const slide1 = document.querySelector('.tab1 .cont1_slide1 .swiper-container');
            const slide2 = document.querySelector('.tab1 .cont1_slide2 .swiper-container');
            if (slide1 && slide2) {
                const swiper1 = new Swiper(slide1, {
                    ...option1,
                    pagination: {
                        el: ".cont1_slide1 .swiper-pagination",
                    },
                });
                const swiper2 = new Swiper(slide2, {
                    ...option1,
                    pagination: {
                        el: ".cont1_slide2 .swiper-pagination",
                    },
                });
            };
        },
        1: () => {
            console.log('탭2 스크립트')
            // 슬라이드
            const option1 = {
                loop: true,
                // autoplay: {
                //     delay: 3000,
                //     disableOnInteraction: false,
                // },
                slidesPerView: 1,
                observer: true,
                observeParents: true,
                // pagination: {
                //     el: ".swiper-pagination",
                //     type: 'fraction',
                // },
                navigation: {
                    prevEl: ".swiper-button-prev",
                    nextEl: ".swiper-button-next",
                },
                observer: true,
                observeParents: true,
            }
            const slide1 = document.querySelector('.tab2 .cont1_slide .swiper-container');
            if (slide1) {
                const swiper1 = new Swiper(slide1, option1);
                // slide1.addEventListener('mouseenter', () => {
                //     swiper1.autoplay.stop();
                // });
                // slide1.addEventListener('mouseleave', () => {
                //     swiper1.autoplay.start();
                // });
            };

            const slide2 = document.querySelector('.tab2 .cont2_slide1 .swiper-container');
            if (slide2) {
                const swiper2 = new Swiper(slide2, {
                    ...option1,
                    autoplay: {
                        delay: 3000,
                        disableOnInteraction: false,
                    },
                    pagination: {
                        el: ".swiper-pagination",
                    },
                });
            };

            // 퀵메뉴
            quickMenu('.tab2 .quickmenu', 0);

        },
        2: () => {
            console.log('탭3 스크립트');
            // 퀵메뉴
            quickMenu('.tab3 .quickmenu', 0);

        },
        3: () => {
            console.log('탭4 스크립트');

            // 슬라이드
            const option1 = {
                loop: true,
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false,
                },
                slidesPerView: 1,
                observer: true,
                observeParents: true,
                pagination: {
                    el: ".swiper-pagination",
                    type: 'fraction',
                },
                navigation: {
                    prevEl: ".swiper-button-prev",
                    nextEl: ".swiper-button-next",
                },
                observer: true,
                observeParents: true,
            }
            const slide1 = document.querySelector('.tab4 .cont3_slide .swiper-container');
            if (slide1) {
                const swiper1 = new Swiper(slide1, option1);
                slide1.addEventListener('mouseenter', () => {
                    swiper1.autoplay.stop();
                });
                slide1.addEventListener('mouseleave', () => {
                    swiper1.autoplay.start();
                });
            };
            const slide2 = document.querySelector('.tab4 .cont5_slide .swiper-container');
            if (slide2) {
                if (CONSTANT.DEVICE === "MOBILE") {
                    const swiper2 = new Swiper(slide2, {
                        ...option1,
                        pagination: {
                            el: ".tab4 .cont5_slide .swiper-pagination",
                            type: 'bullets',
                        },
                    });
                } else {
                    const swiper2 = new Swiper(slide2, option1);
                    slide2.addEventListener('mouseenter', () => {
                        swiper2.autoplay.stop();
                    });
                    slide2.addEventListener('mouseleave', () => {
                        swiper2.autoplay.start();
                    });
                }
            };

            // 탭
            if (document.querySelector(".tab4 .cont3 .tab_wrap")) {
                tabControl(document.querySelector(".tab4 .cont3 .tab_wrap"));
            }
            if (document.querySelector(".tab4 .cont4 .tab_wrap")) {
                tabControl(document.querySelector(".tab4 .cont4 .tab_wrap"));
            }
        },
    }
    scripts[idx]();
}

export const TabScripts7s = TabScripts;
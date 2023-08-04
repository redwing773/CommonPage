import { CONSTANT } from './Constant.js';
import TabsFunc from './TabsFunc.js';

// 탭 스크립트
function TabScripts(idx) {
    const scripts = [
        () => {
            console.log('탭1 스크립트')
            const swiperContainer = document.querySelector('.cont1 .tit1-slide .swiper-container');
            if (swiperContainer) {
                const swiper = new Swiper(swiperContainer, {
                    loop: true,
                    navigation: {
                        prevEl: ".cont1 .tit1-slide .swiper-container .swiper-button-prev",
                        nextEl: ".cont1 .tit1-slide .swiper-container .swiper-button-next",
                    },
                    autoplay: {
                        delay: 3000,
                        disableOnInteraction: false,
                    },
                    slidesPerView: 1,
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true,
                    },
                    on: {
                        init: function () {
                            if (CONSTANT.DEVICE !== 'WEB' && document.querySelector(".cont1 .tit1-slide .swiper-container .swiper-button-prev")) {
                                document.querySelector(".cont1 .tit1-slide .swiper-container [class*='swiper-button-prev']").style.display = 'none';
                                document.querySelector(".cont1 .tit1-slide .swiper-container [class*='swiper-button-next']").style.display = 'none';
                            }
                        },
                    },
                });
            }
        },
        () => {
            console.log('탭2 스크립트')
            const swiperContainer2 = document.querySelector('.moei_tab .cont2 .tit2-slide .swiper-container');
            if (swiperContainer2) {
                const swiper = new Swiper(swiperContainer2, {
                    loop: true,
                    navigation: {
                        prevEl: ".moei_tab .cont2 .swiper-container .swiper-button-prev",
                        nextEl: ".moei_tab .cont2 .swiper-container .swiper-button-next",
                    },
                    autoplay: {
                        delay: 3000,
                        disableOnInteraction: false,
                    },
                    slidesPerView: 1,
                    pagination: {
                        el: ".swiper-pagination",
                    },
                });
            }
        },
        () => {
            console.log('탭3 스크립트')
        },
        () => {
            console.log('탭4 스크립트')
        },
        () => {
            console.log('탭5 스크립트')
            const quiz = document.querySelectorAll('.event_tab .tit1-quiz .quiz');
            // 정답입력
            const answer = ["X", 2, 3, "O"]
            if (quiz) {
                quiz.forEach((i, idx) => {
                    i.querySelectorAll('span').forEach(ii => {
                        ii.addEventListener('click', () => {
                            // right or wrong
                            if (ii.childNodes[0].nodeValue == answer[idx]) {
                                i.classList.add('right')
                                i.classList.remove('wrong')
                            } else {
                                i.classList.add('wrong');
                                i.classList.remove('right');
                            }
                            // disable
                            i.querySelectorAll('span').forEach(e => {
                                e.classList.add('disable');
                            })
                            ii.classList.remove('disable');
                            // all right?
                            const allRight = document.querySelectorAll('.event_tab .quiz.right');
                            const linkBtn = document.querySelector('.event_tab .cont1-tit1-link button');
                            if (allRight.length == 4) {
                                linkBtn.classList.add('on');
                            } else {
                                linkBtn.classList.remove('on');
                            }
                        })
                    })
                })

                //popup_wrap 관련
                const linkBtn = document.querySelector('.event_tab .cont1-tit1-link button');
                const popup = document.querySelector('.popup_wrap')
                linkBtn.addEventListener('click', () => {
                    if (linkBtn.classList.contains('on')) {
                        popup.classList.add('is-open');
                        document.body.style.overflow = "hidden";
                        document.querySelector('#inpName').focus();
                        // 해제 시 document.body.style.overflow = null;
                    }
                })
            }
        },
    ]
    scripts[idx]();
}

export const TabScripts3p = TabScripts;
export function CommonPage3pTop() {
    setTimeout(() => {
        if (CONSTANT.DEVICE == 'WEB') {
            document.querySelector('.mainPictureWrap .main_effect').classList.add('is-active');
        };
        let targetMainSlide = document.querySelector('.top_container .main_slide');
        targetMainSlide.classList.add('is-active');
        new Swiper('.top_container .main_slide > .swiper-container', {
            loop: true,
            autoplay: {
                delay: 3000
            },
            effect: 'fade',
            fadeEffect: {
                crossFade: true
            },
            allowTouchMove: false,
        });
    }, CONSTANT.DEVICE == 'WEB' ? 500 : 0);

}
import { CONSTANT, SERVICETYPE } from './Constant.js';
import { tabControl } from './Util.js';

// 탭 스크립트
function TabScripts(idx) {
    const scripts = [
        () => {
            console.log('탭1 스크립트')
            // 슬라이드
            const swiperContainer1 = document.querySelector('.raiseup_tab .cont1 .cont1_slide .swiper-container');
            if (swiperContainer1) {
                const swiper1 = new Swiper(swiperContainer1, {
                    loop: true,
                    navigation: {
                        prevEl: ".raiseup_tab .cont1 .cont1_slide .swiper-button-prev",
                        nextEl: ".raiseup_tab .cont1 .cont1_slide .swiper-button-next",
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
                        init() {
                            if (CONSTANT.DEVICE !== 'WEB' && document.querySelector(".raiseup_tab .cont1 .cont1_slide .swiper-button-prev")) {
                                document.querySelector(".raiseup_tab .cont1 .cont1_slide [class*='swiper-button-prev']").style.display = 'none';
                                document.querySelector(".raiseup_tab .cont1 .cont1_slide [class*='swiper-button-next']").style.display = 'none';
                            }
                        },
                    },
                });
            }

            // 슬라이드
            const swiperContainer2 = document.querySelector('.raiseup_tab .cont2 .cont2_slide .swiper-container');
            if (swiperContainer2) {
                const swiper2 = new Swiper(swiperContainer2, {
                    loop: true,
                    navigation: {
                        prevEl: ".raiseup_tab .cont2 .cont2_slide .swiper-button-prev",
                        nextEl: ".raiseup_tab .cont2 .cont2_slide .swiper-button-next",
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
                        init() {
                            if (CONSTANT.DEVICE !== 'WEB' && document.querySelector(".raiseup_tab .cont2 .cont2_slide .swiper-button-prev")) {
                                document.querySelector(".raiseup_tab .cont2 .cont2_slide [class*='swiper-button-prev']").style.display = 'none';
                                document.querySelector(".raiseup_tab .cont2 .cont2_slide [class*='swiper-button-next']").style.display = 'none';
                            }
                        },
                    },
                });
            }

            const swiperContainer3 = document.querySelector('.raiseup_tab .cont3 .cont3_slide .swiper-container');
            if (swiperContainer3) {
                const swiper3 = new Swiper(swiperContainer3, {
                    loop: true,
                    navigation: {
                        prevEl: ".raiseup_tab .cont3 .cont3_slide .swiper-button-prev",
                        nextEl: ".raiseup_tab .cont3 .cont3_slide .swiper-button-next",
                    },
                    // autoplay: {
                    //     delay: 3000,
                    //     disableOnInteraction: false,
                    // },
                    slidesPerView: 1,
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true,
                    },
                    on: {
                        init() {
                            if (CONSTANT.DEVICE !== 'WEB' && document.querySelector(".raiseup_tab .cont3 .cont3_slide .swiper-button-prev")) {
                                document.querySelector(".raiseup_tab .cont3 .cont3_slide [class*='swiper-button-prev']").style.display = 'none';
                                document.querySelector(".raiseup_tab .cont3 .cont3_slide [class*='swiper-button-next']").style.display = 'none';
                            }
                        },
                    },
                });
            }

            // 탭(el>.tab_select>button.is-show, el>.tab_cont>.tabs.is-show)
            if (document.querySelector('.raiseup_tab .cont2_tab_wrap')) {
                tabControl(document.querySelector('.raiseup_tab .cont2_tab_wrap'));
            }
            if (document.querySelector('.raiseup_tab .cont1_tab_wrap')) {
                tabControl(document.querySelector('.raiseup_tab .cont1_tab_wrap'));
            }

            // 퀵메뉴
            const quickmenu = document.querySelector('.quickmenu');
            if (quickmenu) {
                let winTop;
                const quickBtn = quickmenu.querySelectorAll('li button');
                setTimeout(() => {
                    const contTop = [];
                    document.querySelectorAll('.raiseup_tab .conts').forEach(i => {
                        contTop.push(i.offsetTop)
                    })

                    if (SERVICETYPE === "before") {
                        window.addEventListener('scroll', () => {
                            winTop = window.pageYOffset || document.documentElement.scrollTop;
                            if ((winTop < contTop[1])) {
                                quickBtn.forEach(i => i.classList.remove('on'));
                                quickBtn[0].classList.add('on');
                            } else if (winTop > contTop[1] && winTop < contTop[2]) {
                                quickBtn.forEach(i => i.classList.remove('on'));
                                quickBtn[1].classList.add('on');
                            } else if (winTop > contTop[2] && winTop < contTop[3]) {
                                quickBtn.forEach(i => i.classList.remove('on'));
                                quickBtn[2].classList.add('on');
                            } else if (winTop > contTop[3]) {
                                quickBtn.forEach(i => i.classList.remove('on'));
                                quickBtn[3].classList.add('on');
                            }
                        });
                    } else if (SERVICETYPE === "after") {
                        window.addEventListener('scroll', () => {
                            winTop = window.pageYOffset || document.documentElement.scrollTop;
                            if ((winTop < contTop[1])) {
                                quickBtn.forEach(i => i.classList.remove('on'));
                                quickBtn[0].classList.add('on');
                            } else if (winTop > contTop[1] && winTop < contTop[2]) {
                                quickBtn.forEach(i => i.classList.remove('on'));
                                quickBtn[1].classList.add('on');
                            } else if (winTop > contTop[2]) {
                                quickBtn.forEach(i => i.classList.remove('on'));
                                quickBtn[2].classList.add('on');
                            }
                        });
                    }

                    // 스크롤 위치 이동
                    quickBtn.forEach((i, idx) => {
                        i.addEventListener('click', e => {
                            if (!e.currentTarget.classList.contains('.on')) {
                                let toptop = contTop[idx] + 850; // 850은 top_cont
                                document.querySelector('html, body').scroll({ top: toptop, behavior: 'smooth' });
                            }
                        })
                    });
                }, 200);
            };


            // 8문항 시험
            if (document.querySelector('.raiseup_tab button.cont4_exam')) {
                document.querySelector('.raiseup_tab button.cont4_exam').addEventListener('click', () => {
                    document.querySelector('body').style.overflow = 'hidden';
                    fetch8examData()
                        .then((data) => {
                            const swiperContainer3 = document.querySelector('.raiseup_tab .exam_wrap .swiper-container');
                            const swiper3 = new Swiper(swiperContainer3, {
                                // effect: 'fade',
                                navigation: {
                                    prevEl: ".raiseup_tab .exam_wrap .swiper-button-prev",
                                    nextEl: ".raiseup_tab .exam_wrap .swiper-button-next",
                                },
                                slidesPerView: 1,
                                observer: true,
                                observeParents: true,
                                touchRatio: 0,// 슬라이드 드래그 금지, qa/live 에서는 적용필요
                                on: {
                                    // init() {
                                    // if (CONSTANT.DEVICE !== 'WEB' && document.querySelector(".raiseup_tab .cont3 .cont3_slide .swiper-button-prev")) {
                                    //     document.querySelector(".raiseup_tab .cont3 .cont3_slide [class*='swiper-button-prev']").style.display = 'none';
                                    //     document.querySelector(".raiseup_tab .cont3 .cont3_slide [class*='swiper-button-next']").style.display = 'none';
                                    // }
                                    // },
                                    // transitionEnd() {
                                    //     let idx = swiper3.realIndex;
                                    //     if (idx >= 2 && idx <= 9) {
                                    //         document.querySelector(`.exam_wrap .swiper-slide:nth-child(${idx + 1}) .answer_body li:nth-child(${idx - 1}) input`).focus();
                                    //     }
                                    // }
                                },

                            });

                            //슬라이드 이동
                            const slideNext = [
                                ...document.querySelectorAll('.raiseup_tab .exam_wrap .slide_inner > button.next'),
                                document.querySelector('.raiseup_tab .exam_wrap .submit')
                            ];
                            slideNext.forEach((i, idx) => {
                                i.addEventListener('click', e => {
                                    document.querySelector('#exam_next').click();
                                    if (idx == 1) {
                                        if (CONSTANT.DEVICE == 'WEB') {
                                            // 슬라이드 전환 후 포커스
                                            setTimeout(() => {
                                                document.querySelector('.answer_body input').focus();
                                            }, 300);
                                        } else {
                                            document.querySelector('.raiseup_tab .exam_wrap .box_answer').style.display = 'block';
                                            document.querySelector('.raiseup_tab .exam_wrap .submit').style.display = 'block';

                                        }
                                    }
                                    if (idx == 2) {
                                        if (CONSTANT.DEVICE !== 'WEB') {
                                            document.querySelector('.raiseup_tab .exam_wrap .box_answer').style.display = 'none';
                                            document.querySelector('.raiseup_tab .exam_wrap .submit').style.display = 'none';
                                        }

                                    };
                                });
                            })

                            //30분 타이머
                            const startingMinutes = 30; //30분 세팅
                            // const startingMinutes = 6; // 테스트용
                            let time = startingMinutes * 60;
                            let setInter;
                            const countdownEl = document.querySelectorAll('.swiper-slide .timer > span');
                            document.querySelector('.swiper-slide.notice button.next').addEventListener('click', e => {
                                setInter = setInterval(updateCountdown, 1000);
                            });
                            function updateCountdown() {
                                if (time >= 0) {
                                    const minutes = Math.floor(time / 60);
                                    let seconds = time % 60;
                                    seconds = seconds < 10 ? '0' + seconds : seconds;
                                    countdownEl.forEach(i => {
                                        i.innerHTML = `${minutes}:${seconds}`;
                                    })
                                    time--;
                                } else if (time < 0) {
                                    // 결과 제출 시 아래 clearInterval 실행
                                    clearInterval(setInter);
                                    countdownEl.forEach(i => {
                                        i.innerHTML = `00:00`;
                                    })
                                    // 시간 종료 팝업 노출 실행 추가필요
                                    // swiper3.slideTo(4);
                                }
                            };

                            // 모바일 답안지
                            if (CONSTANT.DEVICE !== 'WEB') {
                                const toggleBtn = document.querySelector('.raiseup_tab .exam_wrap .box_answer button.toggle');
                                if (toggleBtn) {
                                    toggleBtn.addEventListener('click', e => {
                                        e.currentTarget.closest('.box_answer').classList.toggle('is-show');
                                    })
                                }
                            };

                            //답 입력 문항 선택 시 해당 문제로 이동
                            const answerBody = document.querySelectorAll('.raiseup_tab .exam_wrap .answer_body li');
                            const boxQuestionImg = document.querySelectorAll('.raiseup_tab .exam_wrap .box_question img');
                            answerBody.forEach((i, idx) => {
                                i.addEventListener('click', e => {
                                    answerBody.forEach(ii => { ii.classList.remove('on') });
                                    answerBody[idx].classList.add('on');
                                    if (CONSTANT.DEVICE == 'WEB' || document.querySelector('.raiseup_tab .exam_wrap .box_answer').classList.contains('is-show')) {
                                        answerBody[idx].querySelector('input').focus();
                                    }

                                    boxQuestionImg.forEach((ii => { ii.classList.remove('on') }));
                                    boxQuestionImg[idx].classList.add('on');
                                    document.querySelector('.raiseup_tab .exam_wrap .move_btns').dataset.index = idx + 1;
                                });
                            });

                            // 문제 이전 다음 버튼
                            const moveBtns = document.querySelectorAll('.raiseup_tab .exam_wrap .move_btns button');
                            let moveIndex;
                            moveBtns.forEach(i => {
                                i.addEventListener('click', e => {
                                    moveIndex = parseInt(document.querySelector('.raiseup_tab .exam_wrap .move_btns').dataset.index);
                                    if (e.currentTarget.classList.contains('prev') && moveIndex !== 1) {
                                        let prev = document.querySelector('.box_question img.on').previousElementSibling;
                                        prev.classList.add('on');
                                        answerBody[moveIndex - 2].click();
                                    }

                                    if (e.currentTarget.classList.contains('next') && moveIndex !== 8) {
                                        let next = document.querySelector('.box_question img.on').nextElementSibling;
                                        next.classList.add('on');
                                        answerBody[moveIndex].click();
                                    }
                                });
                            });

                            // 결과탭
                            const boxTab = document.querySelector('.raiseup_tab .exam_wrap .box_tab_wrap');
                            if (CONSTANT.DEVICE == 'WEB') {
                                tabControl(boxTab);
                            }
                            boxTab.querySelectorAll('.tab_select button').forEach((i, idx) => {
                                i.addEventListener('click', () => {
                                    if (CONSTANT.DEVICE == 'WEB') {
                                        let commentart = boxTab.querySelector('.box_commentary');
                                        if (!commentart.classList.contains('off')) {
                                            boxTab.querySelector('.box_commentary').classList.add('off');
                                        }
                                    } else {
                                        // 모바일 해섦보기
                                        const boxCommentary = document.querySelector('.raiseup_tab .exam_wrap .box_commentary');
                                        const tabs = document.querySelectorAll('.raiseup_tab .exam_wrap .box_commentary .tabs');
                                        boxCommentary.style.display = 'block';
                                        tabs.forEach(ii => { ii.classList.remove('is-show') });
                                        tabs[idx].classList.add('is-show');
                                        boxCommentary.querySelectorAll('.close').forEach(ii => {
                                            ii.addEventListener('click', () => { boxCommentary.style.display = 'none' })
                                        });
                                    }
                                })
                            });

                            // 우클릭 방지
                            const examWrap = document.querySelector('.exam_wrap');
                            function preventRightClick(e) {
                                e.preventDefault();
                                alert('마우스 오른쪽 버튼은 사용할 수 없습니다.');
                            };
                            document.addEventListener('contextmenu', preventRightClick);

                            // 새로고침
                            function preventReload(e) {
                                e.preventDefault();
                                e.returnValue = '';
                            };
                            window.addEventListener('beforeunload', preventReload);

                            // 닫기 버튼
                            examWrap.querySelectorAll('.slide_inner > button.close').forEach(i => {
                                i.addEventListener('click', e => {
                                    examWrap.classList.remove('is-show');
                                    examWrap.innerHTML = null;
                                    document.querySelector('body').style.overflow = null;

                                    // 우클릭방지, 새로고침 event 해제
                                    document.removeEventListener('contextmenu', preventRightClick);
                                    window.removeEventListener('beforeunload', preventReload);
                                })
                            });
                        }); //then 끝
                });
            }
            // CONSTANT.DEVICE == "WEB"
            async function fetch8examData() {
                let data = await fetch(`./modules/6p_module/${CONSTANT.SUBFILENAME}CommonPage-tab1-exam8.html`).then(response => response.text());
                document.querySelector('.raiseup_tab .cont4 .exam_wrap').outerHTML = data;
                return data;
            }
        },
        () => {
            console.log('탭2 스크립트')
            // 슬라이드
            const swiperContainer1 = document.querySelector('.strategy_tab .cont1 .cont1_slidewrap .swiper-container');
            if (swiperContainer1) {
                const swiper1 = new Swiper(swiperContainer1, {
                    // loop: true,
                    // autoplay: {
                    //     delay: 3000,
                    //     disableOnInteraction: false,
                    // },
                    slidesPerView: 1,
                    observer: true,
                    observeParents: true,
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true,
                    },
                });
            };
            const swiperContainer2 = document.querySelector('.strategy_tab .cont3 .cont3_slidewrap .swiper-container');
            if (swiperContainer2) {
                const swiper2 = new Swiper(swiperContainer2, {
                    // loop: true,
                    // autoplay: {
                    //     delay: 3000,
                    //     disableOnInteraction: false,
                    // },
                    slidesPerView: 1,
                    observer: true,
                    observeParents: true,
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true,
                    },
                });
            }

            // 퀵메뉴
            const quickmenu = document.querySelector('.strategy_tab .quickmenu');
            if (quickmenu) {
                let winTop;
                const quickBtn = quickmenu.querySelectorAll('li button');

                setTimeout(() => {
                    const contTop = [];
                    document.querySelectorAll('.strategy_tab .conts').forEach(i => {
                        contTop.push(i.offsetTop)
                    });
                    window.addEventListener('scroll', () => {
                        winTop = window.pageYOffset || document.documentElement.scrollTop;
                        if ((winTop < contTop[1])) {
                            quickBtn.forEach(i => i.classList.remove('on'));
                            quickBtn[0].classList.add('on');
                        } else if (winTop > contTop[1] && winTop < contTop[2]) {
                            quickBtn.forEach(i => i.classList.remove('on'));
                            quickBtn[1].classList.add('on');
                        } else if (winTop > contTop[2] && winTop/*  < contTop[3] */) {
                            quickBtn.forEach(i => i.classList.remove('on'));
                            quickBtn[2].classList.add('on');
                        }
                        // else if (winTop > contTop[3]) {
                        //     quickBtn.forEach(i => i.classList.remove('on'));
                        //     quickBtn[3].classList.add('on');
                        // };
                    });

                    // 스크롤 위치 이동
                    quickBtn.forEach((i, idx) => {
                        i.addEventListener('click', e => {
                            if (!e.currentTarget.classList.contains('.on')) {
                                let toptop = contTop[idx] + 850; // 850은 top_cont
                                document.querySelector('html, body').scroll({ top: toptop, behavior: 'smooth' });
                            }
                        })
                    });
                }, 200);
            };



        },
        () => {
            console.log('탭3 스크립트');
            const swiperContainer1 = document.querySelector('.rehearsal_tab .cont1 .cont1_slidewrap .swiper-container');
            if (swiperContainer1) {
                let option =
                {
                    effect: 'fade',
                    slidesPerView: 1,
                    observer: true,
                    observeParents: true,
                    touchRatio: 0,
                    navigation: {
                        prevEl: ".rehearsal_tab .cont1_slidewrap .swiper-button-prev",
                        nextEl: ".rehearsal_tab .cont1_slidewrap .swiper-button-next",
                    },
                };
                if (CONSTANT.DEVICE !== 'WEB') {
                    option.touchRatio = 1;
                    option.pagination = {
                        el: ".rehearsal_tab .cont1_slidewrap .swiper-pagination",
                        clickable: true,
                    };
                }
                const swiper1 = new Swiper(swiperContainer1, option);
            }



            // 퀵메뉴
            const quickmenu = document.querySelector('.rehearsal_tab .quickmenu');
            if (quickmenu) {
                let winTop;
                const quickBtn = quickmenu.querySelectorAll('li button');

                setTimeout(() => {
                    const contTop = [];
                    document.querySelectorAll('.rehearsal_tab .conts').forEach(i => {
                        contTop.push(i.offsetTop)
                    });
                    window.addEventListener('scroll', () => {
                        winTop = window.pageYOffset || document.documentElement.scrollTop;
                        if ((winTop < contTop[1])) {
                            quickBtn.forEach(i => i.classList.remove('on'));
                            quickBtn[0].classList.add('on');
                        } else if (winTop > contTop[1]) {
                            quickBtn.forEach(i => i.classList.remove('on'));
                            quickBtn[1].classList.add('on');
                        };
                    });

                    // 스크롤 위치 이동
                    quickBtn.forEach((i, idx) => {
                        i.addEventListener('click', e => {
                            if (!e.currentTarget.classList.contains('.on')) {
                                let toptop = contTop[idx] + 850; // 850은 top_cont
                                document.querySelector('html, body').scroll({ top: toptop, behavior: 'smooth' });
                            }
                        })
                    });
                }, 200);



            };



        },
        () => {
            console.log('탭4 스크립트');
            // 미니퀴즈
            const selectOX = document.querySelectorAll('.stamp_tab .cont2_m2 label span');
            const answer = "X";
            selectOX.forEach((i, idx) => {
                i.addEventListener('click', e => {
                    selectOX.forEach(ii => {
                        ii.classList.add('disable');
                    });
                    selectOX[idx].classList.remove('disable');
                    if (e.currentTarget.childNodes[0].nodeValue == answer) {
                        document.querySelector('.stamp_tab .cont2_m2').classList = 'cont2_m2 right';
                    } else {
                        document.querySelector('.stamp_tab .cont2_m2').classList = 'cont2_m2 wrong';
                    }
                })
            })


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

export const TabScripts6p = TabScripts;
export function CommonPage6pTop() {
    if (SERVICETYPE === "before") {
        setTimeout(() => {
            document.querySelector('.top_cont_6p.before .visual_wrap').classList.add('is-active');
        }, 500);
        document.querySelector(".main_wrap .tab_wrap").classList.add("before");
    }
    else if (SERVICETYPE === "after") {
        setTimeout(() => {
            document.querySelector('.top_cont_6p.after .visual_wrap').classList.add('is-active');
        }, 500);
        document.querySelector(".main_wrap .tab_wrap").classList.add("after");
    }

}

import { CONSTANT, SERVICETYPE } from './Constant.js';
import { tabControl } from './Util.js';

export default function CommonPage9pExam8() {
    if (SERVICETYPE === "before") {
        // 8문항 시험
        if (document.querySelector('.exam_wrap')) {
            const examWrap = document.querySelector('.exam_wrap');

            const examSwiper = document.querySelector('.exam_wrap .swiper-container');
            const swiper3 = new Swiper(examSwiper, {
                // effect: 'fade',
                navigation: {
                    prevEl: ".exam_wrap .swiper-button-prev",
                    nextEl: ".exam_wrap .swiper-button-next",
                },
                slidesPerView: 1,
                observer: true,
                observeParents: true,
                touchRatio: 0,// 슬라이드 드래그 금지, qa/live 에서는 적용필요
            });

            //슬라이드 이동
            const slideNext = [
                ...document.querySelectorAll('.exam_wrap .slide_inner > button.next'),
                document.querySelector('.exam_wrap .submit')
            ];

            slideNext.forEach((i, idx) => {
                i.addEventListener('click', e => {
                    document.querySelector('.exam_wrap #exam_next').click();
                    if (idx == 1) {
                        if (CONSTANT.DEVICE == 'WEB') {
                            // 슬라이드 전환 후 포커스
                            setTimeout(() => {
                                document.querySelector('.exam_wrap .answer_body input').focus();
                            }, 300);
                        } else {
                            document.querySelector('.exam_wrap .box_answer').style.display = 'block';
                            document.querySelector('.exam_wrap .submit').style.display = 'block';

                        }
                    }
                    if (idx == 2) {
                        if (CONSTANT.DEVICE !== 'WEB') {
                            document.querySelector('.exam_wrap .box_answer').style.display = 'none';
                            document.querySelector('.exam_wrap .submit').style.display = 'none';
                        }

                    };
                });
            })

            //30분 타이머
            const startingMinutes = 30; //30분 세팅
            // const startingMinutes = 6; // 테스트용
            let time = startingMinutes * 60;
            let setInter;
            const countdownEl = document.querySelectorAll('.exam_wrap .swiper-slide .timer > span');
            document.querySelector('.exam_wrap .swiper-slide.notice button.next').addEventListener('click', e => {
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
                const toggleBtn = document.querySelector('.exam_wrap .box_answer button.toggle');
                if (toggleBtn) {
                    toggleBtn.addEventListener('click', e => {
                        e.currentTarget.closest('.box_answer').classList.toggle('is-show');
                    })
                }
            };

            //답 입력 문항 선택 시 해당 문제로 이동
            const answerBody = document.querySelectorAll('.exam_wrap .answer_body li');
            const boxQuestionImg = document.querySelectorAll('.exam_wrap .box_question img');
            answerBody.forEach((i, idx) => {
                i.addEventListener('click', e => {
                    answerBody.forEach(ii => { ii.classList.remove('on') });
                    answerBody[idx].classList.add('on');
                    if (CONSTANT.DEVICE == 'WEB' || document.querySelector('.exam_wrap .box_answer').classList.contains('is-show')) {
                        answerBody[idx].querySelector('input').focus();
                    }

                    boxQuestionImg.forEach((ii => { ii.classList.remove('on') }));
                    boxQuestionImg[idx].classList.add('on');
                    document.querySelector('.exam_wrap .move_btns').dataset.index = idx + 1;
                });
            });

            // 문제 이전 다음 버튼
            const moveBtns = document.querySelectorAll('.exam_wrap .move_btns button');
            let moveIndex;
            moveBtns.forEach(i => {
                i.addEventListener('click', e => {
                    moveIndex = parseInt(document.querySelector('.exam_wrap .move_btns').dataset.index);
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
            const boxTab = document.querySelector('.exam_wrap .box_tab_wrap');
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
                        const boxCommentary = document.querySelector('.exam_wrap .box_commentary');
                        const tabs = document.querySelectorAll('.exam_wrap .box_commentary .tabs');
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

            // // 닫기 버튼
            // examWrap.querySelectorAll('.slide_inner > button.close').forEach(i => {
            //     i.addEventListener('click', e => {
            //         examWrap.classList.remove('is-show');
            //         examWrap.innerHTML = null;
            //         document.querySelector('body').style.overflow = null;

            //         // 우클릭방지, 새로고침 event 해제
            //         document.removeEventListener('contextmenu', preventRightClick);
            //         window.removeEventListener('beforeunload', preventReload);
            //     })
            // });
        }
    }
}

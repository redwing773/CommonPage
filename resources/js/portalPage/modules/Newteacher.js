// 강새채용
import { CONSTANT, SERVICETYPE } from './Constant.js';
export default function NewTeacherTop() {

    function initMotion() {
        setTimeout(() => {
            document.querySelector('.title_wrap').classList.add('on')
        }, 100)
    }
    document.addEventListener('DomContentLoaded', initMotion());
    document.removeEventListener('DomContentLoaded', initMotion);

    // 마우스로 대상 움직임
    function mouseMovement() {
        // Movement Animation to happen
        const wrap = document.querySelector('.top_main');
        const target = document.querySelector('h1');

        let evt_move, evt_enter, evt_leave;

        if (CONSTANT.DEVICE === "WEB") {
            evt_move = "mousemove";
            evt_enter = "mouseenter";
            evt_leave = "mouseleave";
        } else {
            evt_move = "touchmove";
            evt_enter = "touchstart";
            evt_leave = "touchend";
            let isInside = false;
        }

        // Moving Animation Event
        wrap.addEventListener(evt_move, (e) => {
            let xAxis = CONSTANT.DEVICE === "WEB" ? (window.innerWidth / 2 - e.pageX) / 20 : e.touches[0].clientX / 15;
            let yAxis = CONSTANT.DEVICE === "WEB" ? (window.innerHeight / 2 - e.pageY) / 20 : e.touches[0].clientY / 15;
            target.style.transform = `rotateY(${yAxis}deg) rotateX(${xAxis}deg)`;

            if (e.type === "touchmove") {
                const rect = wrap.getBoundingClientRect();
                let touchX = e.touches[0].clientX;
                let touchY = e.touches[0].clientY;

                if (
                    touchX < rect.left ||
                    touchX > rect.right ||
                    touchY < rect.top ||
                    touchY > rect.bottom
                ) {
                    isInside = false;
                }
            }
        });

        // Animate In
        wrap.addEventListener(evt_enter, (e) => {
            target.style.transition = 'none';
            target.style.willChange = 'transform';
            if (e.type === "touchstart") {
                isInside = true;
            }
        });

        // Animate Out
        wrap.addEventListener(evt_leave, (e) => {
            if (typeof isInside === "undefined" || !isInside) {
                target.style.transition = 'all .6s ease .6s';
                target.style.transform = `rotateY(0deg) rotateX(0deg)`;
                target.style.willChange = 'auto';
            }
        });
    };
    mouseMovement();

    // 스와이퍼
    const option = {
        loop: true,
        // autoplay: { delay: 3000 },
        navigation: {
            prevEl: ".swiper-button-prev",
            nextEl: ".swiper-button-next",
        },
        pagination: {
            el: ".swiper-pagination",
            type: 'fraction',
        },
        slidesPerView: 'auto',
        centeredSlides: true,
        spaceBetween: 180,
        // width: 260,
        // effect: "fade, cube , coverflow, flip,
        observer: true,
        observeParents: true,
    };
    const tabSlides = [
        new Swiper('.cont_newteacher .cont1_slide .swiper-container', option),
        // new Swiper('.top_cont_contest .cont2_tab_wrap .tab2_slide', option)
    ];

    // 커스텀 셀렉트박스
    function customSelectBox() {
        const customSelect = document.querySelectorAll('.select_wrap');
        customSelect.forEach(i => {
            const label = i.querySelector('.label');
            const options = i.querySelectorAll('.optionItem');
            // 클릭한 옵션의 텍스트를 라벨 안에 넣음
            const handleSelect = (item) => {
                i.classList.remove('active');
                label.querySelector('.selected').innerHTML = item.textContent;
            };
            // 옵션 클릭시 클릭한 옵션을 넘김
            options.forEach(option => {
                option.addEventListener('click', () => handleSelect(option))
            });
            // 라벨을 클릭시 옵션 목록이 열림/닫힘
            label.addEventListener('click', (e) => {
                e.stopPropagation();
                if (i.classList.contains('active')) {
                    i.classList.remove('active');
                } else {
                    i.classList.add('active');
                }
            });
        });
        document.addEventListener('click', () => {
            customSelect.forEach(i => {
                if (i.classList.contains('active')) {
                    i.classList.remove('active');
                }
            })
        });
    };
    customSelectBox();

    // textarea 텍스트 카운트
    function textAreaCount() {
        const textarea = document.querySelector('.textarea_wrap textarea');
        const count = document.querySelector('.text_counter .count');
        textarea.addEventListener('keydown', (e) => {
            let num = e.currentTarget.value.length;
            count.innerHTML = num;
        });
    }
    textAreaCount();









}
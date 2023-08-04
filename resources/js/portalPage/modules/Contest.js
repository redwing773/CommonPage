// 문항공모전
import { isIE } from '../ui.js';
export default function ContestTop() {
    // ie일 경우 webp를 png로 변경
    if (isIE) {
        document.querySelector('.top_main_title img').setAttribute('src', 'https://resource-portal.etoos.com/common-page/static/contest_top_main_title.png');
    }

    // 탭
    const btns = document.querySelectorAll('.top_cont_contest .cont2_tab_wrap .tab_select button');
    const tabs = document.querySelectorAll('.top_cont_contest .cont2_tab_wrap .tab_cont .tabs');
    btns.forEach(i => {
        i.addEventListener('click', e => {
            if (!e.currentTarget.classList.contains('is-show')) {
                btns.forEach(ii => { ii.classList.remove('is-show'); });
                i.classList.add('is-show');
                let idxNum = Array.from(btns).indexOf(e.currentTarget);
                let tar = tabs.item(idxNum);
                tabs.forEach(iii => { iii.classList.remove('is-show'); })
                tar.classList.add('is-show');
                tabSlides[idxNum].slideTo(0);
                tabSlides[idxNum].update();
            }
        });
    });

    // 스와이퍼
    const option = {
        // loop: true,
        // autoplay: { delay: 3000 },
        slidesPerView: '1',
        // centeredSlides: true,
        spaceBetween: 6,
        width: 260,
        // effect: "fade, cube , coverflow, flip,
        observer: true,
        observeParents: true,
    };

    const tabSlides = [
        new Swiper('.top_cont_contest .cont2_tab_wrap .tab1_slide', option),
        new Swiper('.top_cont_contest .cont2_tab_wrap .tab2_slide', option)
    ];

    // 복사하기 버튼
    const copyBtn = document.querySelector('.top_cont_contest .cont3 .copy_btn');
    if (copyBtn) {
        copyBtn.addEventListener('click', () => {
            navigator.clipboard.writeText('contest@etoos.com');
            alert("이메일 주소가\n복사되었습니다.");
        });
    }
}
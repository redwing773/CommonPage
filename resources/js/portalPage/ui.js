// portalPageGate js
import CONSTANT from './modules/Constant.js';
import TabsFunc from './modules/TabsFunc.js';

async function fetchHtmlAsText(url,tar) {
    let data = await fetch(url).then(response => response.text());
    if(tar) {
        document.querySelector(tar).innerHTML = data;
    }
    return data;
}
async function importPage(target) {
    // 탑 배너
    await fetchHtmlAsText(`./modules/${CONSTANT.SUBFILENAME}portalPageTopBanner.html`,'#' + target[0]);
    
    // 탑 콘텐츠
    let div = document.createElement('div');
    div.id = 'tempDiv';
    document.querySelector(`#${target[1]}`).prepend(div);
    const response = await fetchHtmlAsText(`./modules/${CONSTANT.SUBFILENAME}portalPageGateTopContent.html`);
    document.querySelector('#tempDiv').outerHTML = response;
    setTimeout(() => {
        if(CONSTANT.DEVICE == 'WEB'){
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
    

    // 푸터
    await fetchHtmlAsText(`./modules/${CONSTANT.SUBFILENAME}portalPageFooter.html`,'#' + target[2]);
}
importPage(['topBn', 'top_content', 'footer']);

// tab
document.addEventListener('DOMContentLoaded',new TabsFunc);

// 새로고침 시 항상 scroll top0
history.scrollRestoration = 'manual';

// 포털GNB로드 후 스크롤
const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
    if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
        window.scroll({top:CONSTANT.DEVICE == 'WEB' ? 100 : 50,behavior:'smooth'});
        setTimeout(() => { observer.disconnect() }, 0);
    }
    });
});
// observer를 특정 요소에 연결합니다.
observer.observe(document.querySelector('#portalGnb'), { childList: true });
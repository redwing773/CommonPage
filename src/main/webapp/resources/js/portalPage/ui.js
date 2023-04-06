// portalPageGate js

// top banner include
async function fetchHtmlAsText(url) {
    return await (await fetch(url)).text();
}
async function importPage(target) {
    document.querySelector('#' + target[0]).innerHTML = await fetchHtmlAsText('./views/portalPageTopBanner.html');
    
    let div = document.createElement('div');
    div.id = 'tempDiv';
    document.querySelector(`#${target[1]}`).prepend(div);
    await fetchHtmlAsText('./views/portalPageGateTopContent.html')
    .then(response => {
        document.querySelector('#tempDiv').outerHTML = response;
    })
    .then(() => {
        setTimeout(() => {
            document.querySelector('.mainPictureWrap .main_effect').classList.add('is-active');
            let targetMainSlide = document.querySelector('.top_container .main_slide');
            targetMainSlide.classList.add('is-active');
            const swiper = new Swiper('.top_container .main_slide > .swiper-container', {
                loop: true,
                autoplay: {
                    delay: 3000
                },
                effect : 'fade',
                fadeEffect: { 
                    crossFade: true 
                },
                allowTouchMove: false,
            });
        } ,500)
    });

    document.querySelector('#' + target[2]).innerHTML = await fetchHtmlAsText('./views/portalPageFooter.html');
}
importPage(['topBn','top_content','footer']);

// tab
class TabsFunc{
    constructor(){
        this.urls = [
            "./views/portalPageGate-tab1.html",
            "./views/portalPageGate-tab2.html",
            "./views/portalPageGate-tab3.html",
            "./views/portalPageGate-tab4.html",
            "./views/portalPageGate-tab5.html"
        ];
        this.tabInit = true;
        this.tabLoad = [];
        for(let i = 1;i <= this.urls.length; i++){
            this.tabLoad.push(false);
        }
        let random = (Math.floor(Math.random() * this.urls.length));
        this.tabsFn(this.urls[random],random);
        const onTab = document.querySelectorAll('.tab_head li a');
        onTab[random].classList.add('on');
        this.eventTabClick();
        this.eventTabHead();
        this.eventTabHeadTooltip();
        this.sibilingTab(this.urls, random)
    }

    tabsFn(url, index){
        // 최초실행 체크
        if(this.tabInit == true){
            let urlLen = this.urls.length;
            for(let i = 1;i <= urlLen;i++){
                let div = document.createElement('div');
                div.classList.add('tab-content-wrap');
                document.querySelector('.tab_wrap .tab_body').append(div);
            }
            this.tabInit = false;
        }

        // 탭 변경
        function tabChange(index){
            const tabContWrap = document.querySelectorAll('.tab_wrap .tab_body .tab-content-wrap');
            tabContWrap[index].style.display = 'block';
            let thisSiblings = function(){
                return [...tabContWrap[index].parentElement.children].filter(e => e != tabContWrap[index]);
            }();
            thisSiblings.forEach( i => {
                i.style.display = "none";
            })
            TabsFunc.eventTabScript(index);
        };

        // 탭 로드 체크 후 로드
        if(this.tabLoad[index] == false){
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
    eventTabClick(){
        const _tabHeadBtn = document.querySelectorAll('.tab_wrap .tab_head ul li a');
        _tabHeadBtn.forEach((i,index) => {
            i.addEventListener('click', e => {
                if(!i.classList.contains('on')){
                    setTimeout(() => {
                        let tabBodyTop = document.querySelector('.tab_wrap').offsetTop;
                        window.scroll({top:tabBodyTop,behavior:'smooth'});
                    },50)
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
    static eventTabScript(idx){
        const tabScripts = [  
            () => { console.log('탭1 스크립트')
                const swiperContainer = document.querySelector('.cont1 .tit1-slide .swiper-container');
                if (swiperContainer) {
                    const swiper = new Swiper(swiperContainer, {
                        loop:true,
                        navigation: {
                            prevEl : ".cont1 .tit1-slide .swiper-container .swiper-button-prev",
                            nextEl: ".cont1 .tit1-slide .swiper-container .swiper-button-next",
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
            () => { console.log('탭2 스크립트')
                const swiperContainer2 = document.querySelector('.moei_tab .cont2 .tit2-slide .swiper-container');
                if(swiperContainer2){
                    const swiper = new Swiper(swiperContainer2, {
                        loop:true,
                        navigation: {
                            prevEl : ".moei_tab .cont2 .swiper-container .swiper-button-prev",
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
            () => { console.log('탭3 스크립트')
            },
            () => { console.log('탭4 스크립트')
            },
            () => { console.log('탭5 스크립트')
                const quiz = document.querySelectorAll('.event_tab .tit1-quiz .quiz');
                // 정답입력
                const answer = ["X",2,3,"O"]
                if (quiz) {
                    quiz.forEach((i,idx) => {
                        i.querySelectorAll('span').forEach(ii => {
                            ii.addEventListener('click',() => {
                                // right or wrong
                                if(ii.childNodes[0].nodeValue == answer[idx]){
                                    i.classList.add('right')
                                    i.classList.remove('wrong')
                                } else{
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
                                if(allRight.length == 4){
                                    linkBtn.classList.add('on');
                                } else{
                                    linkBtn.classList.remove('on');
                                }
                            })
                        })
                    })
                    
                    //popup_wrap 관련
                    const linkBtn = document.querySelector('.event_tab .cont1-tit1-link button');
                    const popup = document.querySelector('.popup_wrap')
                    linkBtn.addEventListener('click',() => {
                        if(linkBtn.classList.contains('on')){
                            popup.classList.add('is-open');
                            document.body.style.overflow = "hidden";
                            document.querySelector('#inpName').focus();
                            // 해제 시 document.body.style.overflow = null;
                        }
                    })
                }
            },
        ]
        tabScripts[idx]();
    }

    eventTabHead(){
        const tabHead = document.querySelector('.tab_head');
        let winTop;
        const toTop = document.querySelector('.toTop');
        const tabBodyTop = document.querySelector('.tab_wrap').offsetTop;

        // top버튼
        toTop.querySelector('button').addEventListener('click',() => {
            window.scroll({top:0,behavior:'smooth'});
        })

        window.addEventListener('scroll', () => {
            winTop = window.pageYOffset || document.documentElement.scrollTop;
            const tabHeadY = tabHead.parentElement.offsetTop;
            if(winTop >= tabHeadY){
                tabHead.classList.add('fixed');
            }else{
                tabHead.classList.remove('fixed');
            }

            if(winTop - 60 >= tabHeadY){
                tabHead.classList.add('hide');
            } else{
                tabHead.classList.remove('hide');
            }

            // top 노출
            if(winTop > tabBodyTop){
                toTop.classList.add('on');
            } else{
                toTop.classList.remove('on');
            }
        });
    }

    eventTabHeadTooltip(){
        const tar = document.querySelectorAll('.tab_head li');
        tar.forEach(i => {
            i.addEventListener('mouseover',() => {
                if(!i.querySelector('a').classList.contains('on')){
                    document.querySelector('.tab_head li a.on .tooltip').style.opacity = '0';
                }
                i.querySelector('a .tooltip').style.opacity = '1';
            });
            i.addEventListener('mouseout',() => {
                if(!i.querySelector('a').classList.contains('on')){
                    document.querySelector('.tab_head li a.on .tooltip').style.opacity = '1';
                } else{
                    return false;
                }
                i.querySelector('a .tooltip').style.opacity = '0';
            });
        })
    }

    sibilingTab(urls, index){
        for(let i = 0; i <= urls.length - 1; i++){
            if(index !== i){
                // 나머지 탭 호출
                fetch(urls[i])
                .then(response => response.text())
                .then(data => {
                    document.querySelectorAll(".tab_wrap .tab_body .tab-content-wrap")[i].innerHTML = data;
                })
                this.tabLoad[i] = true;
            }
        }
    }
}
document.addEventListener('DOMContentLoaded',new TabsFunc);

// 새로고침 시 항상 scroll top0
history.scrollRestoration = 'manual';


// 포털GNB로드 후 스크롤
const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
    if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
        window.scroll({top:100,behavior:'smooth'});
        setTimeout(()=>{ observer.disconnect() },0);
        
    }
    });
});
// observer를 특정 요소에 연결합니다.
observer.observe(document.querySelector('#portalGnb'), { childList: true });
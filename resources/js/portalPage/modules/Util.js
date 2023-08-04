// D-day counter
export function DdayCounter(targetEl, date) {
     let tar = document.querySelector(targetEl); // 타겟 ex> '#topBn .count_wrap .num'
     if (tar) {
          let dday = date; // D-day ex> '2023-06-01T23:59:59'
          ddayCount(dday, tar);
     }

     function ddayCount(day, tar) { //  day=D-day, tar=입력타켓
          // D-day 설정
          let targetDate = new Date(day);
          let targetTimestamp = targetDate.getTime();
          // 현재 날짜와 시간 정보
          let now = new Date();
          let nowTimestamp = now.getTime();

          // 남은 시간 계산
          let remaining = targetTimestamp - nowTimestamp;

          // 남은 일수 계산
          let days = Math.floor(remaining / (1000 * 60 * 60 * 24));

          if (days == 0) {
               tar.innerHTML = '-DAY';
          } else if (days < 0) {
               days = Math.abs(days)
               console.log('days', days);
               tar.innerHTML = `+${days}`;
          } else {
               function counterFn(days) {
                    let cntNum = 0;
                    let interval = setInterval(count0Fn, 30);
                    function count0Fn() {
                         cntNum++;
                         if (cntNum > days) {
                              clearInterval(interval);
                         } else {
                              tar.innerHTML = `-${cntNum}`;
                         }
                    }
               }
               counterFn(days);
          }
     }
}

// 탭 -- (태그 구조 : el>.tab_select>button.is-show, el>.tab_cont>.tabs.is-show)
export function tabControl(el) {
     const btns = el.querySelectorAll('.tab_select button');
     const tabs = el.querySelectorAll('.tab_cont .tabs');
     btns.forEach((i, idx) => {
          i.addEventListener('click', e => {
               e.stopPropagation();
               if (!e.currentTarget.classList.contains('is-show')) {
                    btns.forEach(ii => ii.classList.remove('is-show'));
                    tabs.forEach(iii => iii.classList.remove('is-show'));
                    i.classList.add('is-show');
                    tabs[idx].classList.add('is-show');
               }
          });
     });
}

// 퀵버튼 (태그구조 - 퀵메뉴 : section(각 탭)>.quickmenu>ul>li>button, 대상콘텐츠 : section .conts갯수 체크
export function quickMenu(el, topH) {
     const quickmenu = document.querySelector(el);// '.tab2 .quickmenu';
     topH = topH || 850;// 850 - top_cont
     if (quickmenu) {
          let winTop;
          const quickBtn = quickmenu.querySelectorAll('li button');

          setTimeout(() => {
               const contTop = [];
               quickmenu.closest('section').querySelectorAll('.conts').forEach(i => {
                    contTop.push(i.offsetTop - topH);
               });
               window.addEventListener('scroll', () => {
                    winTop = window.pageYOffset || document.documentElement.scrollTop;
                    if ((winTop < contTop[1])) {
                         quickBtn.forEach(i => i.classList.remove('on'));
                         quickBtn[0].classList.add('on');
                    }
                    else if (contTop.length == 2 ?
                         winTop > contTop[1] :
                         winTop > contTop[1] && winTop < contTop[2]) {
                         quickBtn.forEach(i => i.classList.remove('on'));
                         quickBtn[1].classList.add('on');
                    }
                    else if (contTop.length == 3 ?
                         winTop > contTop[2] :
                         winTop > contTop[2] && winTop < contTop[3]) {
                         quickBtn.forEach(i => i.classList.remove('on'));
                         quickBtn[2].classList.add('on');
                    }
                    else if (contTop.length == 4 ?
                         winTop > contTop[3] :
                         winTop > contTop[3] && winTop < contTop[4]) {
                         quickBtn.forEach(i => i.classList.remove('on'));
                         quickBtn[3].classList.add('on');
                    }
                    else if (contTop.length == 5 ?
                         winTop > contTop[4] :
                         false) {
                         quickBtn.forEach(i => i.classList.remove('on'));
                         quickBtn[4].classList.add('on');
                    };
               });

               // 스크롤 위치 이동
               quickBtn.forEach((i, idx) => {
                    i.addEventListener('click', e => {
                         if (!e.currentTarget.classList.contains('.on')) {
                              let toptop = contTop[idx] + topH;
                              document.querySelector('html, body').scroll({ top: toptop, behavior: 'smooth' });
                         }
                    })
               });
          }, 200);
     };
}


// 버튼 ripple effect
export function rippleEffect() {
     document.querySelectorAll('[data-ripple="true"]').forEach((i) => {
          if (i.classList.contains('hasRipple')) { return; }

          i.classList.add('hasRipple');
          i.addEventListener("click", e => {
               const ripple = document.createElement("div");
               const rect = i.getBoundingClientRect();
               ripple.className = "animate";
               ripple.style.left = `${e.x - rect.left}px`;
               ripple.style.top = `${e.y - rect.top}px`;
               ripple.style.background = `#${i.dataset.color !== undefined ? i.dataset.color : "bdc3c7"}`;
               ripple.style.setProperty("--material-scale", i.offsetWidth);
               i.append(ripple);
               setTimeout(() => {
                    ripple.parentNode.removeChild(ripple)
               }, 410)
          });
     });
}
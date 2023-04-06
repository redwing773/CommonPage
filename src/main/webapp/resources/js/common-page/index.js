import portalServiceApi from "../api/PortalServiceApi.js";
import portalFunctionApi from "../api/PortalFunctionApi.js";
import FunctionType from "./FunctionType.js";
import commonUtils from "../util/CommonUtils.js";
import bannerConstant from "../banner/BannerConstant.js";
import submit from "../Submit.js";

let isCompleteInitTab = false;
let isEventApply = false;
const answers = ["X", 2, 3, "O"];
const deviceType = {
    web: {
        init: function (response) {
            commonPage.initWeb(response);
        },
        activeSlide: function (tabIndex) {
            tab.activeWebSlide(tabIndex)
        },
        initBaseScroll: function () {
            const selectTabClass = $('#select_tab').val();
            if (!commonUtils.isEmpty(selectTabClass)) {
                return;
            }

            setTimeout(function () {
                $('html,body').animate({scrollTop: 100}, 500);
            }, 0);
        }
    },
    mobile: {
        init: function (response) {
            commonPage.initMobile(response);
        },
        activeSlide: function (tabIndex) {
            tab.activeMobileSlide(tabIndex);
        },
        initBaseScroll: function () {

        }
    }
};

const currentDevice = commonUtils.isMobile() ? 'mobile' : 'web';

const activeProfile = commonUtils.getSystemMode();
if (activeProfile === 'dev' || activeProfile === 'qa') {
    $('.main_wrap').addClass('after');
} else if (activeProfile === 'live') {
    // 사후페이지 이후
    if (1679558400000 < new Date().getTime()) {
        $('.main_wrap').addClass('after');
    }
}

$(function () {
    history.scrollRestoration = 'manual';
    commonPage.load();
    deviceType[currentDevice].initBaseScroll();
});

$(document).on('click', '.event_tab .tit1-quiz .quiz .rdo_wrap span',
    function (e) {
        e.preventDefault();

        const quizIndex = $(e.currentTarget).parents('.quiz').index();
        const answer = $(e.currentTarget).text();

        $(e.currentTarget).parents('.rdo_wrap').find('span').addClass(
            'disable');
        $(e.currentTarget).removeClass('disable');

        $(e.currentTarget).parents('.rdo_wrap').find('input[type=radio]').prop(
            'checked', false);
        $(e.currentTarget).siblings('input[type=radio]').prop('checked', true);

        if (answers[quizIndex] == answer) {
            $(e.currentTarget).parents('.quiz').removeClass('wrong');
            $(e.currentTarget).parents('.quiz').addClass('right');
        } else {
            $(e.currentTarget).parents('.quiz').removeClass('right');
            $(e.currentTarget).parents('.quiz').addClass('wrong');
        }

        const allRight = document.querySelectorAll('.event_tab .quiz.right');
        const linkBtn = document.querySelector(
            '.event_tab .cont1-tit1-link button');
        if (allRight.length == 4 && !isEventApply) {
            linkBtn.classList.add('on');
        } else {
            linkBtn.classList.remove('on');
        }
    });

$(document).on('click', '.event_tab .cont1-tit1-link button', function (e) {
    e.preventDefault();

    if (!$(e.currentTarget).hasClass('on')) {
        return;
    }

    $('.popup_wrap .popup-box').show();
    const popup = document.querySelector('.popup_wrap');
    popup.classList.add('is-open');
    document.body.style.overflow = "hidden";
    document.querySelector('#inpName').focus();
});

$(document).on('click', '.agree-box button', function (e) {
    e.preventDefault();

    const popupId = $(e.currentTarget).find('span.blind').data('popup-id');
    $('.popup-s-box').removeClass('is-open');
    $('#' + popupId).addClass('is-open');
});

$(document).on('click', '.agree-box input[type=checkbox]', function (e) {
    event.toggleActiveApply();
});

if (!commonUtils.isMobile()) {
    $(document).on('mouseover', '.tab_head li', function (e) {
        e.preventDefault();

        $('.tab_head').find('.tooltip').css('opacity', 0);
        $(e.currentTarget).find('.tooltip').css('opacity', 1);
    });

    $(document).on('mouseout', '.tab_head li', function (e) {
        e.preventDefault();

        $('.tab_head').find('.tooltip').css('opacity', 0);
        $('.tab_head li').each(function (i, e) {
            $(e).find('a.on').find('.tooltip').css('opacity', 1);
        });
    });
}

$(document).on('click', '.tab-item', function (e) {
    e.preventDefault();
    const isSwitchTab = !$(e.currentTarget).hasClass('on');

    if (!commonUtils.isMobile()) {
        $(this).parent('li').find('a .tooltip').css('opacity', 0);
        $(this).find('.tooltip').css('opacity', 1);
    }

    $('.tab-item').removeClass('on');
    $(e.currentTarget).addClass('on');

    const tabIndex = $(e.currentTarget).parent('li').index();
    $('.tab-content-wrap').hide();
    $('.tab-content-wrap').eq(tabIndex).show();
    deviceType[currentDevice].activeSlide(tabIndex);

    if (isSwitchTab && isCompleteInitTab) {
        let tabBodyTop = document.querySelector('.tab_wrap').offsetTop;
        $('html,body').animate({scrollTop: tabBodyTop}, 500);
    }
});

$(document).on('keyup', '#inpName', function (e) {
    event.toggleActiveApply();
});

$(document).on('keyup', '#inpAddr2', function (e) {
    $('#address_detail').val($(e.currentTarget).val());
    event.toggleActiveApply();
});

$(document).on('keyup', '#inpPhone', function (e) {
    const phoneNode = $(e.currentTarget);
    let phone = phoneNode.val();
    if (phone.length > 11) {
        phoneNode.val(phone.substring(0, 11));
    }

    const phoneOnlyNumber = phoneNode.val().replace(/[^0-9]/g, '');
    phoneNode.val(phoneOnlyNumber);

    event.toggleActiveApply();
});

$(document).on('keyup', '#event_select_phone', function (e) {
    const phoneNode = $(e.currentTarget);
    let phone = phoneNode.val();
    if (phone.length > 11) {
        phoneNode.val(phone.substring(0, 11));
    }

    const phoneOnlyNumber = phoneNode.val().replace(/[^0-9]/g, '');
    phoneNode.val(phoneOnlyNumber);
});

$(document).on('click', '#inpAddr1, #inpAddrBtn', function (e) {
    new daum.Postcode({
        oncomplete: function (data) {
            const viewAddress = '(' + data.zonecode + ') ' + data.address;
            $('#inpAddr1').val(viewAddress);
            $('#inpAddr1').trigger('change');
            $('#address').val(data.address);
            $('#zipcode').val(data.zonecode);
            event.toggleActiveApply();
        }
    }).open();
});

$(document).on('click', 'input[name=inpGos]', function (e) {
    event.toggleActiveApply();
});

$(document).on('click', '.submit.on', function (e) {
    e.preventDefault();
    if(submit.isDuplicateRequest()){
        return;
    }
    event.apply();
});

$(document).on('click', '#event_check_btn', function (e) {
    e.preventDefault();
    $('.popup_wrap .popup-box').hide();
    $('#event_select').addClass('is-open');
    $('.popup_wrap').addClass('is-open');
});

$(document).on('click', '.popup-box .closeBtn', function () {
    document.body.style.overflow = null;
});

$(document).on('click', '.popup-box .box-bot', function () {
    document.body.style.overflow = null;
});

$(document).on('click', '.toTop button', function () {
    window.scroll({top: 0, behavior: 'smooth'});
});

$(document).on('click', '#event_select a[name=confirm]', function (e) {
    $('#event_select_download').find('input[type=radio]').prop('checked',
        false);
    $('#event_select_download').find('a[name=confirm]').removeClass('on');
    event.checkApplyUser();
});

$(document).on('click', '#event_select_download a[name=confirm].on',
    function (e) {
        const gradeNode = $('#event_select_download').find(
            'input[type=radio]:checked');
        const filePath = gradeNode.data('file-path');
        const fileName = gradeNode.data('file-name');

        location.href = portalFunctionApi.getUrl() + '/view/download?file_name='
            + encodeURIComponent(fileName) + '&path=' + encodeURIComponent(
                filePath);
        e.currentTarget.closest('.popup_wrap').classList.remove('is-open');
        e.currentTarget.closest('.popup-s-box').classList.remove('is-open');
        document.querySelector('body').style.overflow = null;
    });

$(document).on('click', '#complete_popup a[name=confirm]', function (e) {
    const gradeNode = $('#event_apply_grade').find('input[type=radio]:checked');
    const filePath = gradeNode.data('file-path');
    const fileName = gradeNode.data('file-name');
    location.href = portalFunctionApi.getUrl() + '/view/download?file_name='
        + encodeURIComponent(fileName) + '&path=' + encodeURIComponent(
            filePath);
});

$(document).on('click', '.event_close_reset', function (e) {
    $('#inpName').val('');
    $('#inpPhone').val('');
    $('#inpAddr1').val('');
    $('#inpAddr2').val('');
    $('input[name=inpGos]').prop('checked', false);
    $('input[name=agrees]').prop('checked', false);
    $('.submit').removeClass('on');
});

$(document).on('click', '.event_select_close_reset', function (e) {
    $('#event_select_name').val('');
    $('#event_select_phone').val('');
});

const commonPage = {
    load: function () {
        portalServiceApi.get('/common-page/current', {}, function (data) {
            const response = data.value;
            deviceType[currentDevice].init(response);
            $('#footer').show();
            $('.toTop').addClass('on');
        });
    },
    initWeb: function (response) {
        commonPage.initTitle(response.page_name);
        commonPage.initContents(response);
        commonPage.initFloatingBanner(response.floating_banner_yn);
        commonPage.initTabs(response);

        main.initSlide();
        fixed.tabs();
    },
    initMobile: function (response) {
        commonPage.initTitle(response.page_name);
        commonPage.initContents(response);
        commonPage.initTabs(response);

        main.initSlide();
        fixed.tabs();
    },
    initTitle: function (title) {
        document.title = title;
    },
    initJavascript: function (javascriptUrl) {
        if (commonUtils.isEmpty(javascriptUrl)) {
            return;
        }

        const head = document.getElementsByTagName('head')[0];
        const script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = javascriptUrl;
        head.appendChild(script);
    },
    initCss: function (cssUrl) {
        if (commonUtils.isEmpty(cssUrl)) {
            return;
        }

        const head = document.getElementsByTagName('head')[0];
        const link = document.createElement('link');
        link.rel = 'stylesheet';
        link.type = 'text/css';
        link.href = cssUrl;
        head.appendChild(link);
    },
    initContents: function (response) {
        $(response.contents).each(function (i, e) {
            const html = commonUtils.isMobile() ? e.mobile_html : e.html;
            if (FunctionType.TYPE.TOP_BAR === e.function_type
                && response.top_bar_yn === 'Y') {
                $('#top_bar').html(html);
            }

            if (FunctionType.TYPE.TOP_CONTENTS === e.function_type
                && response.top_contents_yn === 'Y') {
                $('#top_content').prepend(html);
            }
        });
    },
    initFloatingBanner: function (floatingBannerYn) {
        if (floatingBannerYn === 'Y') {
            $('.floating_bn').show();
            banner.load();
        }
    },
    initTabs: function (response) {
        if (response.tab_menu_yn === 'Y') {
            draw.tabs(response.tabs);
            isCompleteInitTab = true;
        }
    }
};

const main = {
    initSlide: function () {
        let targetMainSlide = document.querySelector('.main_slide');
        setTimeout(function () {
            $('.main_effect').addClass('is-active');
            let mainSlide = new Swiper('.main_slide > .swiper-container', {
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
            targetMainSlide.classList.add('is-active');
        }, 500);
    }
};

const fixed = {
    tabs: function () {
        const tabHead = document.querySelector('.tab_head');
        let distanceY;
        let winTop;
        const toTop = document.querySelector('.toTop');
        const tabBodyTop = document.querySelector('.tab_wrap').offsetTop;
        window.addEventListener('scroll', () => {
            distanceY = window.pageYOffset
                || document.documentElement.scrollTop;
            const tabHeadY = tabHead.parentElement.offsetTop;
            if (distanceY >= tabHeadY) {
                tabHead.classList.add('fixed');
            } else {
                tabHead.classList.remove('fixed');
            }

            winTop = window.pageYOffset || document.documentElement.scrollTop;
            if (winTop > tabBodyTop) {
                toTop.classList.add('on');
            } else {
                toTop.classList.remove('on');
            }
        });
    }
};

const event = {
    apply: function () {
        const param = {
            'nm': $('#inpName').val(),
            'tel': $('#inpPhone').val(),
            'zip_no': $('#zipcode').val(),
            'addr': $('#address').val(),
            'dtl_addr': $('#address_detail').val(),
            'grade_cd': $('input[name=inpGos]:checked').val(),
            'srvy_no': 1
        };
        portalFunctionApi.post('/event/applicant', param, function (data) {
            if (data.code === portalFunctionApi.RESPONSE.DUPLICATE_PHONE) {
                $('#already_user_popup').addClass('is-open');
                return;
            }

            if (data.code === portalFunctionApi.RESPONSE.INVALID_PHONE) {
                alert('번호를 다시 확인해주세요.');
                $('#inpPhone').focus();
                return;
            }

            if (data.code === portalFunctionApi.RESPONSE.END_EVENT) {
                alert('이벤트가 참여 기간이 아닙니다.');
                return;
            }

            if (data.code !== portalFunctionApi.RESPONSE.OK) {
                alert('문제가 발생하였습니다. 잠시 후 다시 시도해보세요.');
                return;
            }

            $('#complete_popup').addClass('is-open');
            $('#event_applicant_btn').removeClass('on');
            $('#event_applicant_btn').addClass('off');
            isEventApply = true;
        });
    },
    checkApplyUser: function () {
        const param = {
            'nm': $('#event_select_name').val(),
            'tel': $('#event_select_phone').val(),
            'srvy_no': 1
        };
        portalFunctionApi.get('/event/applicant/info', param, function (data) {
            if (data.code !== portalFunctionApi.RESPONSE.OK) {
                $('#event_select_none').addClass('is-open');
                return;
            }

            $('#event_select').removeClass('is-open');
            $('#event_select_download').addClass('is-open');
        });
    },
    toggleActiveApply: function () {
        if (commonUtils.isEmpty($('#inpName').val())
            || commonUtils.isEmpty($('#address').val())
            || commonUtils.isEmpty($('#address_detail').val())
            || commonUtils.isEmpty($('#zipcode').val())
            || commonUtils.isEmpty($('input[name=inpGos]:checked').val())) {
            $('.submit').removeClass('on');
            return;
        }

        const phone = $('#inpPhone').val();
        if (commonUtils.isEmpty(phone) || phone.length !== 11) {
            $('.submit').removeClass('on');
            return;
        }

        let isAllChecked = true;
        $('.agree-box input[type=checkbox]').each(function (i, e) {
            if (!$(e).is(':checked')) {
                isAllChecked = false;
                return;
            }
        });

        if (isAllChecked) {
            $('.submit').addClass('on');
        } else {
            $('.submit').removeClass('on');
        }
    }
};

const tab = {
    on: function (tabClass) {
        const tagLi = $('.' + tabClass);
        tagLi.find('.tab-item').addClass('on');
        const tabIndex = tagLi.index();
        $('.tab-content-wrap').eq(tabIndex).show();
        deviceType[currentDevice].activeSlide(tabIndex);
    },
    move: function (selectWeights) {
        const selectTabClass = $('#select_tab').val();
        if (!commonUtils.isEmpty(selectTabClass)
            && $('.' + selectTabClass).length > 0) {
            isCompleteInitTab = true;
            tab.on(selectTabClass);

            const selectTabDetailId = $('#select_tab_detail').val();
            if (commonUtils.isEmpty(selectTabDetailId)) {
                setTimeout(function () {
                    const tabBodyTop = document.querySelector(
                        '.tab_wrap').offsetTop;
                    $('html,body').animate({scrollTop: tabBodyTop}, 500);
                }, 800);
            } else {
                setTimeout(function () {
                    const tabDetailTop = $(
                        '#' + selectTabDetailId).offset().top;
                    if (commonUtils.isMobile()) {
                        $('html,body').animate({scrollTop: tabDetailTop - 66}, 500); //탭높이 차감
                    } else {
                        $('html,body').animate({scrollTop: tabDetailTop}, 500);
                    }
                }, 800);
            }
        } else {
            const selectTabIndex = commonUtils.random(selectWeights.length);
            $('.tab-item').eq(selectWeights[selectTabIndex]).click();
        }
    },
    activeWebSlide: function (tabIndex) {
        if (tabIndex === 0) {
            // 사전
            new Swiper('.video_tab .cont1 .tit2-slide .swiper-container', {
                loop: true,
                navigation: {
                    prevEl: ".video_tab .cont1 .swiper-container .swiper-button-prev",
                    nextEl: ".video_tab .cont1 .swiper-container .swiper-button-next",
                },
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false,
                },
                slidesPerView: 1,
                pagination: {
                    el: ".video_tab .cont1 .tit2-slide .swiper-container .swiper-pagination",
                },
            });

            // 사후
            new Swiper('.p3_star_tab .cont1 .tit1-slide .swiper-container', {
                loop: true,
                navigation: {
                    prevEl: ".p3_star_tab .cont1 .swiper-container .swiper-button-prev",
                    nextEl: ".p3_star_tab .cont1 .swiper-container .swiper-button-next",
                },
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false,
                },
                slidesPerView: 1,
                pagination: {
                    el: ".video_tab .cont1 .tit2-slide .swiper-container .swiper-pagination",
                },
            });
        } else if (tabIndex === 1) {
            new Swiper('.moei_tab .cont1 .swiper-container', {
                loop: true,
                navigation: {
                    prevEl: ".moei_tab .cont1 .swiper-container .swiper-button-prev",
                    nextEl: ".moei_tab .cont1 .swiper-container .swiper-button-next",
                },
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false,
                },
            });

            if (commonUtils.isMobile()) {
                new Swiper('.moei_tab .cont2 .tit2-slide .swiper-container', {
                    loop: true,
                    pagination: {
                        el: '.moei_tab .cont2 .tit2-slide .swiper-container .swiper-pagination',
                        clickable: true,
                    },
                    autoplay: {
                        delay: 3000,
                    },
                });
            } else {
                new Swiper('.moei_tab .cont2 .tit2-slide .swiper-container', {
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
                        el: ".moei_tab .cont2 .tit2-slide .swiper-container .swiper-pagination",
                    }
                });
            }
        }
    },
    activeMobileSlide: function (tabIndex) {
        if (tabIndex === 0) {
            setTimeout(function () {
                // 사전
                new Swiper('.video_tab #video_slide1', {
                    loop: true,
                    slidesPerView: 1,
                    pagination: {
                        el: '.video_tab .cont1 .swiper-pagination',
                        clickable: true,
                    },
                    autoplay: {
                        delay: 3000,
                    },
                });

                // 사후
                new Swiper('.p3_star_tab #video_slide1', {
                    loop: true,
                    slidesPerView: 1,
                    pagination: {
                        el: '.p3_star_tab .cont1 .swiper-pagination'
                    },
                    autoplay: {
                        delay: 3000,
                        disableOnInteraction: false
                    },
                });
            }, 500);
        } else if (tabIndex === 1) {
            // 사전
            new Swiper('.moei_tab .cont1 .swiper-container', {
                loop: true,
                navigation: {
                    prevEl: ".moei_tab .cont1 .swiper-container .swiper-button-prev",
                    nextEl: ".moei_tab .cont1 .swiper-container .swiper-button-next",
                },
                autoplay: {
                    delay: 3000,
                },
            });

            // 사전
            new Swiper('.moei_tab .cont2 .swiper-container', {
                loop: true,
                pagination: {
                    el: '.moei_tab .cont2 .swiper-pagination',
                    clickable: true,
                },
                autoplay: {
                    delay: 3000,
                },
            });
        }
    }
};

const banner = {
    load: function () {
        const param = {
            'banner_group': bannerConstant.GROUP.COMMON_PAGE,
            'banner_location': bannerConstant.LOCATION.FLOATING
        };

        portalServiceApi.get('/banner', param, function (data) {
            const banners = data.value.banners;

            if (!commonUtils.isEmpty(banners)) {
                draw.banners(banners);
            }
        });
    }
};

const draw = {
    tabs: function (tabs) {
        const tabTemplate = Handlebars.compile($('#tab_node').html());
        const tabData = [];

        const contentTemplate = Handlebars.compile(
            $('#tab_content_node').html());
        const contentData = [];

        const selectWeights = [];
        $(tabs).each(function (i, e) {
            for (let j = 0; j < e.select_weight; j++) {
                selectWeights.push(i);
            }

            const tooltipImageUrl = commonUtils.isMobile()
                ? e.mobile_tooltip_image_url : e.tooltip_image_url;
            tabData.push({
                'tab_class': e.tab_class_name,
                'tooltip_image': tooltipImageUrl,
                'tooltip': e.tooltip,
                'tab_name': e.tab_name
            });

            const html = commonUtils.isMobile() ? e.mobile_html : e.html;
            contentData.push({
                'index': i,
                'content': html
            });
        });

        const tabHtml = tabTemplate({'tab_item': tabData});
        $('#tab_ul').html(tabHtml);

        const contentHtml = contentTemplate({'content_item': contentData});
        $('#tab_body').html(contentHtml);

        tab.move(selectWeights);

        setTimeout(function () {
            window.addEventListener('scroll', () => {
                const tabHead = document.querySelector('.tab_head');
                const toTop = document.querySelector('.toTop');
                const tabBodyTop = document.querySelector(
                    '.tab_wrap').offsetTop;
                let winTop = window.pageYOffset
                    || document.documentElement.scrollTop;
                const tabHeadY = tabHead.parentElement.offsetTop;
                if (winTop >= tabHeadY) {
                    tabHead.classList.add('fixed');
                } else {
                    tabHead.classList.remove('fixed');
                }

                if (winTop - 60 >= tabHeadY) {
                    tabHead.classList.add('hide');
                } else {
                    tabHead.classList.remove('hide');
                }

                // top 노출
                if (winTop > tabBodyTop) {
                    toTop.classList.add('on');
                } else {
                    toTop.classList.remove('on');
                }
            });

            // 설명회 탭 close
            $('.offline_tab').find('.tit1-column').find('li > a').each(function (i, e) {
                if ($(e).data('close-time') < new Date().getTime()) {
                    $(e).addClass('close');
                    $(e).attr('href', 'javascript:;');
                }
            });
        }, 1000);
    },
    banners: function (items) {
        let template = Handlebars.compile($('#floating_banner_node').html());
        let data = [];
        const isMobile = commonUtils.isMobile();

        $(items).each(function (index, item) {
            data.push({
                'link': isMobile ? item.mobile_link : item.pc_link,
                'url': item.image_url,
                'alt': item.title
            });
        });

        const html = template({'banner_item': data});
        $('#floating_banner_wrap').html(html);
    }
};
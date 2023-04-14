import portalServiceApi from "../../api/PortalServiceApi.js";
import commonUtils from "../../util/CommonUtils.js";
import dateUtils from "../../util/DateUtils.js";
import bannerConstant from "../../banner/BannerConstant.js";
import presentationConstant from "./PresentationConstant.js";

let isPresentationScrollActive = false;
let isFilterButtonActive = false;
let cursorNo = null;
let cursorPresentationDt = null;
let academyBranchNumbers = [];

$(function () {
    banner.getList();
    academy.getList();

    const isMobile = commonUtils.isMobile();
    let css = {
        'width': isMobile ? '100%' : '400px',
        'height': '100vh',
        'margin': '0 auto',
        'overflow-y': 'scroll'
    };
    $("body").css("overflow", "hidden");
    $("#presentation_div").css(css);
});

$(document).on('change', '#summary_view_switch', function () {
    presentation.onToggleSummarySwitch(this.checked);
});

$(document).on('click', '.filter-select', function (e) {
    e.preventDefault();

    filter.onToggleSelectButton();
    filter.onToggle(true);
});

$(document).on('click', '.filter-options .btn-close', function (e) {
    e.preventDefault();

    filter.onToggle(false);
    filter.offUnSelectItem();
    filter.onToggleAllSelect(academyBranchNumbers);
});

$(document).on('click', '.filter-item a', function (e) {
    e.preventDefault();

    filter.onToggleItem(this.parentNode);
    filter.onToggleSelectButton();
    filter.onToggleAllSelect($('.filter-item.on'));
});

$(document).on('click', '.filter-box .btn-all', function (e) {
    e.preventDefault();

    if (this.classList.contains('on')) {
        this.classList.remove('on');
        filter.onToggleItems(false);
    } else {
        this.classList.add('on');
        filter.onToggleItems(true);
    }

    filter.onToggleSelectButton();
});

$(document).on('click', '.filter-box .btn-select', function (e) {
    if (!isFilterButtonActive) {
        return;
    }

    e.preventDefault();

    presentation.initCursor();
    presentation.getList(true);

    if (!this.classList.contains('disabled')) {
        filter.onToggle(false);
    }
});

$(document).on('click', '.acc-btn', function (e) {
    e.preventDefault();
    presentation.onToggleItemSummary(this.parentNode);

    const activePresentationLength = $('.explain-item.active').length;
    const presentationLength = $('.explain-item').length;

    if (activePresentationLength === 0) {
        $('#summary_view_switch').prop('checked', true);
    } else if (activePresentationLength === presentationLength) {
        $('#summary_view_switch').prop('checked', false);
    }
});

$(document).on('click', '.more-btn', function (e) {
    e.preventDefault();

    $('.btn-all').addClass('on');
    $('.filter-item').addClass('on');
    isFilterButtonActive = true;
    $('.btn-select').click();
});

$(document).on('scroll', window, function () {
    if (!isPresentationScrollActive) {
        return;
    }

    let lastItemTop = $('#presentation_ul > li:last').offset().top;
    let currentScrollTop = $(window).scrollTop() + $(window).height();

    if (lastItemTop <= currentScrollTop) {
        isPresentationScrollActive = false;
        presentation.getList(false);
    }
});

$("#presentation_div").on('scroll', function () {
    if ($(this).scrollTop() == 0) {
        $('.awl_fixer_plus2').css('display', 'none');
    } else {
        $('.awl_fixer_plus2').css('display', 'block');
    }

    if (!isPresentationScrollActive) {
        return;
    }

    const divRealHeight = $(this).prop('scrollHeight') - $(
        '#presentation_ul > li:last').height();
    const divMoveHeight = $(this).scrollTop() + $(this).height();

    if (divMoveHeight >= divRealHeight) {
        isPresentationScrollActive = false;
        presentation.getList(false);
    }
});

$(document).on('click', '.btn_top_moji', function (e) {
    e.preventDefault();

    document.querySelector('#presentation_div').scroll({top:0, behavior:'smooth'});
});

const filter = {
    onToggle: function (isActive) {
        if (isActive) {
            $('#filter_box').addClass('on');
        } else {
            $('#filter_box').removeClass('on');
        }
    },
    onToggleItem: function (element) {
        if (element.classList.contains('on')) {
            element.classList.remove('on');
        } else {
            element.classList.add('on');
        }
    },
    onToggleItems: function (isActive) {
        if (isActive) {
            $('.filter-item').addClass('on');
        } else {
            $('.filter-item').removeClass('on');
        }
    },
    onToggleSelectButton: function () {
        if (this.isEqualsBeforeSelect()) {
            $('#select_complete').addClass('disabled');
            isFilterButtonActive = false;
        } else {
            $('#select_complete').removeClass('disabled');
            isFilterButtonActive = true;
        }
    },
    onToggleAllSelect: function (targetItems) {
        const itemsLength = $('.filter-item').length;
        const targetItemsLength = targetItems.length;
        if (itemsLength === targetItemsLength) {
            $('#view_all_academy').addClass('on');
        } else {
            $('#view_all_academy').removeClass('on');
        }
    },
    offUnSelectItem: function () {
        $('.filter-item').each(function (index, item) {
            const academyBranchNo = $(item).data('id');
            if (academyBranchNumbers.indexOf(academyBranchNo) > -1) {
                $(item).addClass('on');
            } else {
                $(item).removeClass('on');
            }
        });
    },
    getOnItemsNumber: function () {
        const onItemNumbers = [];
        $('.filter-item.on').each(function (index, item) {
            onItemNumbers.push($(item).data('id'));
        });

        return onItemNumbers;
    },
    isEqualsBeforeSelect: function () {
        const currentItemNumbers = this.getOnItemsNumber();

        if (currentItemNumbers.length !== academyBranchNumbers.length) {
            return false;
        }

        if (JSON.stringify(currentItemNumbers) !== JSON.stringify(
            academyBranchNumbers)) {
            return false;
        }

        return true;
    },
    changeTitle: function () {
        let filterTitle = '전체 학원 보기'
        const selectedItems = filter.getOnItemsNumber();
        if (selectedItems.length === 0) {
            $('#filter_title').text(filterTitle);
            $('#filter_title').addClass('unchecked');

            return;
        }

        $('#filter_title').removeClass('unchecked');

        if ((selectedItems.length === $('.filter-item').length)) {
            $('#filter_title').text(filterTitle);
            return;
        }

        const firstNo = selectedItems[0];
        const academyName = $(
            '.filter-item[data-id="' + firstNo + '"]').children('a').text();
        filterTitle = academyName;

        if (selectedItems.length > 1) {
            const otherAcademySize = selectedItems.length - 1;
            filterTitle = filterTitle + ' 외 ' + otherAcademySize;
        }

        $('#filter_title').text(filterTitle);
    },
    onInitFilter: function (isAcademyFilter) {
        const branchCode = $('#branch_code').val();
        let serviceCode = $('#service_code').val();

        if ('hp-gate' === serviceCode) {
            isAcademyFilter = true;
            serviceCode = 'hp-branch';
        } else if ('cs-gate' === serviceCode) {
            isAcademyFilter = true;
            serviceCode = 'cs-branch';
        }

        if (isAcademyFilter) {
            $('.filter-item').each(function (index, item) {
                if (serviceCode === $(item).data('service-code')) {
                    $(item).addClass('on');
                }
            });
        } else {
            $('.filter-item').each(function (index, item) {
                if (branchCode === $(item).data('branch-code')) {
                    $(item).addClass('on');
                }
            });
        }

        filter.onToggleAllSelect($('.filter-item.on'));
    }
};

const banner = {
    getList: function () {
        const param = {
            'banner_group': bannerConstant.GROUP.PRESENTATION,
            'banner_location': bannerConstant.LOCATION.TOP
        };

        portalServiceApi.get('/banner', param, function (data) {
            const banners = data.value.banners;

            if (!commonUtils.isEmpty(banners)) {
                draw.bannerContainer();
                draw.banners(banners);
            }
        });
    }
};

const academy = {
    getList: function () {
        portalServiceApi.get('/academy/groups', {}, function (data) {
            const academies = data.value.academies;

            if (commonUtils.isEmpty(academies)) {
                $('#academy_ul').html('');
            } else {
                draw.academies(academies);
            }

            const branchCode = $('#branch_code').val();
            const serviceCode = $('#service_code').val();
            const filterParam = {
                'branchCode': branchCode,
                'serviceCode': serviceCode
            };

            portalServiceApi.get('/academy/filter-academy', filterParam,
                function (data) {
                    const isAcademyFilter = data.value.is_academy_filter;
                    filter.onInitFilter(isAcademyFilter);
                    presentation.getList(true);
                });
        });
    }
};

const presentation = {
    getList: function (isNew) {
        if (isNew) {
            filter.changeTitle();
        }

        academyBranchNumbers = filter.getOnItemsNumber();
        const param = {
            'cursor_no': cursorNo,
            'cursor_presentation_dt': cursorPresentationDt,
            'academy_branch_numbers': academyBranchNumbers.join(",")
        };

        portalServiceApi.get('/presentation/scroll', param, function (data) {
            isPresentationScrollActive = false;
            const presentations = data.value.content;

            if (data.value.empty) {
                portalServiceApi.getSync('/presentation/exists', {}, function (data) {
                    if (data.value.exists) {
                        presentation.onEmptySearch(isNew);
                    } else {
                        presentation.onEmpty(isNew);
                    }
                });
            } else {
                draw.presentations(presentations, isNew);
                presentation.onNotEmpty(isNew);
            }

            if (data.value.has_next) {
                cursorNo = data.value.next_cursor_number;
                cursorPresentationDt = presentations[presentations.length - 1].presentation_dt;
                isPresentationScrollActive = true;
            }
        });
    },
    onToggleSummarySwitch: function (isSummary) {
        if (isSummary) {
            $('.explain-item').removeClass('active');
        } else {
            $('.explain-item').addClass('active');
        }
    },
    onToggleItemSummary: function (element) {
        if (element.classList.contains('active')) {
            element.classList.remove('active');
        } else {
            element.classList.add('active');
        }
    },
    initCursor: function () {
        cursorNo = null;
        cursorPresentationDt = null;
    },
    onNotEmpty: function (isNew) {
        if (!isNew) {
            return;
        }
        $('.explain-list-wrap').hide();
        $('#not_empty_presentation').show();
    },
    onEmpty: function (isNew) {
        if (!isNew) {
            return;
        }
        $('.explain-list-wrap').hide();
        $('#empty_presentation').show();
    },
    onEmptySearch: function (isNew) {
        if (!isNew) {
            return;
        }
        $('.explain-list-wrap').hide();
        $('#empty_search_presentation').show();
    }
}

const draw = {
    bannerContainer: function () {
        let template = Handlebars.compile($('#banner_container_node').html());
        const html = template();
        $('#banner_section').html(html);
    },
    banners: function (items) {
        let template = Handlebars.compile($('#banner_node').html());
        let bannerData = [];
        const isMobile = commonUtils.isMobile();

        $(items).each(function (index, item) {
            bannerData.push({
                'link': isMobile ? item.mobile_link : item.pc_link,
                'url': item.image_url,
                'alt': item.title
            });
        });

        const html = template({'banner_item': bannerData});
        $('#banner_wrap').html(html);

        const bannerSize = $('#banner_wrap').children('.swiper-slide').length;
        const visualSwiper = new Swiper('.visual-swiper', {
            loop: bannerSize > 1,
            autoplay: {
                delay: 3000,
            },
            speed: 1200,
            pagination: {
                el: '.visual-pagination',
            },
            navigation: {
                prevEl: '.visual-navigation-prev',
                nextEl: '.visual-navigation-next'
            },
            watchOverflow : true
        });
    },
    academies: function (items) {
        let template = Handlebars.compile($('#academy_node').html());
        let academyData = [];

        $(items).each(function (index, item) {
            $(item.academy_branches).each(
                function (branchIndex, academyBranch) {
                    academyData.push({
                        'academy_branch_no': academyBranch.academy_branch_no,
                        'branch_code': academyBranch.branch_code,
                        'service_code': academyBranch.service_code,
                        'academy_name': academyBranch.academy_name
                            + ' ' + academyBranch.branch_name
                    });
                });
        });

        const html = template({'academy_item': academyData});
        $('#academy_ul').html(html);
    },
    presentations: function (items, isNew) {
        let template = Handlebars.compile($('#presentation_node').html());
        let presentationData = [];

        const isSummary = $('#summary_view_switch').is(':checked');
        const isMobile = commonUtils.isMobile();

        $(items).each(function (index, item) {
            let link = item.link;

            if (isMobile && !commonUtils.isEmpty(item.mobile_link)) {
                link = item.mobile_link;
            }

            presentationData.push({
                'active_class': isSummary ? '' : 'active',
                'logo_url': item.logo_url,
                'title': item.presentation_name,
                'target': item.target,
                'presentation_dt': dateUtils.convertKorean(
                    new Date(item.presentation_dt)),
                'place': commonUtils.isEmpty(item.place) ? '해당 학원 문의'
                    : item.place,
                'detail_link': link + item.ext_presentation_code.split('_')[3],
                'link_color': item.html_color_code
            });
        });

        const html = template({'presentation_item': presentationData});
        if (isNew) {
            $('#presentation_ul').html(html);
        } else {
            $('#presentation_ul').append(html);
        }
    }
};
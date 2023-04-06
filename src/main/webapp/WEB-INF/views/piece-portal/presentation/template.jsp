<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<script id="banner_container_node" type="text/x-handlebars-template">
    <div class="swiper-container visual-swiper">
        <div class="swiper-wrapper visual-list" id="banner_wrap">

        </div>
        <div class="visual-navigation visual-navigation-prev"></div>
        <div class="visual-navigation visual-navigation-next"></div>
    </div>
    <div class="visual-pagination"></div>
</script>

<script id="banner_node" type="text/x-handlebars-template">
    {{#banner_item}}
    <div class="swiper-slide visual-item">
        <a href="{{link}}" target="_blank"><img src="{{url}}" alt="{{alt}}"></a>
    </div>
    {{/banner_item}}
</script>

<script id="academy_node" type="text/x-handlebars-template">
    {{#academy_item}}
    <li class="filter-item" data-id="{{academy_branch_no}}" data-branch-code="{{branch_code}}"
        data-service-code="{{service_code}}">
        <a href="#">{{academy_name}}</a>
    </li>
    {{/academy_item}}
</script>

<script id="presentation_node" type="text/x-handlebars-template">
    {{#presentation_item}}
    <li class="explain-item acc-item {{active_class}}">
        <a href="{{detail_link}}" target="_blank" class="info">
            <img src="{{logo_url}}" alt="" class="thumb"/>
            <div class="title">{{{title}}}</div>
        </a>
        <button class="acc-btn"><span class="blind">요약보기 열기/닫기</span></button>
        <a href="{{detail_link}}" target="_blank">
            <div class="acc-content">
                <div class="description">
                    <div class="text target"><em>대상</em> <span>{{{target}}}</span></div>
                    <div class="text date"><em>일시</em> <span>{{{presentation_dt}}}</span></div>
                    <div class="text location"><em>장소</em> <span>{{{place}}}</span></div>
                </div>
                <div class="link-shortcut" style="background-color:<%="#"%>{{link_color}}">설명회
                    바로가기
                </div>
            </div>
        </a>
    </li>
    {{/presentation_item}}
</script>
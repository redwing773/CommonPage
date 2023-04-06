<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<script id="tab_node" type="text/x-handlebars-template">
    {{#tab_item}}
    <li class="{{tab_class}}">
        <a href="javascript:;" class="tab-item">
            <span class="blind">{{tab_name}}</span>
            <div class="tooltip">
                <img src="{{tooltip_image}}" alt="{{tooltip}}">
            </div>
        </a>
    </li>
    {{/tab_item}}
</script>

<script id="tab_content_node" type="text/x-handlebars-template">
    {{#content_item}}
    <div class="tab-content-wrap" data-index="{{index}}" style="display:none;">
        {{{content}}}
    </div>
    {{/content_item}}
</script>

<script id="floating_banner_node" type="text/x-handlebars-template">
    {{#banner_item}}
    <a href="{{link}}"><img src="{{url}}" alt="{{alt}}"/></a>
    {{/banner_item}}
</script>
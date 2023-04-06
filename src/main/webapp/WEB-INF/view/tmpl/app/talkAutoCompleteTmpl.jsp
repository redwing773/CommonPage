<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="autoCompleteTmpl" type="text/x-jquery-tmpl">
    <ul>
    {{each(index, item) list}}
        <li><a href="#self" onclick="recommendWordClick('{{= item}}')">{{= item}}</a></li>
    {{/each}}
    </ul>
</script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="postListTmpl" type="text/x-jquery-tmpl">
    <li {{if readYn == "N"}} class="new" {{/if}}>
        <a href="${pageContext.request.contextPath}/page/post/detail?postBoxNo=\${postBoxNo}">
            <span class="name">\${title}</span>
            <span class="txt">\${contents}</span>
            <span class="date">\${regDt}</span>
        </a>
    </li>
</script>
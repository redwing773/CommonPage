<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script id="postListTmpl" type="text/x-jquery-tmpl">
	<li>
        <a href="javascript:void(0);" onClick="detailPostBoxFn(\${postBoxNo});" {{if readYn == "N"}} class="on" {{/if}}>
			<div class="infoBox">
		    	<div class="titTxt">\${title}</div>
				<div class="subTxt">\${contents}</div>
				<div class="dateTxt">\${regDt}</div>
			</div>
            <div class="couponBox">
			{{if type == "INVENTORY" || type == "COUPON"}}
				<span class="coupon"></span> 
			{{/if}}
				<span {{if readYn == "N"}} class="new" {{/if}} ></span>
			</div>
		</a>
    </li>
</script>
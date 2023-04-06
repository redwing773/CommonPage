<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 멘톡칼럼 리스트 -->
<script id="purchaseListTmpl" type="text/x-jquery-tmpl">
    <li>
        <div>
            <div class="photo_box">
                {{if mentorProfileUri == null || mentorProfileUri == ""}}
                    <div class="photo" style="cursor:pointer;"><img src="" alt=""></div>
                {{else}}
                    <div class="photo" style="background: url(\${mentorProfileUri}) center center no-repeat; background-size:cover;cursor:pointer;"></div>
                {{/if}}

                <div class="label">
                    {{if contentsYn}}
                        <span class="red">생기부</span>
                    {{/if}}
                    {{if selfReportYn}}
                        <span class="purple">자소서</span>
                    {{/if}}
                </div>
            </div>
            <div>
                <a href="#a" class="btn_pop" data-type="\${contentsType}" data-value="\${contentsValue}" data-nick="\${mentorNickname}" data-id="\${mentorHipId}" data-codeValue="\${codeValue}" data-use="\${useYn}" style="display:inline-block;width:100%">
                <div class="name">\${mentorNickname}</div>
                <div class="txt_info_01">\${mentorUniversityName}/\${mentorMajorName}</div>
                <div class="txt_info_02">\${limitDate}</div>
                <div class="txt_btn {{if !useYn}}finished{{/if}}">\${codeName}</div>
                </a>
            </div>
        </div>
    </li>
</script>


<script id="searchNoDataTmpl" type="text/x-jquery-tmpl">
    <li id="myLinkerListNoData"><div>{{html noDataMsg}}</div></li>
</script>
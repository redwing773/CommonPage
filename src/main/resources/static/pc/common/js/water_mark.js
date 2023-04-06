var mark = (function ($, win, doc) {
    var setPopupCont = function(cont, nickname){
        var iframe = document.getElementById("popFrame");
        iframe = iframe.contentWindow || ( iframe.contentDocument.document || iframe.contentDocument);

        iframe.document.open();
        iframe.document.write(cont);
        iframe.document.close();
        cont = $("#popFrame").contents().find("body").html();

        $(".purchase_view_popup .cont").empty().html(cont);

        setTimeout(function() {
            Layer_OPEN('.purchase_view_popup');
            setMark("watermark", nickname);
        }, 500);
    }

    var setMark = function(watermarkId, nickName){ //워터마크 세팅
        var dataurl = backgroundText(nickName +" Linker" , 130, 100, -40);
        document.getElementById(watermarkId).style.backgroundImage = "url(" + dataurl + ")";
        document.getElementById(watermarkId).style.display = "block";

        var hg = $(".purchase_view_popup .in_box").height() > $(".purchase_view_popup .cont").height() ? $(".purchase_view_popup .in_box").height() : $(".purchase_view_popup .cont").height();
        document.getElementById(watermarkId).style.height = hg+"px";

        $(".purchase_view_popup .cont").load
    };

    var backgroundText = function(text, width, height, angle) {
        var rtn = null;
        if (text !== undefined) {
            var canvas  = document.createElement("canvas");

            if (width !== undefined) { canvas.width = width; }
            if (height !== undefined) { canvas.height = height; }

            document.documentElement.appendChild(canvas);

            var ctx = canvas.getContext("2d");
            ctx.translate(canvas.width / 2, canvas.height / 2);
            ctx.rotate(angle * Math.PI / 180);
            ctx.font = "18px Apple SD Gothic Neo";
            ctx.color = "#8C909B";
            ctx.globalAlpha  = 0.12;
            ctx.textAlign = "center";
            ctx.fillText(text, 0, 0);

            rtn = canvas.toDataURL("image/png");

            document.documentElement.removeChild(canvas);
        }
        return rtn;
    }


    return {
        setPopupCont: setPopupCont
    }
}(jQuery, window, document));

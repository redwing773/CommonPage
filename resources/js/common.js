import Version from "./Version.js";
import commonUtils from "./util/CommonUtils.js";

const INSPECTION_CODE = 3000;

$(function () {
    const version = new Version('1.0.10');
    version.printVersion();
});

$(document).ajaxError(function (event, xhr) {
    let popupId = 'error_popup';
    let code = 500;

    if (!commonUtils.isEmpty(xhr.responseJSON)) {
        code = xhr.responseJSON.code;
    }

    if (code === INSPECTION_CODE) {
        popupId = 'inspection_popup';
        $('#inspection_message').html(xhr.responseJSON.message);
    }

    $('#' + popupId).removeClass('hide');
});

$('.popup-close').click(function (e) {
    $(e.currentTarget).closest('.layer-popup').addClass('hide');
});
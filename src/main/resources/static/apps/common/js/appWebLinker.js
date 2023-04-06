$('.gnb li a').on('click', function () {
	if (!$(this).parent().hasClass('on')) {
		$('.gnb li.on').removeClass('on');
		$(this).parent().addClass('on');
	}
	return false;
});
$('.language > a').on('click', function () {
	if (!$(this).parent().hasClass('on')) {
		$(this).parent().addClass('on');
	} else {
		$(this).parent().removeClass('on');
	}
	return false;
});
$('.language li a').on('click', function () {
	$('.language').removeClass('on');
	return false;
});
$('.fix_more_btn > button').on('click', function () {
	if (!$(this).parent().hasClass('on')) {
		$(this).parent().addClass('on');
		$(this).parent().find('> ul').fadeIn(300);
	} else {
		$(this).parent().removeClass('on');
		$(this).parent().find('> ul').fadeOut(300);
	}
	return false;
});
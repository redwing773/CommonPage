UI = {
	load: function(){
		$(document).ready(function(){
			UI.fn_gnb();
			UI.fn_main();
			UI.fn_join_box();
			UI.fn_side();
		});//ready

		$(window).load(function(){
			UI.fn_join_complete();
		});//load
	},

	fn_gnb : function(){
		var wrap = $('#wrap'),
			header = $('#header'),
			gnb = $('#gnb > ul'),
			depth1 = gnb.children(),
			selected_flag = null;

		depth1.each(function(i){
			if ($(this).hasClass('current') && $(this).find('ul').length == 1){
				selected_flag = i;
				header.addClass('open');
			}
		});
		depth1.on('mouseover focusin', function(){
			depth1.removeClass('current');
			$(this).addClass('current');
			if ($(this).find('ul').length == 1){
				header.addClass('open');
			}else{
				header.removeClass('open');
			}
		});
		header.on('mouseleave focusout', function(){
			if (selected_flag == null){
				header.removeClass('open');
				depth1.removeClass('current');
			}else {
				header.addClass('open');
				depth1.removeClass('current');
				depth1.eq(selected_flag).addClass('current');
			}
		});

		var didScroll;
		var lastScrollTop = 0;
		var delta = 5;
		var navbarHeight = $('header').outerHeight();

		$(window).on('scroll', function(){
			sTop = $(window).scrollTop();
			if (sTop > $('#top_banner').height()){
				wrap.addClass('fixed');
			}else{
				wrap.removeClass('fixed');
			}
			didScroll = true;
		});

		setInterval(function() {
			if (didScroll) {
				hasScrolled();
				didScroll = false;
			}
		}, 250);

		function hasScrolled() {
			var st = $(this).scrollTop();

			if(Math.abs(lastScrollTop - st) <= delta)
				return;

			if (st > lastScrollTop && st > navbarHeight){
				// Scroll Down 
				header.removeClass('open');
			} else {
				// SScroll Up
				if(st + $(window).height() < $(document).height() && depth1.hasClass('current')) {
					header.addClass('open');
				}
			}

			lastScrollTop = st;
		}

		var top_banner = $('#top_banner');
		var top_banner_close = top_banner.find('.btn_close');

		top_banner_close.on('click',function(){
			top_banner.addClass('hide');
		});

		var btn_mail = $('#header .btn_mail');
		var btn_user = $('#header .btn_user');
		var layer_mail = $('#util_layer .layer_mail');
		var layer_user = $('#util_layer .layer_user');

		btn_mail.on('click',function(){
			btn_user.removeClass('on');
			$(this).toggleClass('on');
			layer_user.fadeOut(200);
			layer_mail.fadeToggle(200);
		});

		btn_user.on('click',function(){
			btn_mail.removeClass('on');
			$(this).toggleClass('on');
			layer_mail.fadeOut(200);
			layer_user.fadeToggle(200);
		});

	},

	fn_main : function(){
		if($('#main_contents').length == 0){return;}

		$('.event_baneer .slider').slick({
			dots: true,
			arrows: true,
			infinite: true,
			speed: 300
		});

		$('.section_02 .slider_style_01').slick({
			dots: false,
			draggable: false,
			arrows: true,
			slidesToShow: 4,
			slidesToScroll: 4,
			infinite: false,
			speed: 300
		});

		$('.section_03 .slider_style_01').slick({
			dots: false,
			draggable: false,
			arrows: true,
			slidesToShow: 4,
			slidesToScroll: 4,
			infinite: false,
			speed: 300
		});

	},

	fn_join_box : function (){
		if($('.join_box').length == 0){return;}

		var join_box = $('.join_box');
		var cover = join_box.find('.cover');

		cover.each(function(i){this.num = i});
		cover.on('click',function(){
			if (this.num == 0){
				join_box.removeClass('mentor');
				join_box.toggleClass('mentee');
			}
			if (this.num == 1){
				join_box.removeClass('mentee');
				join_box.toggleClass('mentor');
			}
		});
	},

	fn_join_complete : function (){
		if($('.join_complete_wrap').length == 0){return;}

		var obj = $('.join_complete_wrap');
		obj.addClass('start');

	},

	fn_side : function (){
		if($('.side_bar').length == 0){return;}

		var side_bar = $('.side_bar');
		var footer_top = $('#rwd_footer').offset().top + 50;
		var win_height = window.innerHeight;

		$(window).scroll(function(){
			sTop = $(window).scrollTop();
			if ( sTop <= footer_top - win_height ){
				side_bar.stop().css({'top': sTop});
			}

		});
	},
}

var Layer_OPEN = function (obj){
	$(obj).addClass('open');
};

var Layer_CLOSE = function (obj){
	$(obj).removeClass('open');
};

var Layer_OPEN_IMG = function (obj){
	var image = $(obj).find('img');

	image.on( "load", function(){
		var height = image[0].naturalHeight;
		var width = image[0].naturalWidth;

		var max_height = $(window).height() * 0.7;
		var max_width = $(window).width() * 0.7;

		var height_rate = height / max_height;
		var width_rate = width / max_width;

		if ( width >= max_width || height >= max_height ) {
			if ( width_rate > height_rate ) {
				width = Math.floor(width / width_rate);
				height = Math.floor(height / width_rate);
			}
			else {
				width = Math.floor(width / height_rate);
				height = Math.floor(height / height_rate);
			}
		}

		image.css("width", width);
		image.css("height", height);

		$(obj).addClass('open');
	});
};

var Layer_CLOSE_IMG = function (obj){
	$(obj).removeClass('open');
};

UI.load();

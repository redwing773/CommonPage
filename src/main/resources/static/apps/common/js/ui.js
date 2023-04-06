UI = {
	load: function(){
		$(document).ready(function(){

		});//ready

		$(window).load(function(){

		});//load
	},

}


var Layer_OPEN = function (obj){
	$(obj).addClass('open');
};

var Layer_CLOSE = function (obj){
	$(obj).removeClass('open');
};

UI.load();

var seconds = 0;
var minutes = 0;
var hours = 0;
var hasStarted = false;
var hasEnded = false;

var s;
var m;
var h;
var interval = null;

$(function() {
    //s = $(".timer").find('.seconds');
    //m = $(".timer").find('.minutes');
    //h = $(".timer").find('.hours');

});


function countdown() {
    hasStarted = true;
    interval = setInterval(function() {
        if(hasEnded == false) {
            if (seconds <= 11 && minutes == 0 && hours == 0) {
              //$(timer).find('span').addClass('red');
            }

            if(seconds == 0 && minutes == 0 || (hours > 0  && minutes == 0 && seconds == 0)) {
                hours--;
                minutes = 59;
                seconds = 60;
                refreshClock();
            }

            if(seconds > 0) {
                seconds--;
                refreshClock();
            }
            else if (seconds == 0) {
                minutes--;
                seconds = 59;
                refreshClock();
            }
        }
        else {
            //restartClock();
        }

    }, 1000);
}

function startClock(paramObj, paramSeconds) {
    s = $(paramObj).find('.seconds');
    m = $(paramObj).find('.minutes');
    h = $(paramObj).find('.hours');

    hasStarted = false;
    hasEnded = false;

    seconds = 0;
    minutes = 0;
    hours = 0;

    var min = Math.floor(paramSeconds / 60);
    minutes = min;
    var sec = paramSeconds - (min * 60);
    seconds = sec;

    /*if (seconds <= 10 && clockType == 'countdown' && minutes == 0 && hours == 0) {
      $(timer).find('span').addClass('red')
    }*/

    refreshClock();

    /*$('.input-wrapper').slideUp(350)
    setTimeout(function(){
        $('#timer').fadeIn(350)
        $('#stop-timer').fadeIn(350)

    }, 350)*/

   countdown();
}

function refreshClock() {
    $(s).text(pad(seconds));
    $(m).text(pad(minutes));
    if (hours < 0) {
        $(s).text('00');
        $(m).text('00');
        $(h).text('00');
    } else {
        $(h).text(pad(hours));
    }

    if (hours == 0 && minutes == 0 && seconds == 0 && hasStarted == true) {
        hasEnded = true;
        //lert('The Timer has Ended !')
        setTimerEnd();
    }
}

function pad(d) {
    return (d < 10) ? '0' + d.toString() : d.toString()
}

function clear(intervalID) {
    clearInterval(intervalID)
    //console.log('cleared the interval called ' + intervalID)
}
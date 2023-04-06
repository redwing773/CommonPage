import SendbirdAction from './SendbirdAction.js';
import etoosApi from "../api/EtoosApi.js";

window.onload = function() {
    etoosApi.call(function() {
        sendbird.init();
    });

    const files = document.getElementById('files');
    files.addEventListener('change', sendbird.changeFile, false);

    const sbMessage = document.getElementById('sb_message');
    sbMessage.addEventListener('keypress', function(e) {
        let key = e.key || e.keyCode;

        if ((key === 'Enter' || key === 13) && !e.shiftKey) {
            e.preventDefault();
            sendbird.send(sbMessage);
            sbMessage.value = "";
        }
    });
}

const sbMessagesArea = document.getElementById('sb_messages_area');
let isMessageLoading = false;
sbMessagesArea.addEventListener('scroll', function(){
    if(isMessageLoading == true){
        return;
    }

    if(sbMessagesArea.scrollTop < 100){
        sendbird.getList(false);
        isMessageLoading = true;
    }
});

$(window).on("blur focus", function(e) {
	switch (e.type) {
		case "blur":
            if(sendbird.sb != null && sendbird.sb.sb._currentUserId != null) {
                sendbird.sb.disconnect().then(() => {
                    $("#sb_messages_area").append("<div style='text-align: center;color:red;'>disconnect</div>");
                    sendbird.scrollBottom();
                });
            }

			break;
		case "focus":
            sendbird.reconnect();


			break;
	}
});

const sbUserId = document.getElementById("sb_user_id");
const sbUserToken = document.getElementById("sb_user_token");
const channelUrl = document.getElementById("channel_url").value;
let unMessages = [];
let isUnListLock = false;
let lockMessages = [];

const sendbird = {
    sb: null,
    init: function() {
        $.ajax({
            url: '/auth/sb',
            type: 'POST',
            contentType: 'application/json',
            xhrFields: {
                withCredentials: true
            },
            success: function(data) {
                if(data.value.accountNo == null){
                    etoosApi.login();
                } else {
                    sendbird.sb = new SendbirdAction(data.value.sbAppId, data.value.sbAppKey);
                    sendbird.setHandler();
                    sendbird.connect();
                }
            }
        });
    },

    connect: function(){
        sendbird.sb.connect(sbUserId.value, sbUserToken.value).then((user) => {
            sendbird.sb.getGroupChannel(channelUrl).then((channel) => {
                this.getList(true);
            });
        }).catch((error) => {
            console.error(error);
        });
    },

    reconnect: function(){
        sendbird.sb.connect(sbUserId.value, sbUserToken.value).then((user) => {
            sendbird.sb.getGroupChannel(channelUrl).then((channel) => {
                $("#sb_messages_area").append("<div style='text-align: center;color:blue;'>connect</div>");
                sendbird.scrollBottom();
                if(!isUnListLock) {
                    isUnListLock = true;
                    sendbird.getUnList();
                }
            });
        }).catch((error) => {
            console.error(error);
        });
    },

    getUnList: function() {
        const messageId = $(".sb-chat-message").last().data('messageId');
        sendbird.sb.getUnList().then((data) => {
            let isLoop = true;
            for (const message of data.messages) {
                if(message.messageId == messageId) {
                    isLoop = false;
                    break;
                }

                unMessages.push(message);
            }

            if(data.isNext && isLoop) {
                sendbird.getUnList();
            } else {
                sendbird.sb.unListQueryInit();
                draw.messages();
                isUnListLock = false;

                if(lockMessages.length > 0){
                    for(const lockMessage of lockMessages){
                        sendbird.messageLocation(lockMessage);
                    }

                    lockMessages = [];
                }
            }
        }).catch((error) => {
            sendbird.sb.unListQueryInit();
            isUnListLock = false;
        });
    },

    messageLocation(message) {
        const targetTime = message.createdAt;

        for(let idx = 0; idx < $(".sb-chat-message").length; idx++){
            const currentTime = $(".sb-chat-message").eq(idx).data("unixTime");
            const afterTime = $(".sb-chat-message").eq(idx + 1).data("unixTime");

            if(targetTime < afterTime && targetTime > currentTime){
                // TODO: 범위 current 기준으로 after ~
                const $target = $(".sb-chat-message").eq(idx);
                if(sendbird.sb.sb._currentUserId == message._sender.userId){
                    draw.message(message, true, false, $target);
                } else {
                    draw.message(message, false, false, $target);
                }
                break;
            }
        }
    },

    getList: function(isInit){
        sendbird.sb.getList(false, 30, true).then((data) => {
            let oldHeight = sbMessagesArea.scrollHeight;
            let oldScrollTop = sbMessagesArea.scrollTop;

            for(const message of data.messages){
                if(sendbird.sb.sb._currentUserId == message._sender.userId){
                    draw.message(message, true, true);
                } else {
                    draw.message(message, false, true);
                }
            }

            sendbird.sb.markAsRead();
            if(data.isNext) {
                isMessageLoading = false;
                sbMessagesArea.scrollTo(0, oldScrollTop + sbMessagesArea.scrollHeight - oldHeight);
            } else {
                const compareDate = $("#sb_messages_area > .sb-chat-message").first().data('date');
                if(compareDate != null){
                    draw.date(compareDate, true);
                }
            }

            if(isInit){
                sbMessagesArea.scrollTo(0, sbMessagesArea.scrollHeight);
            }
        }).catch((error) => {
            console.log(error);
        })
    },

    setHandler: function() {
        if(sendbird.sb == null){
            return;
        }

        sendbird.sb.channelHandler.onMessageReceived = function(channel, message) {
            sendbird.sb.markAsRead();
            if(isUnListLock) {
                lockMessages.push(message);
            } else {
                draw.message(message, false, false);
            }

            sbMessagesArea.scrollTo(0, sbMessagesArea.scrollHeight);
        };

        sendbird.sb.channelHandler.onReadReceiptUpdated = function(channel) {
            console.log("===========================================");
            console.log("channelHandler : onReadReceiptUpdated");
            console.log(channel);
            console.log("===========================================");
            sendbird.unreadUpdate();
        };

        sendbird.sb.channelHandler.onDeliveryReceiptUpdated = function(channel) {
            console.log("===========================================");
            console.log("channelHandler : onDeliveryReceiptUpdated")
            console.log(channel);
            console.log("===========================================");
        };
    },

    changeFile: function(e){
        const files = e.target.files;

        for (let i = 0, f; f = files[i]; i++) {

            if (!f.type.match('image.*')) {
                continue;
            }

            sendbird.sb.sendFileMessage(f).then((fileMessage) => {
                draw.message(fileMessage, true, false);
                sendbird.scrollBottom();
            }).catch((error) => {
                console.error(error);
            });

            break;
        }
    },

    send: function(message) {
        if(message.value.length < 1){
            alert("메세지를 입력하세요.");
            return;
        }

        sendbird.sb.sendMessage(message.value).then((message) => {
            draw.message(message, true, false);
            sendbird.scrollBottom();
        }).catch((error) => {
        });
    },

    unreadUpdate() {
        $(".sb-chat-message").each(function(idx, item){
            const messageObj = $(item).data('messageObj');
            const unread = sendbird.sb.getUnreadCount(messageObj);
            $(item).children(".message-id").text(unread);
        });
    },

    scrollTop() {
        sbMessagesArea.scrollTo(0, 0);
    },

    scrollBottom() {
        sbMessagesArea.scrollTo(0, sbMessagesArea.scrollHeight);
    }
}

const draw = {
    message: function (message, isSender, isPrepend, $target) {
        let template = Handlebars.compile($('#message_receiver').html());
        const data = [];
        if(isSender){
            template = Handlebars.compile($('#message_sender').html());
        }

        let text = Handlebars.Utils.escapeExpression(message.message);
        text = text.replace(/(\r\n|\n|\r)/gm, '<br>');
        text =  new Handlebars.SafeString(text);

        const date = new Date(message.createdAt).toLocaleDateString();
        const time = new Date(message.createdAt).toLocaleTimeString('en-US');
        const unread = sendbird.sb.getUnreadCount(message);
        data.push({ 'message' : text, 'date' : date, 'time' : time, 'messageId' : message.messageId, 'createAt' : message.createdAt, 'unread' : unread, 'messageObj' : JSON.stringify(message), 'imageUrl' : message.url });
        const html = template({ 'message' : data });

        if(isPrepend) {
            const compareDate = $("#sb_messages_area > .sb-chat-message").first().data('date');
            if(compareDate != null && compareDate != date){
                this.date(compareDate, true);
            }

            if($target) {
                $target.before(html);
            } else {
                $("#sb_messages_area").prepend(html);
            }
        } else {
            const compareDate = $("#sb_messages_area > .sb-chat-message").last().data('date');
            if(compareDate != null && compareDate != date){
                this.date(date, false);
            }

            if($target) {
                $target.after(html);
            } else {
                $("#sb_messages_area").append(html);
            }
        }
    },

    messages() {
        const templateReceiver = Handlebars.compile($('#message_receiver').html());
        const templateSender = Handlebars.compile($('#message_sender').html());
        let template = null;
        let strHtml = "";

        for(const message of unMessages) {
            if(sendbird.sb.sb._currentUserId == message._sender.userId){
                template = templateSender;
            } else {
                template = templateReceiver;
            }

            let text = Handlebars.Utils.escapeExpression(message.message);
            text = text.replace(/(\r\n|\n|\r)/gm, '<br>');
            text =  new Handlebars.SafeString(text);

            const date = new Date(message.createdAt).toLocaleDateString();
            const time = new Date(message.createdAt).toLocaleTimeString('en-US');
            const unread = sendbird.sb.getUnreadCount(message);
            const data = [];
            data.push({ 'message' : text, 'date' : date, 'time' : time, 'messageId' : message.messageId, 'createAt' : message.createdAt, 'unread' : unread, 'messageObj' : JSON.stringify(message), 'imageUrl' : message.url });
            const html = template({ 'message' : data });
            strHtml = html + strHtml;
        }

        unMessages = [];
        $("#sb_messages_area").append(strHtml);
        sendbird.scrollBottom();
        sendbird.unreadUpdate();
        sendbird.sb.markAsRead();
    },

    date: function(date, isPrepend) {
        let template = Handlebars.compile($('#message_date').html());
        const html = template({ 'date' : date });
        if(isPrepend) {
            $("#sb_messages_area").prepend(html);
        } else {
            $("#sb_messages_area").append(html);
        }
    }
}



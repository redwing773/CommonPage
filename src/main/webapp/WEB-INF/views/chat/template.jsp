<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<script id="message_receiver" type="text/x-handlebars-template">
    {{#message}}
    <div class="sb-chat-message message sol" data-date="{{date}}" data-unix-time="{{createAt}}" data-message-id="{{messageId}}" data-message-obj="{{messageObj}}">
        <div class="resim message-id">{{unread}}</div><div class="messageText" data-time="{{time}}">
            {{message}}
            <a href="{{imageUrl}}" download="myimage"><img src="{{imageUrl}}" /></a>
        </div>
    </div>
    {{/message}}
</script>

<script id="message_sender" type="text/x-handlebars-template">
    {{#message}}
    <div class="sb-chat-message message sag mtLine" data-date="{{date}}" data-unix-time="{{createAt}}" data-message-id="{{messageId}}" data-message-obj="{{messageObj}}">
        <div class="messageText" data-time="{{time}}">
            {{message}}
            <a href="{{imageUrl}}" download="myimage"><img src="{{imageUrl}}" /></a>
        </div><div class="resim message-id">{{unread}}</div>
    </div>
    {{/message}}
</script>

<script id="message_date" type="text/x-handlebars-template">
    <div class="time"><span>{{date}}</span></div>
</script>
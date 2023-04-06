<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SB</title>
</head>
<body>
<div>
    <div id="sb_messages_area" class="chat-box-body" style="width: 100%;height:85vh;overflow: auto;">
    </div>

    <div id="" style="height:15vh;">
        <textarea id="sb_message" placeholder="Send a message..."
              style="width: 100%;" rows="5"></textarea>
        <br/>
        <input type="file" id="files" name="files[]" multiple />
    </div>
</div>
    <jsp:include page="./template.jsp"/>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="/resources/js/library/sendbird.min.js"></script>
    <script type="module" src="/resources/js/chat/sendbird.js"></script>
    <input type="hidden" id="channel_url" value="${channel}">

    <!-- TODO: 임시 TOKEN -->
    <input type="hidden" id="sb_user_id" value="${userId}">
    <input type="hidden" id="sb_user_token" value="${token}">
</body>

<!-- TODO: 임시 CSS -->
<style>
  body {
    overflow: hidden;
    background: #222;
  }

  * {
    outline: 0;
  }

  .time {
    text-align: center;
    margin-bottom: 10px;
  }
  .time span {
    background-color: #000000;
    display: inline-block;
    border-radius: 3px;
    text-align: center;
    padding: 2px 20px;
    color: #fff;
    opacity: 0.3;
  }
  .message {
    margin-bottom: 10px;
  }
  .message .messageText {
    text-align: left;
    color: #FFFFFF;
  }
  .message.sol {
    text-align: left;
  }
  .message.sag {
    text-align: right;
  }
  .message .resim {
    background: #FF0044 none no-repeat center;
    vertical-align: text-top;
    background-size: cover;
    display: inline-block;
    position: relative;
    color: #FFFFFF;
    height: 40px;
    width: 40px;
  }
  .message .messageText {
    background-color: #FF0044;
    vertical-align: text-top;
    display: inline-block;
    position: relative;
    line-height: 20px;
    max-width: 165px;
    color: #FFFFFF;
    padding: 10px;
  }
  .message.left .userPortrait,
  .message.sag .messageText {
    border-radius: 5px 0 0 5px;
  }
  .message.sag .userPortrait,
  .message.sol .messageText {
    border-radius: 0 5px 5px 0;
  }
  .message.mtLine.sol .messageText {
    border-radius: 0 5px 5px 0;
  }
  .message.mtLine.sag .messageText {
    border-radius: 5px 0 0 5px;
  }
  .message .messageText:before {
    border-color: transparent #FF0044;
    border-style: solid;
    position: absolute;
    border-width: 0;
    display: block;
    content: "";
    z-index: 1;
  }
  .message.sol .messageText:before {
    border-width: 0 10px 10px 0;
    left: -10px;
    top: 0;
  }
  .message.sag .messageText:before {
    border-width: 10px 0 0 10px;
    right: -10px;
    top: 30px;
  }
  .message .messageText:after {
    content: attr(data-time);
    color: rgba(255,255,255,0.5);
    position: absolute;
    line-height: 20px;
    display: block;
    bottom: 2px;
    z-index: 1;
  }
  .message.sol .messageText:after {
    margin-left: 5px;
    left: 100%;
  }
  .message.sag .messageText:after {
    margin-right: 5px;
    right: 100%;
  }
</style>
</html>

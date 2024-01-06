<%--
  Created by IntelliJ IDEA.
  User: chaehuijeong
  Date: 2023/05/10
  Time: 3:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>chattingRoom</title>
    <link rel="stylesheet" href="/resources/css/chat/chatRoom.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
<div id="email" hidden>
    ${email}
</div>
<div id="chat_room_seq" hidden>
    ${chat_room_seq}
</div>
<div id="chat_category" hidden>
    ${chat_category}
</div>
<div id="receive_user" hidden>
    ${lol_account}
</div>
<div id="profile_icon_id" hidden>
    ${profile_icon_id}
</div>
<div class="chatroom-header">
    <div class="profile-detail">
    </div>
</div>
<div class="chat-around">
    <div class="chat-content">
    </div>
    </div>
    <div class="send-content">
        <textarea name="" oninput="textareaHeight(this)" id="send_content" cols="50" rows="1"></textarea>
        <img src="/resources/img/icon/send.png" alt="" onclick="send()" class="send-img">
    </div>
</div>
<script src="/resources/js/chat/chatRoom.js"></script>
</body>
</html>

package com.etoos.portal.web.chat;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/chat")
public class ChatController {

    @GetMapping(value = "/sb/{channel}")
    public String getSb(Model model, @PathVariable("channel") String channel, String userId, String token){
        model.addAttribute("channel", channel);
        model.addAttribute("userId", userId);
        model.addAttribute("token", token);

        return "chat/sendbird";
    }
}

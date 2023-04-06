package com.etoos.portal.web.linker;

import com.etoos.portal.global.external.LinkerClient;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
public class LinkerController {

    private final Environment env;

    private final LinkerClient linkerClient;

    private String linkerDevFront = "";

    @PostConstruct
    private void setDev(){
        String profile = env.getProperty("spring.config.activate.on-profile");
        linkerDevFront = profile.equals("dev") || profile.equals("local") ? "/front" : "";
    }

    @RequestMapping("/page/portal/talk/detail/{talkNo}")
    public String questionTalk(@PathVariable int talkNo, Model model)
        throws JsonProcessingException {
        String result = linkerClient.talkReDetail(talkNo, linkerDevFront);
        JsonObject json = (JsonObject) JsonParser.parseString(result);
        model.addAttribute("opentalk", new ObjectMapper().readValue(json.get("reloadTalk").getAsJsonObject().toString(), HashMap.class));
        return "pc/portal/talk/detail";
    }

    @RequestMapping("/page/portal/detail/{talkNo}")
    public String mentorColumn(@PathVariable int talkNo, Model model) {
        String activeProfile = env.getProperty("spring.config.activate.on-profile");
        model.addAttribute("talkNo", talkNo);
        model.addAttribute("systemEnv", activeProfile);
        return "pc/portal/detail";
    }

    @RequestMapping("/page/{depth1}/{depth2}")
    public String depth2(@PathVariable String depth1,@PathVariable String depth2){
        return "pc/" + depth1 + "/" + depth2;
    }

    @RequestMapping("/page/{depth1}/{depth2}/{depth3}")
    public String depth3(@PathVariable String depth1,@PathVariable String depth2,@PathVariable String depth3) {
        return "pc/" + depth1 + "/" + depth2 + "/" + depth3;
    }
}

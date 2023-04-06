package com.etoos.portal.web.commonpage;

import com.etoos.portal.global.DeviceType;
import javax.servlet.http.HttpServletRequest;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/common-page")
public class CommonPageController {

    @GetMapping(value = "")
    public String getCommonPage(HttpServletRequest request, Model model, CommonPage commonPage){
        Device device = DeviceUtils.getCurrentDevice(request);

        String viewPath = "web";
        if (commonPage.isApp() || device.isMobile() || device.isTablet()) {
            viewPath = "mobile";
        }

        model.addAttribute("tab", commonPage.getTab());
        model.addAttribute("tabDetail", commonPage.getTabDetail());

        return "common-page/" + viewPath + "/index";
    }
}

package com.etoos.portal.web.piece.presentation;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/piece-portal/presentation")
public class PresentationController {

    @GetMapping(value = "")
    public String presentation(HttpServletRequest request, Model model){
        model.addAttribute("gnbService", request.getParameter("gnbService"));
        model.addAttribute("gnbDetailService", request.getParameter("gnbDetailService"));
        model.addAttribute("gnbBranch", request.getParameter("gnbBranch"));

        return "piece-portal/presentation/index";
    }
}

package com.etoos.portal.web.common;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping(value = "/error")
    public String handleError(Model model, HttpServletRequest request) {
        int statusCode = (int) request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        HttpStatus httpStatus = HttpStatus.resolve(statusCode);
        String reason = httpStatus.getReasonPhrase();

        model.addAttribute("statusCode", statusCode);
        model.addAttribute("reason", reason);

        return "error";
    }
}

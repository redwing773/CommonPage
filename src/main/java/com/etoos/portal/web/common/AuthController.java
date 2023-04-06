package com.etoos.portal.web.common;

import com.etoos.portal.global.response.LoginResponse;
import io.micrometer.core.instrument.util.StringUtils;
import java.lang.reflect.Field;
import java.util.Optional;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/auth")
public class AuthController {

    @GetMapping("/login")
    public String getAuthLogin(@ModelAttribute LoginResponse loginResponse, HttpServletResponse response)
        throws IllegalAccessException {

        if(loginResponse.getIntegratedMemberYn() != null && loginResponse.getIntegratedMemberYn().equals("Y")) {
            Field[] fields = loginResponse.getClass().getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true);

                Object val = field.get(loginResponse);
                Cookie cookie = new Cookie(field.getName(), val != null ? val.toString() : "");
                cookie.setPath("/");
                cookie.setMaxAge(60 * 60 * 24);
                response.addCookie(cookie);
            }
        }

        String redirectUrl = StringUtils.isEmpty(loginResponse.getReturnURL()) ? "/" : loginResponse.getReturnURL();
        return "redirect:" + redirectUrl;
    }
}

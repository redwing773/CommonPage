package com.etoos.portal.global.interceptor;

import com.etoos.portal.global.DeviceType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
@RequiredArgsConstructor
public class DeviceInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
        Object handler) throws Exception {

        return HandlerInterceptor.super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
        ModelAndView modelAndView) throws Exception {
        Device device = DeviceUtils.getCurrentDevice(request);
        boolean isApp = Boolean.parseBoolean(request.getParameter("isApp"));

        if (isApp) {
            request.setAttribute("device", DeviceType.APP.getDevice());
        } else if (device.isMobile() || device.isTablet()) {
            request.setAttribute("device", DeviceType.MOBILE.getDevice());
        } else if (device.isNormal()) {
            request.setAttribute("device", DeviceType.WEB.getDevice());
        }

        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
        Object handler, Exception ex) throws Exception {
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}

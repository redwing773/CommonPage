package com.etoos.portal.global.util;

import com.etoos.portal.global.Constant;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import org.springframework.util.ObjectUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class CommonUtils {

    public static Long getHipIdToAccountNo(String hipId) {
        try {
            return Long.parseLong(EncryptUtils.decryptAES(hipId, Constant.HIP_ACCOUNT_NO_AES_KEY));
        }catch (Exception e){
            return null;
        }
    }

    public static String getClientIP(HttpServletRequest request) {
        if(request == null){
            request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        }
        String clientIp = request.getHeader("X-Forwarded-For");

        if (clientIp == null || clientIp.length() == 0 || "unknown".equalsIgnoreCase(clientIp)) {
            clientIp = request.getHeader("Proxy-Client-IP");
        }

        if (clientIp == null || clientIp.length() == 0 || "unknown".equalsIgnoreCase(clientIp)) {
            clientIp = request.getHeader("WL-Proxy-Client-IP");
        }

        if (clientIp == null || clientIp.length() == 0 || "unknown".equalsIgnoreCase(clientIp)) {
            clientIp = request.getHeader("HTTP_CLIENT_IP");
        }

        if (clientIp == null || clientIp.length() == 0 || "unknown".equalsIgnoreCase(clientIp)) {
            clientIp = request.getHeader("HTTP_X_FORWARDED_FOR");
        }

        if (clientIp == null || clientIp.length() == 0 || "unknown".equalsIgnoreCase(clientIp)) {
            clientIp = request.getRemoteAddr();
        }

        if (clientIp.contains(",")) {
            return clientIp.split(",")[0].trim();
        }

        return clientIp;
    }

    public static String getCookie(HttpServletRequest request, String cookieName) {
        if(request == null){
            request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        }
        Cookie[] cookies = request.getCookies() ;
        String result = "";

        if(cookies != null){
            for(int i=0; i < cookies.length; i++){
                Cookie cookie = cookies[i] ;
                String name = cookie.getName();
                if(!ObjectUtils.isEmpty(cookieName) && cookieName.equals(name)) {
                    result = cookie.getValue();
                    break;
                }
            }
        }

        return result;
    }
}

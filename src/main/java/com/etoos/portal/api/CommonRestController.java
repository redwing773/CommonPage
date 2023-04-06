package com.etoos.portal.api;

import com.etoos.portal.global.api.ApiResult;
import com.etoos.portal.global.util.CommonUtils;
import java.util.HashMap;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CommonRestController {

    @Value("${external.sendbird.app-id}")
    private String sbAppId;

    @Value("${external.sendbird.app-key}")
    private String sbAppKey;

    @Value("${external.etoos.auth-url}")
    private String authUrl;

    @Value("${external.etoos.auth-client-id}")
    private String authClientId;

    @Value("${external.etoos.auth-secret-key}")
    private String authSecretKey;

    @GetMapping("/healthCheck/_check")
    public ApiResult getCustomHealthCheck() {

        return ApiResult.builder()
            .message("ok")
            .build();
    }

    @PostMapping("/auth/client")
    public ApiResult getAuthClient() {
        return ApiResult.builder()
            .value(new HashMap<String, Object>(){{
                put("authUrl", authUrl);
                put("authClientId", authClientId);
                put("authSecretKey", authSecretKey);
            }})
            .build();
    }

    @PostMapping("/auth/check")
    public ApiResult getAuthCheck() {
        return ApiResult.builder()
            .value(new HashMap<String, Object>(){{
                put("accountNo", CommonUtils.getHipIdToAccountNo(""));
            }})
            .build();
    }

    @PostMapping("/auth/sb")
    public ApiResult getSbAuth(HttpServletRequest request) {
        Long accountNo = null;
        for(Cookie cookie : request.getCookies()){
            if(cookie.getName().equals("hipId")) {
                accountNo = Long.parseLong("1000");
                break;
            }
        }
        
        Long finalAccountNo = accountNo;
        return ApiResult.builder()
            .value(new HashMap<String, Object>(){{
                    put("sbAppId", finalAccountNo == null ? "" : sbAppId);
                    put("sbAppKey", finalAccountNo == null ? "" : sbAppKey);
                    put("accountNo", finalAccountNo);
                }})
            .build();
    }
}

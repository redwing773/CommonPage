package com.etoos.portal.api;

import com.etoos.portal.global.Constant;
import com.etoos.portal.global.api.ApiResult;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@CrossOrigin
@RequestMapping(Constant.API_PATH + Constant.API_V1_0_PATH  + "/auth")
public class AuthRestController {

    @Value("${external.etoos.auth-url}")
    private String authUrl;

    @Value("${external.etoos.auth-client-id}")
    private String authClientId;

    @Value("${external.etoos.auth-secret-key}")
    private String authSecretKey;

    @PostMapping("/client")
    public ApiResult getAuthClient() {
        return ApiResult.builder()
            .value(new HashMap<String, Object>(){{
                put("authUrl", authUrl);
                put("authClientId", authClientId);
                put("authSecretKey", authSecretKey);
            }})
            .build();
    }
}

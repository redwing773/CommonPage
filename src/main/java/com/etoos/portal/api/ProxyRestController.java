package com.etoos.portal.api;

import com.etoos.portal.global.Constant;
import com.etoos.portal.global.external.ExternalDTO;
import com.etoos.portal.global.external.JsonMap;
import com.etoos.portal.global.external.LinkerClient;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping(Constant.API_PATH + Constant.API_V1_0_PATH  + "/proxy")
public class ProxyRestController {

    private final LinkerClient linkerClient;

    @RequestMapping(path = "/linker/**")
    public Object linkerServer(HttpServletRequest request, @RequestBody(required = false) Map<String, Object> requestBody) {
        String staticPath = "/api/v1.0/proxy/linker";
        String path = request.getRequestURI().replaceAll(staticPath, "");
        Map<String, String> headers = new HashMap<>();

        Iterator<String> headerIterator = request.getHeaderNames().asIterator();
        while (headerIterator.hasNext()) {
            String headerName = headerIterator.next();
            headers.put(headerName.toLowerCase(), request.getHeader(headerName));
        }
        headers.remove("content-length");

        String body = null;
        if (ObjectUtils.isEmpty(requestBody)) {
            requestBody = new HashMap<>();
            Iterator<String> paramIterator = request.getParameterNames().asIterator();
            while (paramIterator.hasNext()) {
                String param = paramIterator.next();
                requestBody.put(param, request.getParameter(param));
            }
        } else {
            body = new Gson().toJson(requestBody);
        }

        return ExternalDTO.builder()
            .method(RequestMethod.valueOf(request.getMethod()))
            .headers(headers)
            .requestPath(path)
            .externalClient(linkerClient)
            .body(body != null ? body : requestBody)
            .responseClass(Map.class)
            .build().request();
    }
}

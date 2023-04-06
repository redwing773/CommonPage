package com.etoos.portal.global.external;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Map;
import lombok.Builder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMethod;

@Slf4j
@Builder
public class ExternalDTO {
    private RequestMethod method;
    private String requestPath;
    private Object body;
    private Map<String, String> headers;
    private ExternalClient externalClient;
    private Class responseClass;

    public ExternalDTO(RequestMethod method, String requestPath, Object body,
        Map<String, String> headers, ExternalClient externalClient, Class responseClass) {
        this.method = method;
        this.requestPath = requestPath;
        this.body = body;
        this.headers = headers;
        this.externalClient = externalClient;
        this.responseClass = responseClass;
    }

    public Object request(){
        String result = null;
        try {
            boolean isQueryMap = true;
            if (body != null && body instanceof String) {
                try {
                    body = new ObjectMapper().readValue((String) body, Map.class);
                    isQueryMap = false;
                }catch (Exception e){
                }
            }

            switch (method) {
                case GET:
                    if (isQueryMap) {
                        result = externalClient.getQuery(body, headers, requestPath);
                    } else {
                        result = externalClient.get(body, headers, requestPath);
                    }
                    break;
                case POST:
                    if (isQueryMap) {
                        result = externalClient.postQuery(body, headers, requestPath);
                    } else {
                        result = externalClient.post(body, headers, requestPath);
                    }
                    break;
                case PUT:
                    if (isQueryMap) {
                        result = externalClient.putQuery(body, headers, requestPath);
                    } else {
                        result = externalClient.put(body, headers, requestPath);
                    }
                    break;
                case DELETE:
                    if (isQueryMap) {
                        result = externalClient.deleteQuery(body, headers, requestPath);
                    } else {
                        result = externalClient.delete(body, headers, requestPath);
                    }
                    break;
            }
        }catch (Exception e){
            log.error("external exception: {}", e.getMessage());
        }

        if(responseClass != null){
            try {
                return new ObjectMapper().readValue(result, responseClass);
            } catch (Exception e){
            }
        }

        return result;
    }
}


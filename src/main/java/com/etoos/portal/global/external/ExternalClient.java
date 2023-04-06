package com.etoos.portal.global.external;

import java.util.Map;
import org.springframework.cloud.openfeign.SpringQueryMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

public interface ExternalClient {

    @GetMapping("{requestPath}")
    String get(@RequestBody Object body, @RequestHeader Map<String, String> headers, @PathVariable(value = "requestPath") String requestPath);

    @GetMapping(value = "{requestPath}")
    String getQuery(@SpringQueryMap Object body, @RequestHeader Map<String, String> headers, @PathVariable(value = "requestPath") String requestPath);

    @PostMapping("{requestPath}")
    String post(@RequestBody Object body, @RequestHeader Map<String, String> headers, @PathVariable(value = "requestPath") String requestPath);

    @PostMapping("{requestPath}")
    String postQuery(@SpringQueryMap Object body, @RequestHeader Map<String, String> headers, @PathVariable(value = "requestPath") String requestPath);

    @PutMapping("{requestPath}")
    String put(@RequestBody Object body, @RequestHeader Map<String, String> headers, @PathVariable(value = "requestPath") String requestPath);

    @PutMapping("{requestPath}")
    String putQuery(@SpringQueryMap Object body, @RequestHeader Map<String, String> headers, @PathVariable(value = "requestPath") String requestPath);

    @DeleteMapping("{requestPath}")
    String delete(@RequestBody Object body, @RequestHeader Map<String, String> headers, @PathVariable(value = "requestPath") String requestPath);

    @DeleteMapping("{requestPath}")
    String deleteQuery(@SpringQueryMap Object body, @RequestHeader Map<String, String> headers, @PathVariable(value = "requestPath") String requestPath);
}

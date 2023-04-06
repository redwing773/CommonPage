package com.etoos.portal.global.external;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "linker-service", url = "${feign.linker.url}")
public interface LinkerClient extends ExternalClient {

    @GetMapping("{front}/app/opentalk/redetail/{talkNo}?talkNo={talkNo}")
    String talkReDetail(@PathVariable(value = "talkNo") int talkNo, @PathVariable(value = "front") String front);
}

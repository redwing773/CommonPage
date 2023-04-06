package com.etoos.portal.global.api;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ApiResult<T> {

    @Builder.Default
    private int code = ApiStatus.OK.getResultCode();

    @Builder.Default
    private String message = ApiStatus.OK.getResultMessage();

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private T value;

    public static ApiResult getBase() {
        return ApiResult.builder().build();
    }
}

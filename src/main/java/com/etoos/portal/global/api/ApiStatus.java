package com.etoos.portal.global.api;

import lombok.Getter;

public enum ApiStatus {
    OK(0, "Success", "정상처리"),
    SYSTEM_ERROR(500, "System Error", "시스템 내 오류"),
    CLIENT_ERROR(1000, "Client Error", "사용자 오류"),
    EXTERNAL_API_ERROR(1001, "External Api Error", "외부 API 오류"),
    ;

    @Getter
    private final int resultCode;

    @Getter
    private final String resultMessage;

    @Getter
    private final String description;

    ApiStatus(int resultCode, String resultMessage, String description) {
        this.resultCode = resultCode;
        this.resultMessage = resultMessage;
        this.description = description;
    }
}

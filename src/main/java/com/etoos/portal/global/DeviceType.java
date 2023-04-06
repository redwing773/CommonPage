package com.etoos.portal.global;

import lombok.Getter;

public enum DeviceType {

    WEB("web"),
    MOBILE("mobile"),
    APP("app");

    @Getter
    private String device;

    DeviceType(String device) {
        this.device = device;
    }
}

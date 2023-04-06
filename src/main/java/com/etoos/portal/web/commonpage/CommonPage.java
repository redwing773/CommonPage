package com.etoos.portal.web.commonpage;

import lombok.Getter;
import lombok.Setter;

@Getter
public class CommonPage {

    private boolean isApp;
    @Setter
    private String tab;
    @Setter
    private String tabDetail;

    public void setIsApp(boolean isApp) {
        this.isApp = isApp;
    }
}

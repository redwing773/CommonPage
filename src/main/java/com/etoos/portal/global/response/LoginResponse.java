package com.etoos.portal.global.response;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class LoginResponse {
    private String accessToken;
    private String expiresIn;
    private String refreshToken;
    private String refreshTokenExpiresIn;
    private String autoLogin;
    private String returnURL;
    private String integratedMemberYn;
}

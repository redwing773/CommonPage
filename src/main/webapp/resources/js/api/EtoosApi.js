import commonUtils from "../util/CommonUtils.js";

const environment = commonUtils.getSystemMode();
let gCallback = null;

let authUrl = null;
let clientId = null;
let clientSecret = null;
let signInCallbackUrl = null;
let auth = null;

class EtoosApi {

    host = '';

    constructor() {
        this.initHost();

        this.setAuth(function(){
            etoosApi.getToken();
        })
    }

    setAuth(callback) {
        this.post('/auth/client', {}, function(res) {
            clientId = res.value.authClientId;
            clientSecret = res.value.authSecretKey;
            authUrl = res.value.authUrl;

            const config = EtoosSDK.AuthConfiguration({ clientId: clientId, clientSecret: clientSecret, signInCallbackUrl: signInCallbackUrl, environment: environment })
            auth = new EtoosSDK.Auth(config);
            auth.init();
            callback();
        }, '');
    }

    call(callback) {
        gCallback = callback;
    }

    initHost() {
        if(environment == "qa"){
            signInCallbackUrl = "https://qa-portal.etoos.com";
            this.host = "https://stage-api.ilinker.co.kr";
        } else if(environment == "live"){
            signInCallbackUrl = "https://portal.etoos.com";
            this.host = "https://api.ilinker.co.kr";
        } else {
            signInCallbackUrl = "https://dev-portal.etoos.com";
            this.host = "http://203.234.230.51:10004";
        }
    }

    post(path, data, success, cHost) {
        $.ajax({
            url: (cHost == null || cHost == undefined ? this.host : '') + path,
            type: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json',
            xhrFields: {
                withCredentials: true
            },
            success: success
        });
    }

    getToken() {
        console.log("token!");
        this.getAuthorization(function(response){
            console.log(response);

            this.post('/auth/svc/etoos/login', JSON.stringify({
                pushKey: "",
                apnsPushKey: ""
            }), {
                headers: {
                    'authorization': response.value,
                    "osType": "P",
                    "appVersion": "1.1.7"
                }
            }, function(res) {
                commonUtils.setCookie("sbId", res.sendBirdId);
                commonUtils.setCookie("sbToken", res.sendBirdToken);
                gCallback();
                // TODO: res > accessToken
            });
        });
    }

    getAuthorization(callback) {
        if(auth == null){
            return;
        }

        auth.signIn(function (response) {
            console.log(response)
            if (response.code === 0) {
                auth.getToken(function (res) {
                    console.log(res)
                    if (res.code === 0) {
                        callback(res);
                    }
                });
            }
        });
    }

    getChannelList(data) {
        this.post('/consult/svc/listMyGroupChannels', data, function(res) {
            console.log(res);
        }, '');
    }

    login(returnUrl) {
        let reURL = returnUrl ? returnUrl : window.location.href;
        reURL = encodeURIComponent(reURL);
        let callback = signInCallbackUrl + "/auth/login"; // TODO: 토큰응답받을 페이지 url
        const url = authUrl + "/login?clientId=" + clientId + "&callbackUrl="+ callback + "&returnURL=" + reURL
        location.href = url;
    }
}

const etoosApi = new EtoosApi();

export default etoosApi;
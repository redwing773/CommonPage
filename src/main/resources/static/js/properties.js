const properties = {
    apiHost: function(){
        const origin = location.origin;
        let result = "http://203.234.230.51:10004";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            result = "https://stage-api.ilinker.co.kr";
        } else if (origin === 'https://portal.etoos.com') {
            result = "https://api.ilinker.co.kr";
        }

        return result;
    },
    apiHostShop: function(){
        const origin = location.origin;
        let result = "http://203.234.230.51:10004";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            result = "https://stage-api.ilinker.co.kr";
        } else if (origin === 'https://portal.etoos.com') {
            result = "https://api.ilinker.co.kr";
        }

        return result;
    },
    membershipCallbackUrl: function (){
        return location.origin + "/auth/login";
    },
    membershipReturnUrlPortal: function (){
        return location.origin + "/page/portal/talk/list";
    },
    membershipCallbackUrlPortal: function () {
        return location.origin + "/page/portal/talk/write";
    },
    membershipMypageReturnUrl: function (){
        return location.origin + "?prev=integrateMembership";
    },
    membershipAuthDomain: function(){
        const origin = location.origin;
        let result = "https://dev-member.etoos.com";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            result = "https://stage-member.etoos.com";
        } else if (origin === 'https://portal.etoos.com') {
            result = "https://member.etoos.com";
        }

        return result;
    },
    membershipAuthApiDomain: function(){
        const origin = location.origin;
        let result = "https://dev-api.linker.ac";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            result = "https://stage-api.linker.ac";
        } else if (origin === 'https://portal.etoos.com') {
            result = "https://api.linker.ac";
        }

        return result;
    },
    membershipClientId: function(){
        const origin = location.origin;
        let result = "FDC9681217BF12363D7C11C1FF9EB66B";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            result = "03328164578a11672ae98e0d82e7847e";
        } else if (origin === 'https://portal.etoos.com') {
            result = "03328164578a11672ae98e0d82e7847e";
        }

        return result;
    },
    membershipMobileClientId: function(){
        const origin = location.origin;
        let result = "FDC9681217BF12363D7C11C1FF9EB66B";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            result = "03328164578a11672ae98e0d82e7847e";
        } else if (origin === 'https://portal.etoos.com') {
            result = "03328164578a11672ae98e0d82e7847e";
        }

        return result;
    },
    membershipSecretKey: function(){
        const origin = location.origin;
        let result = "12F95D404F50B4310BBC10F8AC423920A5713113B51A7D33CBE77614C051D5D8";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            result = "faeb58a80ea8839105a39486079df9dfa15d054a1b2bbc8379711c1e0b227f9e";
        } else if (origin === 'https://portal.etoos.com') {
            result = "faeb58a80ea8839105a39486079df9dfa15d054a1b2bbc8379711c1e0b227f9e";
        }

        return result;
    },
    etoosGnbUrl: function(){
        const origin = location.origin;
        var cacheVersion = "?ver=" + Date.now();

        let result = "https://dev-gnb.etoos.com/v1/gnb.js";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            result = "https://stage-gnb.etoos.com/v1/gnb.js";
        } else if (origin === 'https://portal.etoos.com') {
            result = "https://gnb.etoos.com/v1/gnb.js";
        }

        return result + cacheVersion;
    },
    getSystemMode: function(){
        const origin = location.origin;
        let mode = "dev";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            mode = "stage";
        } else if (origin === 'https://portal.etoos.com') {
            mode = "live";
        }

        return mode;
    },

    getPortalHost: function() {
        let mode = this.getSystemMode();
        let result = "https://dev-portal.etoos.com";
        if(mode == "stage") {
            result = "https://qa-portal.etoos.com";
        } else if(mode == "live") {
            result = "https://portal.etoos.com";
        }

        return result;
    },
    getMojiSiteHost: function(){
        let mode = this.getSystemMode();
        let result = "https://dev-moji.etoos.com";
        if(mode == "stage") {
            result = "https://qa-moji.etoos.com";
        } else if(mode == "live") {
            result = "https://moji.etoos.com";
        }

        return result;
    },
    apiVersionShop: "v1.0",
    iamportCode: "imp21823785",
    iamportStageCode: "imp68576572",
    iamportTestCode: "imp73712628",
    pgcode: "html5_inicis",
    pgcodeKakao: "kakaopay",
    pgcodeMobile: "mobilians",
    pgcodeDanal: "danal",
    kakaoLiveCode: "21740fabe3f76b58d33af3330324345d",
    kakaoDevCode: "cf004ffed7d8cc16a452be05f6472f8a",
    kakaoDevTmpl: 35008,
    kakaoLiveTmpl: 35806,
    googleDevToken: "534214226223-9ptksolh9met3ma0n7ocgu6etvpq2u29.apps.googleusercontent.com",
    googleLiveToken: "147532707095-9d8qc36pcshi55mbje2b2nlqsdsig4eg.apps.googleusercontent.com",
    kakaoRecommendDevTmpl: 37121,
    kakaoRecommendLiveTmpl: 37124,
    expertMentorDevHipId: "b1180513b1420f4f57ca0206b2355f5b",
    expertMentorLiveHipId: "ec2839c420ff5fb97edaa1ffa8011ac9",
    managerSupportDevHipId: "05e323fc2e3db8891301a1dcaf7a54a3",
    managerSupportLiveHipId: "54dacfbda071e1b2418f23605a4d2864",
    managerDevHipId: "f2cc522aa89d2fbd376d394b7d75ff3b",
    managerLiveHipId: "8f02894932bffb1dfb12ce43bba5154c",
    giftishowCode: "REAL31adad564b1046a3acef7bf72379290a",
    giftishowToken: "rxiWTqQaEy9yS15yGDgDag==",
    giftishowTemplateId: "202011250071190",
    giftishowBannerId: "202011250072892",
    appleDevClientId: "com.linker.applelogin.dev",
    appleDevRedirectUrl: "/front/page/membership/login",
    appleLiveClientId: "com.linker.applelogin.live",
    appleLinkerRedirectUrl: "/page/membership/login",
    appleStageClientId: "com.linker.applelogin.stage",
    appleScope: "name email",
    appleState: "authorized",
    marketerDevHipId: "890b91c5770cd24ca61037c3cd636da2",
    marketerLiveHipId: "9ff694b89ff5779e7af758c7a819822b",
    mojiIamportLiveCode: "imp97281539",
    mojiIamportDevCode: "imp00951499",
    mojiIamportQaCode: "imp33715363"
}
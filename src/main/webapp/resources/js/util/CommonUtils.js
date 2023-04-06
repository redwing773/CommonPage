class CommonUtils {
    isEmpty(obj) {
        return (
            typeof obj === "undefined" ||
            obj === null ||
            !obj ||
            obj.length === 0 ||
            obj === "" ||
            !/[^\s]/.test(obj) ||
            /^\s*$/.test(obj) ||
            (obj !== null && typeof obj === "object" && !Object.keys(
                obj).length)
        );
    }

    getCookie(key) {
        let value = document.cookie.match('(^|;) ?' + key + '=([^;]*)(;|$)');

        return value ? unescape(value[2]) : null;
    }

    setCookie(name, value, options = {}) {

        options = {
            path: '/',
            ...options
        };

        if (options.expires instanceof Date) {
            options.expires = options.expires.toUTCString();
        }

        let updatedCookie = encodeURIComponent(name) + "=" + encodeURIComponent(value);

        for (let optionKey in options) {
            updatedCookie += "; " + optionKey;
            let optionValue = options[optionKey];
            if (optionValue !== true) {
                updatedCookie += "=" + optionValue;
            }
        }

        document.cookie = updatedCookie;
    }

    isIframe() {
        return self !== top;
    }

    isMobile() {
        return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
            navigator.userAgent);
    }

    getSystemMode() {
        const origin = location.origin;
        let mode = "dev";
        if (origin === 'https://qa-portal.etoos.com' || origin === 'https://stage-portal.etoos.com') {
            mode = "qa";
        } else if (origin === 'https://portal.etoos.com') {
            mode = "live";
        }

        return mode;
    }

    random(size) {
        return Math.floor(Math.random() * size);
    }
}

const commonUtils = new CommonUtils();

export default commonUtils;
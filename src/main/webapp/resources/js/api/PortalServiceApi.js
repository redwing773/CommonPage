class PortalServiceApi {

    host = 'http://localhost:8081';
    externalPath = '';

    constructor() {
        this.externalPath = '/ext/portal-service';
        this.versionPath = '/v1.0';

        this.initHost();
    }

    initHost() {
        const origin = location.origin;

        if (origin.indexOf('http://localhost') > -1) {
            this.externalPath = '/portal-service/external';
        }

        if (origin === 'https://dev-portal.etoos.com') {
            this.host = 'https://dev-api.linker.ac';
        } else if (origin === 'https://qa-portal.etoos.com') {
            this.host = 'https://qa-api.linker.ac';
        } else if (origin === 'https://stage-portal.etoos.com') {
            this.host = 'https://stage-api.linker.ac';
        } else if (origin === 'https://portal.etoos.com') {
            this.host = 'https://api.linker.ac';
        }
    }

    post(path, data, success) {

        $.ajax({
            url: this.host + this.externalPath + this.versionPath + path,
            type: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json',
            xhrFields: {
                withCredentials: true
            },
            success: success
        });
    }

    get(path, data, success) {
        $.ajax({
            url: this.host + this.externalPath + this.versionPath + path,
            type: 'GET',
            data: data,
            contentType: 'application/json',
            xhrFields: {
                withCredentials: true
            },
            success: success
        });
    }

    getSync(path, data, success) {
        $.ajax({
            url: this.host + this.externalPath + this.versionPath + path,
            type: 'GET',
            data: data,
            async: false,
            contentType: 'application/json',
            xhrFields: {
                withCredentials: true
            },
            success: success
        });
    }
}

const portalServiceApi = new PortalServiceApi();

export default portalServiceApi;
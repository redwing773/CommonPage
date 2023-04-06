export default class Version {

    prefix = 'portal main v';

    constructor(version) {
        this.version = version;
    }

    printVersion() {
        console.log(this.prefix + this.version);
    }
}
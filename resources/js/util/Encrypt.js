class Encrypt {
    /**
     * AES256 암호화
     * 
     * @param {string} secretKey secret key
     * @param {string} Iv 초기화 벡터
     * @param {string} data 값
     * @return {string} 암호화
     */
    aes256Encode(secretKey, Iv, data) {
        const cipher = CryptoJS.AES.encrypt(data, CryptoJS.enc.Utf8.parse(secretKey), {
            iv: CryptoJS.enc.Utf8.parse(Iv),
            padding: CryptoJS.pad.Pkcs7,
            mode: CryptoJS.mode.CBC
        });

        return cipher.toString();
    }

    /**
     * AES256 복호화
     * 
     * @param {string} secretKey secret key
     * @param {string} Iv 초기화 벡터
     * @param {string} data 값
     * @return {string} 복호화
     */
    aes256Decode(secretKey, Iv, data) {
        const cipher = CryptoJS.AES.decrypt(data, CryptoJS.enc.Utf8.parse(secretKey), {
            iv: CryptoJS.enc.Utf8.parse(Iv),
            padding: CryptoJS.pad.Pkcs7,
            mode: CryptoJS.mode.CBC
        });

        return cipher.toString(CryptoJS.enc.Utf8);
    }
}

const encrypt = new Encrypt();

export default encrypt;
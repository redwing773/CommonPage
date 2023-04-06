package com.etoos.portal.global.util;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class EncryptUtils {
    /**
     * AES Decode
     *
     * @param encrypted, keyStr
     * @return
     * @throws Exception
     */
    public static String decryptAES(String encrypted, byte[] key) throws Exception {
        String originalString;
        try {
            if (null != encrypted) {
                SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");
                Cipher cipher;
                cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
                cipher.init(Cipher.DECRYPT_MODE, skeySpec);
                byte[] original = cipher.doFinal(hexToByteArray(encrypted));
                originalString = new String(original, "UTF-8");
            } else
                originalString = "";
        } catch (Exception e) {
            e.printStackTrace();
            originalString = "";
            throw e;
        }
        return originalString;
    }

    /**
     * 16진 문자열을 byte 배열로 변환
     *
     * @param hex
     * @return
     */
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[] {};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
}

package com.etoos.portal.global;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

@Component
public class Webpack {

    @Autowired
    private Environment env;

    private static JsonObject asset;

    @PostConstruct
    private void setEnv(){
        String activeProfile = env.getProperty("spring.config.activate.on-profile");
        try {
            InputStream inputStream = new ClassPathResource("static/asset-manifest.json").getInputStream();

            ByteArrayOutputStream result = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int length;
            while ((length = inputStream.read(buffer)) != -1) {
                result.write(buffer, 0, length);
            }

            if(activeProfile == null || !activeProfile.equals("local")) {
                asset = (JsonObject) JsonParser.parseString(result.toString("UTF-8"));
            }
        }
        catch (Exception e) {
        }
    }

    public static String getManifestResource(String filename) {
        if(asset != null && asset.get(filename) != null ){
            return "/dist/" + asset.get(filename).getAsString();
        } else {
            return "/resources/" + filename;
        }
    }
}

package org.oscwii.shop.services;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.google.common.io.ByteArrayDataOutput;
import com.google.common.io.ByteStreams;
import jakarta.servlet.http.HttpServletRequest;
import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import org.apache.tomcat.util.codec.binary.Base64;
import org.oscwii.shop.config.ShopServerConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

import static com.google.common.net.MediaType.PLAIN_TEXT_UTF_8;
import static java.nio.charset.StandardCharsets.UTF_8;

@Service
public class DownloadService
{
    private final Cache<String, Boolean> tokens;
    private final Logger logger;
    private final OkHttpClient httpClient;
    private final ShopServerConfig config;

    public DownloadService(OkHttpClient httpClient, ShopServerConfig config)
    {
        this.tokens = CacheBuilder.newBuilder()
            .expireAfterWrite(5, TimeUnit.MINUTES)
            .build();
        this.logger = LoggerFactory.getLogger(DownloadService.class);
        this.httpClient = httpClient;
        this.config = config;
    }

    public boolean isValidToken(String token)
    {
        if(tokens.getIfPresent(token) != null)
        {
            tokens.invalidate(token);
            return true;
        }

        return false;
    }

    public String generateToken(String app)
    {
        String secRand = UUID.randomUUID().toString();
        String token = UUID.nameUUIDFromBytes((app + secRand).getBytes(UTF_8)).toString();
        token = token.replace("-", "");
        tokens.put(token, true);
        return token;
    }

    public void notifyDownload(String slug, HttpServletRequest request)
    {
        Request req = new Request.Builder()
            .url(config.apiHost() + "/shop/download/" + slug)
            .header("Authorization", config.repoManAccessToken())
            .method("POST", RequestBody.create(getDownloadKey(request, slug), MediaType.get(PLAIN_TEXT_UTF_8.toString())))
            .build();

        httpClient.newCall(req).enqueue(new Callback()
        {
            @Override
            public void onFailure(Call call, IOException e)
            {
                // Fail silently to the user
                logger.error("Failed to notify download for {}", slug, e);
            }

            @Override
            public void onResponse(Call call, Response response)
            {
                if(!response.isSuccessful())
                {
                    logger.error("Failed to notify download for {}: Status Code {}: {}", slug, response.code(),
                        response.message());
                }
            }
        });
    }

    private String getDownloadKey(HttpServletRequest req, String slug)
    {
        ByteArrayDataOutput encode = ByteStreams.newDataOutput();
        encode.writeUTF(req.getRemoteAddr());
        encode.writeUTF(req.getHeader("User-Agent"));
        encode.writeUTF(slug);
        return Base64.encodeBase64String(encode.toByteArray());
    }
}

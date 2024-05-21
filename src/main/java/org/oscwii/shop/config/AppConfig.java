package org.oscwii.shop.config;

import com.google.gson.Gson;
import io.sentry.okhttp.SentryOkHttpEventListener;
import io.sentry.okhttp.SentryOkHttpInterceptor;
import okhttp3.OkHttpClient;
import org.oscwii.api.OSCAPI;
import org.oscwii.api.impl.APIBackend;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.info.GitProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Optional;

@Configuration
public class AppConfig
{
    @Bean
    public OkHttpClient httpClient()
    {
        return new OkHttpClient.Builder()
                .addInterceptor(new SentryOkHttpInterceptor())
                .eventListener(new SentryOkHttpEventListener())
                .build();
    }

    @Bean
    public OSCAPI shopApi(Gson gson, OkHttpClient httpClient, ShopServerConfig config)
    {
        return new APIBackend(gson, httpClient, config.apiHost(), "OSC WSC Server");
    }

    @Autowired
    public void setupSentry(Optional<GitProperties> gitProperties)
    {
        String rel = gitProperties.isEmpty() ? "DEV" : gitProperties.get().getCommitId();
        System.setProperty("shopserver.release", rel);
        System.setProperty("sentry.release", rel);
        System.setProperty("sentry.stacktrace.app.packages", "org.oscwii");
    }
}

package org.oscwii.shop.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.NestedConfigurationProperty;

@ConfigurationProperties(prefix = "shop-server")
public record ShopServerConfig(String apiHost, @NestedConfigurationProperty ContentConfig contentConfig,
                               boolean development, boolean handleEc, String repoManAccessToken)
{
}

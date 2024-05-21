package org.oscwii.shop.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "shop-server")
public record ShopServerConfig(String apiHost, boolean handleEc)
{
}

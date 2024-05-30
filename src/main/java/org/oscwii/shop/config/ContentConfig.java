package org.oscwii.shop.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

import java.nio.file.Path;

@ConfigurationProperties(prefix = "shop-server.contents")
public record ContentConfig(Path nandLoaderPath, Path appInstallerPath)
{
}

package org.oscwii.shop;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.oscwii.api.OSCAPI;
import org.oscwii.shop.config.ShopServerConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.concurrent.TimeUnit;

@SpringBootApplication
@Controller
@ConfigurationPropertiesScan(value = "org.oscwii.shop.config")
public class ShopServer
{
    private final Logger logger;
    private final OSCAPI api;
    private final ShopServerConfig config;

    @Autowired
    public ShopServer(OSCAPI api, ShopServerConfig config)
    {
        this.logger = LogManager.getLogger(ShopServer.class);
        this.api = api;
        this.config = config;
    }

    @GetMapping
    public String initial(Model model)
    {
        model.addAttribute("handleEc", config.handleEc());
        return "initial";
    }

    @GetMapping("/debug")
    public String debug()
    {
        // TODO only enable when not running in prod mode
        return "debug";
    }

    @Scheduled(fixedDelay = 1, timeUnit = TimeUnit.HOURS)
    public void refreshCatalog()
    {
        api.fetchRepositoryInformation();
        api.fetchPackages();
        api.fetchFeaturedApp();
        logger.info("Fetched {} packages from the catalog", api.getPackages().size());
    }

    public static void main(String[] args)
    {
        SpringApplication.run(ShopServer.class, args);
    }
}

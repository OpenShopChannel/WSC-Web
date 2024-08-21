package org.oscwii.shop;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.oscwii.shop.config.ShopServerConfig;
import org.oscwii.shop.services.CatalogService;
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
    private final CatalogService catalog;
    private final Logger logger;
    private final ShopServerConfig config;

    @Autowired
    public ShopServer(CatalogService catalog, ShopServerConfig config)
    {
        this.catalog = catalog;
        this.logger = LogManager.getLogger(ShopServer.class);
        this.config = config;

        if(config.development())
            logger.info("Server is running on development mode, debug will be enabled");
    }

    @GetMapping
    public String initial(Model model)
    {
        model.addAttribute("handleEc", config.handleEc())
            .addAttribute("isDevelopment", config.development());
        return "initial";
    }

    @Scheduled(fixedDelay = 1, timeUnit = TimeUnit.HOURS)
    public void refreshCatalog()
    {
        catalog.refresh();
        logger.info("Fetched {} packages from the catalog", catalog.getPackages().size());
    }

    public static void main(String[] args)
    {
        SpringApplication.run(ShopServer.class, args);
    }
}

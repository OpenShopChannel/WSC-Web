package org.oscwii.shop.controllers;

import org.oscwii.shop.config.ShopServerConfig;
import org.oscwii.shop.services.CatalogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;

public abstract class BaseController
{
    @Autowired
    protected ShopServerConfig config;
    @Autowired
    protected CatalogService catalog;

    @ModelAttribute("handleEc")
    protected boolean handleEc()
    {
        return config.handleEc();
    }
}

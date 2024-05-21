package org.oscwii.shop.controllers;

import org.oscwii.shop.config.ShopServerConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;

public abstract class BaseController
{
    @Autowired
    private ShopServerConfig config;

    @ModelAttribute("handleEc")
    protected boolean handleEc()
    {
        return config.handleEc();
    }
}

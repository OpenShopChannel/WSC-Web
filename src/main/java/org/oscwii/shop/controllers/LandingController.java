package org.oscwii.shop.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LandingController extends BaseController
{
    @GetMapping("/landing")
    public String landing()
    {
        return "landing";
    }

    @GetMapping("/home")
    public String home()
    {
        return "home";
    }
}

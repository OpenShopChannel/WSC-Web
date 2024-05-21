package org.oscwii.shop.controllers;

import org.oscwii.api.Package;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class PageController extends BaseController
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

    @GetMapping("/browse")
    public String browse(@RequestParam(required = false, defaultValue = "games") String category, Model model)
    {
        model.addAttribute("category", category);
        return "browse";
    }

    @GetMapping("/search")
    public String search(@RequestParam(required = false) String query, @RequestParam String type,
                         @RequestParam(required = false) String category, Model model)
    {
        if(type.equals("publishers"))
            return "publishers";
        List<Package> packages = api.filterPackages(category, query);
        model.addAttribute("packages", packages);
        return "catalog";
    }
}

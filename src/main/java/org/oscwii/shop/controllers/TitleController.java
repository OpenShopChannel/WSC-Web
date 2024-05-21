package org.oscwii.shop.controllers;

import org.oscwii.api.Package;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
@RequestMapping("/title/{slug}/")
public class TitleController extends BaseController
{
    @GetMapping
    public String details()
    {
        return "title/title";
    }

    @GetMapping("controllers")
    public String controllers(Model model, @RequestParam Optional<Boolean> download,
                              @RequestParam Optional<String> location, @RequestParam Optional<String> nextPage)
    {
        model.addAttribute("isDownload", download.orElse(false))
            .addAttribute("location", location.orElse(""))
            .addAttribute("nextPage", nextPage.orElse(""));
        return "title/controllers";
    }

    @GetMapping("details")
    public String moreDetails()
    {
        return "title/details";
    }

    @GetMapping("prepare-download")
    public String prepareDownload()
    {
        return "title/prepare-download";
    }

    @GetMapping("download")
    public String download()
    {
        return "title/download";
    }

    @ModelAttribute("package")
    private Package getPackage(@PathVariable String slug)
    {
        return api.getBySlug(slug);
    }
}

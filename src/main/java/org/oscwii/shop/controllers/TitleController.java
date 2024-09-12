package org.oscwii.shop.controllers;

import org.oscwii.api.Package;
import org.oscwii.shop.config.ContentConfig;
import org.oscwii.shop.services.DownloadService;
import org.oscwii.shop.utils.DownloadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.LinkedHashSet;
import java.util.Optional;
import java.util.Set;

@Controller
@RequestMapping("/title/{slug}/")
public class TitleController extends BaseController
{
    private final DownloadService downloadService;

    @Autowired
    public TitleController(ContentConfig contentConfig, DownloadService downloadService)
    {
        this.downloadService = downloadService;
        DownloadUtil.setConfig(contentConfig);
    }

    @GetMapping
    public String details(Package app, Model model)
    {
        model.addAttribute("blocks", app == null ? 0 : DownloadUtil.getTotalBlockSize(app));
        return "title/title";
    }

    @GetMapping("controllers")
    public String controllers(Model model, @RequestParam Optional<Boolean> download,
                              @RequestParam Optional<String> location, @RequestParam Optional<String> nextPage)
    {
        Package app = (Package) model.getAttribute("package");
        // Doing this to remove the duplicates
        Set<String> controllers = app == null ? Set.of() : new LinkedHashSet<>(app.peripherals());
        model.addAttribute("controllers", controllers)
            .addAttribute("isDownload", download.orElse(false))
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
    public String prepareDownload(Package app, Model model)
    {
        long appSize = app == null ? 0 : app.titleInfo().tmdSize() + app.titleInfo().contentsSize();
        long totalSize = app == null ? 0 : DownloadUtil.getTotalAppSize(app);
        long installerSize = totalSize - appSize;

        model.addAttribute("appBlocks", DownloadUtil.getBlockSize(appSize))
            .addAttribute("installerBlocks", DownloadUtil.getBlockSize(installerSize))
            .addAttribute("totalBlocks", DownloadUtil.getBlockSize(totalSize));
        return "title/prepare-download";
    }

    @GetMapping("download")
    public String download(Package app, @RequestParam @ModelAttribute("location") String location, Model model)
    {
        if(app != null)
        {
            String token = downloadService.generateToken(app.slug());
            model.addAttribute("token", token);
        }

        return "title/download";
    }

    @ModelAttribute("package")
    private Package getPackage(@PathVariable String slug)
    {
        return catalog.getBySlug(slug);
    }
}

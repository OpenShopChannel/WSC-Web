package org.oscwii.shop.controllers;

import jakarta.servlet.http.HttpServletRequest;
import org.oscwii.shop.services.DownloadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/stat")
public class StatController
{
    private final DownloadService downloadService;

    @Autowired
    public StatController(DownloadService downloadService)
    {
        this.downloadService = downloadService;
    }

    @PostMapping("/download/{slug}")
    public ResponseEntity<?> notifyDownload(@PathVariable String slug, @RequestParam String token, HttpServletRequest request)
    {
        if(token == null || token.isBlank())
            return ResponseEntity.badRequest().body("No token provided");
        if(!downloadService.isValidToken(token))
            return ResponseEntity.badRequest().body("Invalid token");

        downloadService.notifyDownload(slug, request);
        return ResponseEntity.noContent().build();
    }
}

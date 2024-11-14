package org.oscwii.shop.services;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.oscwii.api.Package;
import org.oscwii.shop.ShopServer;
import org.oscwii.shop.model.RTitlesPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

@Service
public class RTitlesService
{
    private final CatalogService catalog;
    private final Gson gson;
    private final List<RTitlesPage> pages;

    @Autowired
    public RTitlesService(CatalogService catalog, Gson gson) throws IOException
    {
        this.catalog = catalog;
        this.gson = gson;
        this.pages = loadTitles();
    }

    public List<RTitlesPage> getPages()
    {
        List<RTitlesPage> pages = new LinkedList<>();
        for(RTitlesPage page : this.pages)
        {
            if(!page.dynamic())
            {
                pages.add(new RTitlesPage(page,
                    Arrays.stream(page.apps())
                        .map(slug ->
                        {
                            Package pkg = catalog.getBySlug(slug);
                            return pkg == null ? "unknown" : pkg.name();
                        })
                        .toArray(String[]::new)));
                continue;
            }

            var newPage = new RTitlesPage(page, getDynamicTitles(page.apps()));
            pages.add(newPage);
        }

        return pages;
    }

    private String[] getDynamicTitles(String[] apps)
    {
        String[] titles = new String[apps.length];

        for(int i = 0; i < apps.length; i++)
        {
            String app = apps[i];
            if(!app.startsWith("osc:"))
            {
                titles[i] = app;
                continue;
            }

            String[] parts = app.split(":", 3);
            Package pkg;
            switch(parts[1])
            {
                case "featuredapp":
                    pkg = catalog.getFeaturedApp();
                    titles[i] = pkg == null ? "unknown" : pkg.slug();
                    break;
                case "newest":
                    if(parts.length > 2)
                    {
                        pkg = getNewestPackage(parts[2]);
                        titles[i] = pkg == null ? "unknown" : pkg.slug();
                    }
                    else
                    {
                        pkg = catalog.getNewestPackages().get("newest");
                        titles[i] = pkg == null ? "unknown" : pkg.slug();
                    }
                    break;
            }
        }

        return titles;
    }

    private Package getNewestPackage(String category)
    {
        return catalog.getNewestPackages().get(category);
    }

    private List<RTitlesPage> loadTitles() throws IOException
    {
        List<RTitlesPage> pages = new LinkedList<>();

        Path file = Path.of("data", "recommended.json");
        if(Files.notExists(file))
        {
            try(InputStream res = ShopServer.class.getResourceAsStream("data/recommended.json"))
            {
                if(res == null)
                    throw new IllegalStateException("Could not find recommended.json in resources!");
                Files.copy(res, file);
            }
        }

        try(Reader reader = Files.newBufferedReader(file))
        {
            JsonArray root = gson.fromJson(reader, JsonArray.class);
            for(JsonElement element : root.asList())
            {
                JsonObject obj = element.getAsJsonObject();
                var page = new RTitlesPage(obj.get("id").getAsString(),
                    obj.get("title").getAsString(),
                    obj.get("subtitle").getAsString(),
                    obj.has("dynamic") && obj.get("dynamic").getAsBoolean(),
                    gson.fromJson(obj.getAsJsonArray("apps"), String[].class));
                pages.add(page);
            }
        }

        return pages;
    }
}

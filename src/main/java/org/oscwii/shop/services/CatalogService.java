package org.oscwii.shop.services;

import org.oscwii.api.Category;
import org.oscwii.api.OSCAPI;
import org.oscwii.api.Package;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CatalogService
{
    private final OSCAPI api;

    private Map<String, String> newestApps;

    @Autowired
    public CatalogService(OSCAPI api)
    {
        this.api = api;
        this.newestApps = Collections.emptyMap();
    }

    public void refresh()
    {
        api.fetchRepositoryInformation();
        api.fetchPackages();
        api.fetchFeaturedApp();
        this.newestApps = calculateNewestPackages();
    }

    public Package getBySlug(String slug)
    {
        return api.getBySlug(slug);
    }

    public Package getFeaturedApp()
    {
        return api.getFeaturedApp();
    }

    public Map<String, Package> getNewestPackages()
    {
        Map<String, Package> packages = new HashMap<>();
        for(Map.Entry<String, String> entry : newestApps.entrySet())
            packages.put(entry.getKey(), api.getBySlug(entry.getValue()));
        return packages;
    }

    public List<Package> getPackages()
    {
        return api.getPackages();
    }

    public List<Package> filterPackages(String category, String query)
    {
        return api.filterPackages(category, query);
    }

    private Map<String, String> calculateNewestPackages()
    {
        Map<String, String> packages = new HashMap<>();
        packages.put("newest", getNewest(getPackages()));

        for(Category category : api.getCategories())
        {
            String newest = getNewest(filterPackages(category.name(), null));
            if(newest != null)
                packages.put(category.name(), newest);
        }

        return packages;
    }

    private String getNewest(List<Package> selection)
    {
        long date = 0;
        Package selected = null;

        for(Package app : selection)
        {
            if(date < app.releaseDate())
            {
                date = app.releaseDate();
                selected = app;
            }
        }

        return selected != null ? selected.slug() : null;
    }
}

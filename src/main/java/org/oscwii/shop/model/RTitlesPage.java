package org.oscwii.shop.model;

public record RTitlesPage(String id, String title, String subtitle, boolean dynamic, String[] apps)
{
    public RTitlesPage(RTitlesPage oldPage, String[] apps)
    {
        this(oldPage.id(), oldPage.title(), oldPage.subtitle(), oldPage.dynamic(), apps);
    }
}

package org.oscwii.shop.utils;

import java.util.List;

public class Paginator<T>
{
    private final List<T> items;
    private final int itemsPerPage;
    private final int pages;

    public Paginator(List<T> items)
    {
        this(items, 10);
    }

    public Paginator(List<T> items, int itemsPerPage)
    {
        this.items = items;
        this.itemsPerPage = itemsPerPage;
        this.pages = (int) Math.ceil((double) items.size() / itemsPerPage);
    }

    public int getNumberOfPages()
    {
        return pages;
    }

    public List<T> paginate(int page)
    {
        page = Math.min(Math.max(page, 1), pages);
        return getPage(page);
    }

    private List<T> getPage(int pageNum)
    {
        int start = (pageNum - 1) * itemsPerPage;
        int end = Math.min(pageNum * itemsPerPage, items.size());
        return items.subList(start, end);
    }
}

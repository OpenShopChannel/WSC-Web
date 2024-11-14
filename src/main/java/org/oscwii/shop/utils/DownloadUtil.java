package org.oscwii.shop.utils;

import org.oscwii.api.Package;
import org.oscwii.api.Package.ShopTitle;
import org.oscwii.shop.config.ContentConfig;

import java.io.IOException;
import java.nio.file.Files;

public class DownloadUtil
{
    /**
     * The size of the app: TMD (Banner and Ticket) + Contents (Launcher and the actual app)
     *
     * @param app the app
     * @return the app size, in bytes
     */
    public static long getTotalAppSize(Package app)
    {
        ShopTitle titleInfo = app.titleInfo();
        return titleInfo.tmdSize() + calculateContentsSize(titleInfo);
    }

    public static long getTotalBlockSize(Package app)
    {
        return getBlockSize(getTotalAppSize(app));
    }

    public static long getBlockSize(double size)
    {
        double megaBytes = size / 1024 / 1024;
        return (long) Math.ceil(megaBytes * 8);
    }

    private static long calculateContentsSize(ShopTitle titleInfo)
    {
        long size = titleInfo.contentsSize();

        try
        {
            // TODO this probably should be calculated one-time
            // but then what if the file changes?
            size += Files.size(CONFIG.nandLoaderPath());
            size += Files.size(CONFIG.appInstallerPath());
        }
        catch(IOException e)
        {
            throw new RuntimeException("Failed to calculate NAND Loader/App Installer content size:", e);
        }

        return size;
    }

    private static ContentConfig CONFIG;
    public static void setConfig(ContentConfig config)
    {
        DownloadUtil.CONFIG = config;
    }
}

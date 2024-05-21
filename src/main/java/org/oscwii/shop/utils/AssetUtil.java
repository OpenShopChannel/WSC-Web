package org.oscwii.shop.utils;

import org.oscwii.api.Package;
import org.oscwii.api.Package.Asset;

@SuppressWarnings("unused")
public class AssetUtil
{
    public static String getWSCIconUrl(Package app)
    {
        // WSC won't load content over HTTPS for other (sub)domains
        return app.assets().get(Asset.Type.ICON).url().replace("https", "http");
    }
}

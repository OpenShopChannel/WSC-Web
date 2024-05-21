package org.oscwii.shop.utils;

import org.oscwii.api.Package;
import org.oscwii.api.Package.Asset;

public class AssetUtil
{
    public static Asset getIcon(Package app)
    {
        return app.assets().get(Asset.Type.ICON);
    }
}

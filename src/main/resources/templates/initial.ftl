<#import "includes/base-layout.ftl" as layout>
<@layout.header.header "Connecting">
    <script type="text/javascript">
        const info = ec.getDeviceInfo();
        document.cookie = "language=" + info.language;

        shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

        function redirect() {
            window.location.href = "/landing";
        }

        function onLoad() {
            onLoadCommon();

            shop.beginWaiting();

            <#if handleEc>
            // We'll take the opportunity to register the Wii with our server.
            doRegistrationDosido(function () {
                redirect();
            });
            <#else>
            setTimeout(redirect, 4500);
            </#if>

            // Prevent the classic 209601 timeout error
            $("#connecting").text(shop.connecting);
        }
    </script>

    <style>
        #connecting {
            text-align: center;
            margin: 20px 80px 0 80px;
        }
    </style>
</@layout.header.header>

<@layout.navigation/>

<@layout.page>
    <p class="blue heading" id="connecting">Connecting. Please wait...</p>
</@layout.page>

<@layout.footer/>
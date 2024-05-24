<#import "includes/base-layout.ftl" as layout>
<@layout.header.header "Landing">
    <script type="text/javascript">
		// hmm, maybe something can be done here where if the dots variable is false, it implicitly sets the wallpaper to white
		shop.setWallpaper(WallpaperType.WHITE);

		function onLoad() {
			onLoadCommon();

			shop.endWaiting();
			sound.playBGM();
		}
	</script>

	<style>
		#main-header-contents {
			text-align: center;
		}

		#main-heading {
			display: inline;
			font-size: 30px;
		}

		#start-shopping-btn {
			margin: auto;
			font-size: 24px;
		}
	</style>
</@layout.header.header>

<@layout.navigation dots=false>
            <span class="blue">Recommended Titles</span>
</@layout.navigation>

<@layout.page>
        <p>hai</p>
</@layout.page>

<@layout.footer dots=false>
    <@layout.osc.btn body="Start Browsing" id="start-shopping-btn" href="/home" w="353px" h="56px"/>
</@layout.footer>
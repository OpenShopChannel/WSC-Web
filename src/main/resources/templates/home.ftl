<#import "includes/base-layout.ftl" as layout>
<@layout.header.header "Home">
    <script type="text/javascript">
		shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

		function onLoad() {
			onLoadCommon();

			$("#wii-menu-btn .btn-body").text(shop.menuBtn);
		}
	</script>

	<style type="text/css">
		#main-content {
			/* oh nintendo */
			padding: 0px 24px 0px 25px;
		}

		/* if font size being 16px for buttons with icons is recurring I should just make the button template do that automatically */
		.btns-top-category .btn {
			font-size: 16px;
		}

		.btns-middle-category {
			margin: 12px auto;
		}
	</style>
</@layout.header.header>

<@layout.navigation showTitle=false>
    <h1 class="blue heading link" id="main-heading"><a href="/landing">${TemplateUtil.openify("Open")} Shop Channel</a></h1>
</@layout.navigation>

<@layout.page>
	<div class="justify-hr btns-top-category">
		<div><@layout.osc.btn body="Games" href="/browse?category=games" w="173px" h="131px" img="static/img/icons/controller.svg" img_w="92"/></div>
		<div><@layout.osc.btn body="Media" href="/browse?category=media" w="167px" h="131px" img="static/img/icons/media.svg" img_w="79"/></div>
		<div><@layout.osc.btn body="Utilities" href="/browse?category=utilities" w="173px" h="131px" img="static/img/icons/utilities.svg" img_w="50"/></div>
	</div>

	<#-- {{ osc.btn(_("View More"), href="", w="292px", h="69px", style="margin: 12px auto;") }} -->
	<div class="justify-hr btns-middle-category">
		<div><@layout.osc.btn body="Emulators" href="/browse?category=emulators" w="268px" h="69px"/></div>
		<div><@layout.osc.btn body="Demos" href="/browse?category=demos" w="268px" h="69px"/></div>
	</div>

	<div class="justify-hr btns-bottom">
		<div><@layout.osc.btn body="Option 1" class="btn-alt" href="" w="182px" h="56px"/></div>
		<div><@layout.osc.btn body="Titles You've Downloaded" class="btn-alt" href="" w="182px" h="56px"/></div>
		<div><@layout.osc.btn body="Settings and Features" class="btn-alt" href="" w="182px" h="56px"/></div>
	</div>
</@layout.page>

<@layout.footer>
	<div id="main-footer-btns">
		<@layout.osc.btn body="Wii Menu" id="wii-menu-btn" href="javascript:shop.returnToMenu()" style="float: left"/>
		<@layout.osc.btn body="Something" id="other-btn" style="float: right"/>
	</div>
</@layout.footer>
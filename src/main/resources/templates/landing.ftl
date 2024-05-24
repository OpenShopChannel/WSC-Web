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

	<style type="text/css">
		#main-content {
			margin: 0px 30px 0px 36px;
		}

		.items {
			/* :( */
			margin-left: -8px;
		}

		.items > .item {
			float: left;
			margin: 0px 0px 4px 14px;
		}

		/* yaaay dumb hacks i have to do to bump the title down 1px and not affect everything when you hover (indicated by "yep") */
		.btn-item .top {
			padding: 3px;
			/* padding-top: 3px;*/ /* yep (ok well maybe not because while it's more accurate on desktop, it's not on Wii. AAAAAAAARRRGGGGHHHH */
			line-height: 1;
		}

		.btn-item .sep {
			height: 1px;
			display: block;
			background-color: #34beed;
			margin: 0px 11px;
			margin-top: -2px; /* yep */
		}

		/* This *really* affects SVG button performance */
		.btn-item:hover .sep {
			outline: 1px solid #34beed; /* use outline because it doesn't affect flow as it doesn't change element height (yep) */
			margin: 0px 12px;
			margin-top: -2px; /* yep */
		}

		/* TODO: fixed size for the title count specifically */
		.btn-item .bottom {
			text-align: right;
			padding: 0px 8px;
			line-height: 1;
		}

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

<#macro recommendedTitle slug title author banner="static/img/title_placeholder.png">
	<div class="item">
		<a class="btn btn-item" href="/title/${slug}/" style="width: 233px; height: 51px">
			<span>
				<span class="btn-img-c"><img class="btn-img" src="${banner}" width="128" height="48"/></span>
				<span class="btn-body">
					<span class="item-title">${title}</span>
					<span class="item-author">${author}</span>
				</span>
			</span>
		</a>
	</div>
</#macro>

<@layout.page>
	<div class="items">
		<@recommendedTitle slug="danbo" title="Danbo" author="Danbo"/>
		<@recommendedTitle slug="danbo2" title="Danbo2" author="Danbo"/>
		<@recommendedTitle slug="danbo3" title="Danbo3" author="Danbo"/>
		<@recommendedTitle slug="danbo4" title="Danbo4" author="Danbo"/>
	</div>
</@layout.page>

<@layout.footer dots=false>
    <@layout.osc.btn body="Start Shopping" id="start-shopping-btn" href="/home" w="353px" h="56px"/>
</@layout.footer>
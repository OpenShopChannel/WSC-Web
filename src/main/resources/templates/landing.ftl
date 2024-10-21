<#import "includes/base-layout.ftl" as layout>
<#assign AssetUtil=statics['org.oscwii.shop.utils.AssetUtil']>
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
			margin: 0px 15px 0px 15px;
		}

		.items {
			/* :( */
			margin-left: -8px;
		}

		.items > .item {
			float: left;
			margin: 0px 0px 4px 14px;
			width: 250px;
			height: 100px;
		}

		.item-title {
			inline-size: 94px;
			overflow-wrap: break-word;
			hyphens: auto;
			hyphenate-character: "-";
		}

		.category-heading {
			width: 200px;
			height: 22px;
			background-color: #34beed; /* I give up with roundedness for now */
			color: white;
			padding: 0px 5px;
			font-size: 14px;
			font-weight: bold;
			line-height: 25px; /* element is a fixed size, positioning like this should work well enough */
		}

		.category-heading-aod {
			background-color: #ffd324;
			color: #000000B2;
		}

		.category-heading-games {
			background-color: #ED349F;
		}

		.category-heading-emulators {
			background-color: #34ED90;
			color: #000000B2;
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
            <span class="blue"><#--Recommended Titles-->Highlights</span>
</@layout.navigation>

<#macro recommendedTitle slug name author category categoryId banner="static/img/title_placeholder.png">
	<div class="item">
		<div class="category-heading category-heading-${categoryId}"${category}</div>
		<a class="btn btn-item" href="/title/${slug}/" style="width: 250px; height: 51px">
			<span>
				<span class="btn-img-c">
					<img class="btn-img" src="${banner}" width="128" height="48"/>
				</span>
				<span class="btn-body">
					<#-- hacky hack -->
					<span class="item-title" style="font-size: <#if name?length < 15>16px<#else>14px</#if>">
						${name}
					</span>
					<#--<span class="item-author">${author}</span>-->
				</span>
			</span>
		</a>
	</div>
</#macro>

<@layout.page>
	<div class="items">
	<#if featuredPackage??>
		<@recommendedTitle featuredPackage.slug() featuredPackage.name()
			featuredPackage.author() "App of the Day" "aod" AssetUtil.getWSCIconUrl(featuredPackage)
		/>
	</#if>
	<#if newestPackages??>
		<#if newestPackages["games"]??>
			<@recommendedTitle newestPackages["games"].slug() newestPackages["games"].name()
			newestPackages["games"].author() "Latest update in ${newestPackages['games'].category()?capitalize}"
			newestPackages["games"].category() AssetUtil.getWSCIconUrl(newestPackages["games"])
			/>
		<#else>
			<@recommendedTitle "Unknown" "Unknown" "Unknown" "Unknown" ""/>
		</#if>
		<#if newestPackages["utilities"]??>
			<@recommendedTitle newestPackages["utilities"].slug() newestPackages["utilities"].name()
				newestPackages["utilities"].author() "Latest update in ${newestPackages['utilities'].category()?capitalize}"
				newestPackages["utilities"].category() AssetUtil.getWSCIconUrl(newestPackages["utilities"])
			/>
		<#else>
			<@recommendedTitle "Unknown" "Unknown" "Unknown" "Unknown" ""/>
		</#if>
		<#if newestPackages["emulators"]??>
			<@recommendedTitle newestPackages["emulators"].slug() newestPackages["emulators"].name()
				newestPackages["emulators"].author() "Latest update in ${newestPackages['emulators'].category()?capitalize}"
				newestPackages["emulators"].category() AssetUtil.getWSCIconUrl(newestPackages["emulators"])
			/>
		<#else>
			<@recommendedTitle "Unknown" "Unknown" "Unknown" "Unknown" ""/>
		</#if>
	</#if>
	</div>
	<#--<#assign first=true>
	<#list rTitles as page>
		<div id="${page.id()}" class="items${first?then("", " d-none")}">
			<#assign first=false>
			<#list page.apps() as title>
				<#if title == "unknown">
					<@recommendedTitle title "Unknown" "Unknown"/>
				<#else>
					<#assign app=catalog.getBySlug(title)>
					<@recommendedTitle app.slug() app.name() app.author()/>
				</#if>
			</#list>
		</div>
	</#list>-->
</@layout.page>

<@layout.footer dots=false>
    <@layout.osc.btn body="Start Shopping" id="start-shopping-btn" href="/home" w="353px" h="56px"/>
</@layout.footer>
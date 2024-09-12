<#import "../includes/base-layout.ftl" as layout>
<#assign AssetUtil=statics['org.oscwii.shop.utils.AssetUtil']>
<@layout.header.header (package.name())!"">
	<script type="text/javascript">
		shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

		function onLoad() {
			onLoadCommon();
			scrollTarget = $("#title-details")[0];

			var consoleTitle = ec.getTitleInfo("${package.titleInfo().titleId()}");
			if (consoleTitle !== ECReturnCodes.TITLE_NOT_INSTALLED && consoleTitle.isOnDevice) {
				if (consoleTitle.version > ${package.titleInfo().titleVersion()}) {
					$("#dl-button").children("span").children("#label").text("Update")
				} else {
					$("#dl-button").addClass("d-none");
				}
			}
		}
	</script>

	<style type="text/css">
		#main-content {
			height: 299px; /* 281 + 9 + 9 = 299 */
			padding: 0px 30px 0px 36px;
			margin: -9px 0px;
			overflow: hidden; /* this doesn't need to scroll?? why is it showing the scrollbar?? */
		}

		.btn-dl {
			padding: 0;
			font-size: 24px;
			color: white;
			line-height: 1;
		}

		.btn-dl .top {
			padding-top: 6px;
		}

		.btn-dl .sep {
			height: 1px;
			display: block;
			background-color: white;
			margin: 0px 9px;
		}

		.btn-dl .bottom {
			padding-bottom: 3px;
		}

		#category-heading {
			width: 229px;
			height: 21px;
			background-color: #34beed; /* I give up with roundedness for now */
			color: white;
			padding: 0px 3px;
			font-size: 14px;
			font-weight: bold;
			line-height: 25px; /* element is a fixed size, positioning like this should work well enough */
		}

		#title-details {
			height: 196px;
			border: 1px solid #34beed;
			padding: 8px;
			margin-bottom: 3px;
			overflow: auto;
		}

		/* :( */
		#title-details > .top {
			display: table;
		}

		#title-details > .top > * {
			display: table-row;
		}

		#title-details > .top > * > * {
			display: table-cell;
			vertical-align: middle;
		}

		#title-details > .sep {
			height: 1px;
			display: block;
			background-color: #34beed;
			margin: 8px 4px;
		}

		#title-details .left-col {
			padding-right: 8px;
		}

		#title-img {
			box-sizing: content-box;
			border: 1px solid #34beed;
			margin-bottom: 8px;
		}

		#btn-controllers {
			font-size: 10px;
			font-weight: bold;
			padding: 0;
			margin: auto;
		}
	</style>
</@layout.header.header>

<@layout.navigation headerTitle="Details" headerBtns=true/>

<#macro btnDownload label blocks href style="">
	<a id="dl-button" class="btn btn-dl" href="${href}" style="width: 241px; height: 76px;${style}">
		<span><span id="label" class="top">${label}</span></span>
		<span><span><span class="sep"></span></span></span>
		<span><span class="bottom">${blocks} ${(blocks == 1)?then("Block", "Blocks")}</span></span>
	</a>
</#macro>

<@layout.page>
	<#if package??>
		<div id="category-heading">${package.category()?capitalize}</div>
		<div id="title-details">
			<div class="top">
				<div>
					<div class="left-col">
						<img id="title-img" src="${AssetUtil.getWSCIconUrl(package)}" width="128" height="48"/>
						<@layout.osc.btn body="View compatible controllers" id="btn-controllers" href="controllers" w="67px" h="55px"/>
					</div>
					<div>
						<p id="title-version"><b>Version:</b> ${package.version()}</p>
						<p id="title-release-date"><b>Released:</b> ${FormatUtil.date(package.releaseDate())}</p>
						<p id="title-author"><b>Author:</b> ${package.author()}</p>
                        <#if package.authors()?size gt 0>
                        <p id="title-developers"><b>Developers:</b> ${package.authors()?join(", ")}</p>
                        </#if>
						<p id="title-downloads"><b>Downloads:</b> ${package.downloads()}</p>
						<!-- <p id="title-subcategories">Subcategories</p> --> <#-- would just be hidden if there are no subcategories -->
					</div>
				</div>
			</div>
			<div class="sep"></div>
			<p class="blue bold text-center" id="title-name">${package.name()}</p>
		</div>
		<@btnDownload "Download" blocks "controllers?download=true" "margin: auto"/>
	<#else>
		<p class="font-18px" style="margin-top: 1em">The title cannot be found.</p>
	</#if>
</@layout.page>

<@layout.footer>
	<div id="main-footer-btns">
		<@layout.osc.btn body="Back" class="btn-cancel" id="back-btn" href="javascript:history.back()" style="float: left"/>
		<#if package??>
			<@layout.osc.btn body="More Details" id="more-details-btn" href="details" style="float: right"/>
		</#if>
	</div>
</@layout.footer>
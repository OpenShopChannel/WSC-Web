<#import "../includes/base-layout.ftl" as layout>
<@layout.header.header "More Details">
    <script type="text/javascript">
		shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

		function onLoad() {
			onLoadCommon();
			scrollTarget = $("#title-details > .bottom")[0];
		}
	</script>

	<style type="text/css">
		#main-content {
			height: 299px;
			padding: 0px 30px 0px 36px;
			margin: -9px 0px;
			overflow: hidden;
		}

		#category-heading {
			width: 229px;
			height: 21px;
			background-color: #34beed;
			color: white;
			padding: 0px 3px;
			font-size: 14px;
			font-weight: bold;
			line-height: 25px;
		}

		#title-details {
			border: 1px solid #34beed;
		}

		#title-details > .top {
			height: 54px;
			padding: 4px;
			border-bottom: 1px solid #34beed;
		}

		#title-name {
			font-size: 16px;
			font-weight: normal;
		}

		#title-details > .bottom {
			height: 221px; /* 299 - 21 - 2 (#title-details vertical borders) - 54 - 1 (.top bottom border) = 221  */
			padding: 8px;
			overflow: auto;
		}

		#title-details-content {
			display: table;
		}

		#title-details-content > * {
			display: table-row;
		}

		#title-details-content > * > * {
			display: table-cell;
			vertical-align: top;
		}

		#title-details-content .image-col {
			padding-right: 8px;
		}

		#title-details-content .image-col img {
			margin-bottom: 16px; /* we don't have last-child so i can't remove this on the last image AAAAAHHHH */
		}

		#title-details-content .content-col {
			width: 100%;
			font-size: 18px;
		}

		pre#title-description {
			white-space: pre-wrap;
			font: inherit;
		}
	</style>
</@layout.header.header>

<@layout.navigation headerTitle="More Details" headerBtns=true/>

<@layout.page>
	<#if package??>
		<div id="category-heading">${package.category()?capitalize}</div>
		<div id="title-details">
			<div class="top">
				<h2 class="blue text-center" id="title-name">${package.name()}</h2>
			</div>
			<div class="bottom">
				<div id="title-details-content">
					<div>
						<div class="image-col">
							<img src="/static/img/screenshot_placeholder.png" width="160" height="120"/>
							<img src="/static/img/screenshot_placeholder.png" width="160" height="120"/>
						</div>
						<div class="content-col">
							<pre id="title-description">${package.description().longDesc()}</pre>
						</div>
					</div>
				</div>
			</div>
		</div>
	<#else>
		<p class="font-18px" style="margin-top: 1em">The title cannot be found.</p>
	</#if>
</@layout.page>

<@layout.footer>
	<div id="main-footer-btns">
		<@layout.osc.btn body="Back" class="btn-cancel" id="back-btn" href="javascript:history.back()"/>
	</div>
</@layout.footer>
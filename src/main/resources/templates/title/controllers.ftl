<#import "../includes/base-layout.ftl" as layout>
<@layout.header.header "Controller Support">
	<script type="text/javascript">
		shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

		function onLoad() {
			onLoadCommon();
		}
	</script>

	<style type="text/css">
		#main-content {
			margin: 0px 54px 0px 54px;
			padding: 4px 12px;
			background-image: url("/static/img/1px-blue-rounded-border.svg");
		}

		#title-name-container {
			height: 50px;
			border-bottom: 1px solid #34beed;
		}

		#title-name {
			font-size: 18px;
			font-weight: normal;			
		}

		#title-details-container {
			padding: 4px 0px;
		}

		#controllers {
			text-align: center;
			margin: 8px 0px;
		}
	</style>
</@layout.header.header>

<@layout.navigation headerTitle="Controller Support" headerBtns=true/>

<@layout.page>
	<#if package??>
		<div id="title-name-container">
			<h2 class="blue text-center" id="title-name">${package.name()}</h2>
		</div>
		<div id="title-details-container">
			<#-- TODO: Actually get and present the controller information. I'd need to recreate more icons, however. -->
			<p class="blue text-center font-14px">Please note the following when downloading this software:</p>
			<div id="controllers">
				<img src="/static/img/badges/wiimote.svg" width="56" height="41"/>
			</div>
			<p>You can use this software only with the Wii Remote.</p>
		</div>
	<#else>
		<p class="font-18px" style="margin-top: 1em">The title cannot be found.</p>
	</#if>
</@layout.page>

<@layout.footer>
	<div id="main-footer-btns">
		<@layout.osc.btn body="Back" class="btn-cancel" id="back-btn" href="javascript:history.back()" style="float: left"/>
		<#if isDownload && package??>
			<@layout.osc.btn body="OK" id="ok-btn" href="prepare-download?page=${nextPage}&location=${location}" style="float: right;"/>
		</#if>
	</div>
</@layout.footer>
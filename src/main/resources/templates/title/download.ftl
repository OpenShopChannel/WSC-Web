<#import "../includes/base-layout.ftl" as layout>
<@layout.header.header "Download Software">
	<script type="text/javascript" src="/static/js/download.js"></script>

	<script type="text/javascript">
		shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

		function onLoad() {
			onLoadCommon();

			// Set counters
			$("#nandDownload").text(getAndClearSessionValue("nBlDl"));
			$("#nandInstall").text(getAndClearSessionValue("nBlInstall"));
			$("#sdInstall").text(getAndClearSessionValue("sBlInstall"));
			<#-- TODO DEV:block HOME button -->
			<#-- TODO download to SD card -->
			<#if handleEc && package??>
			preDownload("${package.titleInfo().titleId()}", function () {
				<#-- Timeout so the text appears after the Mario fade-out animation -->
				setTimeout(onDownloadFinish, 750);
			});
			</#if>
		}

		function onDownloadFinish() {
			<#-- TODO error handling -->
			$("#summary").text("You downloaded");
			$("#download-result-btn").children("span").children("span").text("OK");
			$("#download-result-summary").text("Download successful!");
			$("#download-result").removeClass("d-none");
		}
	</script>

	<style type="text/css">
		#main-content {
			padding: 0px 20px;
		}

		#download-result-btn {
			margin: auto;
			font-size: 18px;
			width: 100%;
		}

		#download-result-summary {
			font-size: 28px;
			color: #34beed;
			font-weight: bold;
		}

		#storage-tbl {
			width: 100%;
			border-spacing: 0px;
		}

		#storage-tbl th, #storage-tbl td {
			text-align: right;
			font-weight: normal;
			box-sizing: content-box;
		}

		#storage-tbl td.amount {
			width: 100px;
			padding: 0px 10px 0px 20px;
		}

		#storage-tbl td.units {
			width: 120px;
			text-align: left;
		}
	</style>
</@layout.header.header>
<#-- TODO DEV:disable buttons -->
<@layout.navigation headerTitle="Download Software" headerBtns=true/>

<@layout.page>
    <#if package??>
	<div class="text-center font-18px" id="top">
		<p id="summary">You are downloading</p>
		<p class="blue">${package.name()}</p>
	</div>
	<br>
	<table class="font-18px" id="storage-tbl">
		<tr>
			<th>NAND Blocks after Download:</th>
			<td id="nandDownload" class="amount">0</td>
			<td class="units">Blocks</td>
		</tr>
		<tr>
			<th>NAND Blocks after Installation:</th>
			<td id="nandInstall" class="amount">0</td>
			<td class="units">Blocks</td>
		</tr>
		<tr>
			<th>SD Card Blocks after Installation:</th>
			<td id="sdInstall" class="amount">0</td>
			<td class="units">Blocks</td>
		</tr>
	</table>
	<div id="download-result" class="d-none">
		<br>
		<p id="download-result-summary" class="text-center"></p>
		<@layout.osc.btn body="." id="download-result-btn" href="/home" w="187px" h="55px"/>
	</div>
	<#else>
		<p class="font-18px" style="margin-top: 1em">The title cannot be found.</p>
	</#if>
</@layout.page>

<@layout.footer/>
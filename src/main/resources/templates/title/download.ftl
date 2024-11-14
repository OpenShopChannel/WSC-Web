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
			var progress = ec.getProgress();

			if(progress.errCode === 0) {
				$("#summary").text("You downloaded");
				$("#download-result-success").removeClass("d-none");
				notifyDownload("${package.slug()}", "${token}");
			} else {
				$("#download-summary").addClass("d-none");
				$("#summary").text("Download failed").addClass("red");
				$("#download-failed").removeClass("d-none");
				$("#download-result-code").text(progress.errCode);
				$("#main-footer-btns").removeClass("d-none");
			}
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

		#download-result-success {
			font-size: 28px;
			color: #34beed;
			font-weight: bold;
		}

		#download-result-failed {
			font-size: 24px;
			color: #ff0000;
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

		#qr-wrapper {
			padding-left: 90px;
			padding-right: 90px;
		}

		#qr-image {
			display: inline-block;
		}

		#qr-text {
			display: inline-block;
			width: 60%;
			padding-top: 30px;
			float: right;
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
	<div id="download-summary">
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
		<div id="download-result-success" class="d-none">
			<br>
			<p class="text-center">Download successful!</p>
			<@layout.osc.btn body="OK" id="download-result-btn" href="/home" w="187px" h="55px"/>
		</div>
	</div>
	<div id="download-failed" class="d-none">
		<div>
			<br>
			<div class="text-center">
				<div id="download-result-failed">
					Error code: <span id="download-result-code">000000</span>
				</div>
				<br>
				<p>Sorry! An error occurred with the download and could not be completed.</p>
			</div>
			<div id="qr-wrapper">
				<img id="qr-image" src="/static/img/discord_qr.png" width="128px" height="128px" alt="Discord Support QR">
				<p id="qr-text">Please try again, if the error persists, please report this in our Discord server.</p>
			</div>
		</div>
	</div>
	<#else>
		<p class="font-18px" style="margin-top: 1em">The title cannot be found.</p>
	</#if>
</@layout.page>

<@layout.footer>
	<div id="main-footer-btns" class="d-none">
		<div id="page-footers">
			<div class="page-footer">
				<@layout.osc.btn body="Go Back" id="download-result-btn" href="/home" style="float: right"/>
			</div>
		</div>
	</div>
</@layout.footer>
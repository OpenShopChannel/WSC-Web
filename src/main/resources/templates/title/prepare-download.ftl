<#import "../includes/base-layout.ftl" as layout>
<@layout.header.header "Download">
	<script type="text/javascript">
		var downloadLocation = "nand";

		// TODO: Sanitise/escape the translations!
		const pageTitles = {
			"location-select": "Download Location",
			"confirmation": "Download Confirmation"
		}

		const titleInfo = {
			"titleId": "<#if package??>${package.titleInfo().titleId()}</#if>",
			"appBlocks": ${appBlocks},
			"installerBlocks": ${installerBlocks},
			"requiredTotalBlocks": ${totalBlocks}
		};

		function showPage(id) {
			$("#pages > .page").each(function(i) {
				$(this).addClass("d-none");
			});

			$("#page-footers > .page-footer").each(function(i) {
				$(this).addClass("d-none");
			});

			if (pageTitles[id])
				$("#main-heading").text(pageTitles[id]);

			$("#pages > #" + id + "-page.page").removeClass("d-none");
			$("#page-footers > #" + id + "-page-footer.page-footer").removeClass("d-none");
		}

		$(document).ready(function() {
            const queryParams = getSplitQueryString();

            if (queryParams["page"])
				showPage(queryParams["page"]);
			else
				showPage("location-select");
		});

		shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

		function onLoad() {
			onLoadCommon();
		}

		function setDownloadLocation(loc) {
			downloadLocation = loc;
			const freeNandBlocks = ec.getDeviceInfo().totalBlocks - ec.getDeviceInfo().usedBlocks
			const freeSdBlocks = Math.floor(sdCard.getFreeKBytes() / 1024) * 8;
			var hasSpace = true;
			var nandBlocksAfterDownload = freeNandBlocks;
			var nandBlocksAfterInstall = freeNandBlocks;
			var remainingSdBlocks;
			var requiredSdBlocks;

			if (loc === "nand") {
				nandBlocksAfterDownload = freeNandBlocks - titleInfo.requiredTotalBlocks;
				nandBlocksAfterInstall = freeNandBlocks - titleInfo.installerBlocks;
				remainingSdBlocks = freeSdBlocks - titleInfo.appBlocks;
				requiredSdBlocks = titleInfo.appBlocks;
				$("#nandDl").text(titleInfo.requiredTotalBlocks);
				$("#nandSummaryBlocks").text(titleInfo.installerBlocks);

				// Space check
				if (titleInfo.requiredTotalBlocks >= freeNandBlocks) {
					$("#nandOpen").addClass("red");
					hasSpace = false;
				}
			} else if (loc === "sd") {
				remainingSdBlocks = freeSdBlocks - titleInfo.requiredTotalBlocks;
				requiredSdBlocks = titleInfo.requiredTotalBlocks;
				$("#nandDl").text(0);
				$("#nandSummaryBlocks").text(0);
			}

			// SD Space check
			if (requiredSdBlocks >= freeSdBlocks) {
				$("#sdOpen").addClass("red");
				hasSpace = false;
			}

			<#-- There is a better way to do this? Possibly -->
			$("#nandOpen").text(freeNandBlocks);
			$("#nandRemDl").text(nandBlocksAfterDownload);
			$("#nandRemIn").text(nandBlocksAfterInstall);
			$("#sdOpen").text(freeSdBlocks);
			$("#sdDl").text(requiredSdBlocks);
			$("#sdRem").text(remainingSdBlocks);
			$("#sdSummaryBlocks").text(requiredSdBlocks);

			if (!hasSpace)
				$("#btnDl").addClass("d-none");
			showPage("confirmation");

			// Used for download page
			ec.setSessionValue("nBlDl", nandBlocksAfterDownload.toString());
			ec.setSessionValue("nBlInstall", nandBlocksAfterInstall.toString());
			ec.setSessionValue("sBlInstall", remainingSdBlocks.toString());
		}

		function goToDownload() {
			window.location.href = "download?location=" + downloadLocation;
		}
	</script>

	<style type="text/css">
		#main-content {
			padding: 0px;
			margin: 0px;
		}

		#pages {
			height: 100%;
			position: relative;
		}

		#pages > * {
			width: 100%;
			height: 100%;
			position: absolute;
		}

		.m-left-auto-children > * {
			margin-left: auto;
		}

		/* ======== Download location page ======== */
		#location-select-page {
			padding: 0px 50px 0px 50px;
		}

		#location-select-tbl {
			width: 100%;
			height: 100%;
			table-layout: fixed;
			border-spacing: 0px;
		}

		#location-select-tbl > tbody > tr.text {
			height: 80px;
		}

		#location-select-tbl > tbody > tr.buttons > .btn {
			font-size: 18px;
		}

		#nand-btn, #sd-card-btn {
			padding: 25px;
			font-size: 16px;
		}

		/* ======== Download confirmation page ======== */
		#confirmation-page {
			padding: 0px 35px 0px 36px;

			/* Opera on the Wii wants to always show a scrollbar when the prompt text is showing, despite there
			 * being just enough space to fit on the page without one.
			 * Not even Opera 9.5 on desktop does this, so we just hide the scrollbar to appease the Wii. */
			overflow: hidden;
		}

		#confirmation-card {
			height: 225px;
			background-image: url("/static/img/confirmation-card.svg");
		}

		#confirmation-card > .header {
			height: 33px;
			border-bottom: 1px solid #34beed;
			padding: 2px 0px;
		}

		#confirmation-card > .header > .title {
			font-size: 18px;
			font-weight: normal;
			text-align: center;
			color: #34beed;
		}

		#confirmation-card > .content {
			height: 145px; /* 225 - 55 - 42 = 128px */
		}

		#confirmation-card > .content > #storage-tbl {
			height: 100%;
		}

		#confirmation-card > .footer {
			height: 42px;
			padding: 5px 4px;
			color: white;
		}

		#storage-tbl {
			width: 100%;
			border-spacing: 0px;
			line-height: 1;
			padding: 0px 6px;
		}

		#storage-tbl th, #storage-tbl td {
			text-align: right;
			font-weight: normal;
			box-sizing: content-box;
		}

		#storage-tbl td.amount {
			width: 90px;
			padding: 0px 7px;
		}

		#storage-tbl td.units {
			width: 130px;
			text-align: center;
		}

		#storage-tbl tr.sep > td > div {
			height: 1px;
			background-color: #34beed;
			margin: 0px 4px;
		}
	</style>
</@layout.header.header>

<@layout.navigation headerTitle="Download" headerBtns=true/>

<@layout.page>
    <#if package??>
	<div id="pages">
		<#-- Download location selection - start -->
		<div class="page d-none" id="location-select-page">
			<#-- sometimes you ain't got no choice -->
			<table id="location-select-tbl">
				<tr class="text">
					<td class="text-center font-18px" colspan="2">Please choose a location to download the data to.</td>
				</tr>
				<tr class="buttons">
					<#-- TODO: should really have a way to HTML encode the hrefs -->
					<td><@layout.osc.btn body="Wii System Memory" id="nand-btn" href="javascript:setDownloadLocation(&quot;nand&quot;)" w="228px" h="176px" img="/static/img/blank.gif"/></td>
					<td class="m-left-auto-children"><@layout.osc.btn body="SD Card" id="sd-card-btn" href="javascript:setDownloadLocation(&quot;sd&quot;)" w="228px" h="176px" img="/static/img/blank.gif"/></td>
				</tr>
			</table>
		</div>
		<#-- Download location selection - end -->
		<#-- Download summary - start -->
		<div class="page d-none" id="confirmation-page">
			<div id="confirmation-card">
				<div class="header">
					<h2 class="title">${package.name()}</h2>
				</div>
				<div class="content">
					<table id="storage-tbl">
						<tr>
							<th>NAND Open Blocks:</th>
							<td id="nandOpen" class="amount">4096</td>
							<td class="units">Blocks</td>
						</tr>
						<tr class="red">
							<th>NAND Blocks to Download:</th>
							<td id="nandDl" class="amount">0</td>
							<td class="units">Blocks</td>
						</tr>
						<tr>
							<th>NAND Blocks after Download:</th>
							<td id="nandRemDl" class="amount">0</td>
							<td class="units">Blocks</td>
						</tr>
						<tr>
							<th>NAND Blocks after Installation:</th>
							<td id="nandRemIn" class="amount">0</td>
							<td class="units">Blocks</td>
						</tr>
						<tr class="sep"><td colspan="3"><div></div></td></tr>
						<tr>
							<th>SD Card Open Blocks:</th>
							<td id="sdOpen" class="amount">0</td>
							<td class="units">Blocks</td>
						</tr>
						<tr class="red">
							<th>SD Card Blocks to Download:</th>
							<td id="sdDl" class="amount">0</td>
							<td class="units">Blocks</td>
						</tr>
						<tr>
							<th>SD Card Blocks after Download:</th>
							<td id="sdRem" class="amount">0</td>
							<td class="units">Blocks</td>
						</tr>
					</table>
				</div>
				<div class="footer">
					<p class="bold font-14px">Downloading this software requires <span id="nandSummaryBlocks">0</span> blocks in the Wii system memory,
						and <span id="sdSummaryBlocks">0</span> blocks on an SD Card.</p>
				</div>
			</div>
			<p class="blue bold text-center font-20px prompt">Download this software to Wii<br/>system memory now?</p>
		</div>
		<#-- Download summary - end -->
	</div>
    <#else>
		<p class="font-18px" style="margin-top: 1em">The title cannot be found.</p>
	</#if>
</@layout.page>

<@layout.footer>
	<div id="main-footer-btns">
		<div id="page-footers">
			<#-- Don't hide this one by default, a Back button is a good default -->
			<div class="page-footer" id="location-select-page-footer">
				<@layout.osc.btn body="Back" class="btn-cancel" href="./"/>
			</div>
			<div class="page-footer d-none" id="confirmation-page-footer">
				<@layout.osc.btn id="btnDl" body="Yes" href="javascript:goToDownload()" style="float: left"/>
				<@layout.osc.btn body="No" class="btn-cancel" href="javascript:showPage(&quot;location-select&quot;)" style="float: right"/>
			</div>
		</div>
	</div>
</@layout.footer>
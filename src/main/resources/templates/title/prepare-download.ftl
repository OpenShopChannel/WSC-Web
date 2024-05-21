<#import "../includes/base-layout.ftl" as layout>
<@layout.header.header "Download">
	<script type="text/javascript">
		// TODO: Sanitise/escape the translations!
		const pageTitles = {
			"location-select": "Download Location",
			"confirmation": "Download Confirmation"
		}

		var titleInfo = {

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
			if (loc === "nand") {
				// TODO: Calculate remaining space on NAND for title and show error if there is none
			} else if (loc === "sd") {
				// TODO: Calculate remaining space on SD card for title and show error if there is none
			}

			// TODO: Calculate remaining space on SD card for homebrew (if it's not just a forwarder being installed) and show error if there is none

			/* Should be conditional later, as seemingly some titles didn't show the controller selection confirmation,
			 * and some showed an additional page, such as the Wii U Transfer Tool. */
			if (true) {
				window.location.href = "controllers?download=true&location=" + loc + "&nextPage=confirmation";
			} else {
				showPage("confirmation");
			}
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
			height: 55px;
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
			height: 128px; /* 225 - 55 - 42 = 128px */
		}

		#confirmation-card > .content > #storage-tbl {
			height: 100%;
		}

		#confirmation-card > .footer {
			height: 42px;
			padding: 2px 4px;
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
		<div class="page d-none" id="confirmation-page">
			<div id="confirmation-card">
				<div class="header">
					<h2 class="title">Danbo</h2>
				</div>
				<div class="content">
                    <#-- TODO actually implement these counters -->
					<table id="storage-tbl">
						<tr>
							<th>NAND Open Blocks:</th>
							<td class="amount">4096</td>
							<td class="units">Blocks</td>
						</tr>
						<tr class="red">
							<th>NAND Blocks to Download:</th>
							<td class="amount">18</td>
							<td class="units">Blocks</td>
						</tr>
						<tr>
							<th>NAND Blocks after Download:</th>
							<td class="amount">4078</td>
							<td class="units">Blocks</td>
						</tr>
						<tr class="sep"><td colspan="3"><div></div></td></tr>
						<tr>
							<th>SD Card Open Blocks:</th>
							<td class="amount">131072</td>
							<td class="units">Blocks</td>
						</tr>
						<tr class="red">
							<th>SD Card Blocks to Download:</th>
							<td class="amount">16</td>
							<td class="units">Blocks</td>
						</tr>
						<tr>
							<th>SD Card Blocks after Download:</th>
							<td class="amount">131056</td>
							<td class="units">Blocks</td>
						</tr>
					</table>
				</div>
				<div class="footer">
					<p class="bold font-14px">Downloading this software requires 18 blocks in the Wii system memory, and 16 blocks on an SD Card.</p>
				</div>
			</div>
			<p class="blue bold text-center font-20px prompt">Download this software to Wii<br/>system memory now?</p>
		</div>
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
                <#-- TODO download -->
				<@layout.osc.btn body="Yes" href="" style="float: left"/>
				<@layout.osc.btn body="No" class="btn-cancel" href="javascript:showPage(&quot;location-select&quot;)" style="float: right"/>
			</div>
		</div>
	</div>
</@layout.footer>
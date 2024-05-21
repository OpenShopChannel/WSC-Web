<#import "../includes/base-layout.ftl" as layout>
<@layout.header.header "Download Software">
	<script type="text/javascript">
		shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

		function onLoad() {
			onLoadCommon();
		}
	</script>

	<style type="text/css">
		#main-content {
			padding: 0px 20px;
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

<@layout.navigation headerTitle="Download Software" headerBtns=true/>

<@layout.page>
    <#if package??>
	<div class="text-center font-18px" id="top">
		<p>You are downloading</p>
		<p class="blue">${package.name()}</p>
	</div>
	<table class="font-18px" id="storage-tbl">
        <#-- TODO actually implement these counters -->
		<tr>
			<th>NAND Blocks after Download:</th>
			<td class="amount">4078</td>
			<td class="units">Blocks</td>
		</tr>
		<tr>
			<th>SD Card Blocks after Download:</th>
			<td class="amount">131056</td>
			<td class="units">Blocks</td>
		</tr>
	</table>
	<#else>
		<p class="font-18px" style="margin-top: 1em">The title cannot be found.</p>
	</#if>
</@layout.page>
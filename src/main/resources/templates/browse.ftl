<#import "includes/base-layout.ftl" as layout>
<#assign categoryName=category?capitalize/>
<@layout.header.header title=categoryName>
    <script type="text/javascript">
		shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

		function onLoad() {
			onLoadCommon();

			$(titleSearchIn).mousedown(function() {
				keyboard.call(KeyboardType.DEFAULT_NO_RETURN, 5, false, "{% trans %}Enter the name of the title you want.{% endtrans %}");
			});

			$(titleSearchIn).change(function(e) {
				doSearch();
			});
		}

		function doSearch() {
			titleSearchIn.blur();
			var searchValue = titleSearchIn.value;
			titleSearchIn.value = "";

			if (searchValue) {
				window.location.href = "/search?category=${category}&type=title&query=" + searchValue;
			}
		}
	</script>

	<style type="text/css">
		/* 38px */
		#main-content {
			padding: 0px 19px 0px 29px;
		}

		#category-description {
			margin-bottom: 10px;
		}

		#btn-table {
			width: 100%;
			padding: 0px 19px 0px 9px;
			table-layout: fixed;
			border-spacing: 0px;
		}

		#btn-table .btn {
			font-size: 16px;
		}

		.btn-table-m-left-auto > * {
			margin-left: auto;
		}

		.btn-table-gap {
			height: 20px;
		}

		#titleSearchC {
			position: relative;
			overflow: hidden; /* gah */
		}

		#titleSearchIn {
			position: absolute;

			width: 100%;
			height: 100%;
			text-align: center;

			background: none;
			border: none;
			color: inherit;
			font: inherit;
			margin: 0;
			padding: 0;

			opacity: 0;
		}
	</style>
</@layout.header.header>

<@layout.navigation headerTitle=categoryName headerBtns=true/>

<@layout.page>
	<p class="blue bold" id="category-description">Unknown</p>
	<#-- could maybe use CSS table as that could semantically be more correct, but that would require more code (and doesn't matter for this) -->
	<table id="btn-table">
		<tr>
			<td><@layout.osc.btn body="Popular Titles" href="" w="240px" h="65px"/></td>
			<td class="btn-table-m-left-auto"><@layout.osc.btn body="Newest Additions" href="/search?category=" + category + "&type=newest" w="240px" h="65px"/></td>
		</tr>
		<tr class="btn-table-gap"><td></td></tr>
		<tr>
			<#-- percent width... bad! won't work later -->
			<td colspan="2"><@layout.osc.btn body="Search by Publisher" href="/search?category=" + category + "&type=publishers" w="100%" h="65px"/></td>
		</tr>
		<tr class="btn-table-gap"><td></td></tr>
		<tr>
			<td colspan="2">
				<div id="titleSearchC">
					<input type="text" id="titleSearchIn" maxlength="50"/>
					<@layout.osc.btn body="Search by Title" w="100%" h="65px"/>
				</div>
			</td>
		</tr>
	</table>
</@layout.page>

<@layout.footer>
    <div id="main-footer-btns">
		<@layout.osc.btn body="Back" class="btn-cancel" id="back-btn" href="javascript:history.back()"/>
	</div>
</@layout.footer>
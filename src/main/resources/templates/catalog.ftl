<#import "includes/base-layout.ftl" as layout>
<#assign AssetUtil=statics['org.oscwii.shop.utils.AssetUtil']>
<@layout.header.header "Catalog">
    <script type="text/javascript">
		shop.setWallpaper(WallpaperType.DOTTED_HORIZONTAL_LINES);

		function onLoad() {
			onLoadCommon();
			$("#main-content").find(".item:nth-child(2) > .btn-item").addClass("btn-hl");
			$("#main-content").find(".item:nth-child(3)").addClass("updated");
		}
	</script>

	<style type="text/css">
		#main-content {
			padding: 0px 6px 4px 6px;
			margin: 0px 30px 0px 36px;
			border: 1px solid #35beed;
		}

		.item {
			margin-top: 5px;
		}

		.item > .update-label {
			width: 150px;
			height: 23px;
			background-image: url("static/img/update.svg");
			margin-left: 12px;
			text-align: center;
			visibility: hidden;
		}

		.item.updated > .update-label {
			visibility: visible;
		}

		.btn-item {
			/*margin-top: 28px;*/ /* top margin of first item is actually 27px */
			padding: 0px 11px; /* +1 to account for button border */
			font-size: 16px;
		}

		.btn-item > * > * {
			text-align: left;
		}

		.btn-item .btn-img {
			border: 1px solid #34beed;
			box-sizing: content-box;
			margin-right: 5px;
		}

		.btn-item .btn-body {
			width: 100%;
			vertical-align: top;
			padding: 3px 0px;
		}

		.btn-item .sep {
			height: 1px;
			display: block;
			background-color: #34beed;
		}

		.btn-item:hover .sep {
			outline: 1px solid #9de0f6;
		}

		.btn-item .item-author {
			font-size: 14px;
		}

		/* :( */
		#main-footer-btns > #back-btn {
			float: left;
		}

		#main-footer-pagination {
			float: right;
		}

		#main-footer-pagination > * {
			float: left;
		}

		#main-footer-pagination .btn {
			padding: 0;
		}

		#main-footer-pagination > .pages {
			/*margin: 0px 20px;*/
			width: 101px;
			text-align: center;
		}
	</style>
</@layout.header.header>

<@layout.navigation headerTitle="Catalog" headerBtns=true/>

<#macro catalogItem slug title author banner="static/img/title_placeholder.png">
	<div class="item">
		<div class="update-label blue bold">Updated!</div>
		<a class="btn btn-item" href="/title/${slug}/" style="width: 477px; height: 84px">
			<span>
				<span class="btn-img-c"><img class="btn-img" src="${banner}" width="128" height="48"/></span>
				<span class="btn-body">
					<span class="item-title">${title}</span>
					<span class="sep"></span>
					<span class="item-author">${author}</span>
				</span>
			</span>
		</a>
	</div>
</#macro>

<@layout.page>
    <#list packages as package>
	<@catalogItem package.slug() package.name() package.author() AssetUtil.getWSCIconUrl(package)/>
	</#list>
</@layout.page>

<@layout.footer>
	<div id="main-footer-btns">
		<@layout.osc.btn body="Back" class="btn-cancel" id="back-btn" href="javascript:history.back()"/>
		<div id="main-footer-pagination">
			<@layout.osc.btn id="prev-page-btn" href="/" w="52px" h="52px" img="static/img/icons/left-arrow.svg" img_w="30" img_h="30"/>
			<span class="pages">1/2</span>
			<@layout.osc.btn id="next-page-btn" href="/" w="52px" h="52px" img="static/img/icons/right-arrow.svg" img_w="30" img_h="30"/>
		</div>
	</div>
</@layout.footer>
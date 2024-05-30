<#import "header.ftl" as header>
<#import "macros.ftl" as osc>
<#global FormatUtil=statics['org.oscwii.shop.utils.FormatUtil']>

<#macro navigation dots=true headerBtns=false headerTitleBlue=false headerTitle="" showTitle=true>
<body onload="onLoad()">
    <div id="main-header">
        <div id="main-header-contents">
            <#if showTitle>
            <h1 class="heading<#if headerTitleBlue || !(headerTitle?has_content)> blue</#if>" id="main-heading"><#if headerTitle?has_content>${headerTitle}<#else>${FormatUtil.openify("Open")} Shop Channel</#if></h1>
            </#if>
            <#nested>
            <#if headerBtns>
            <div id="main-header-btns">
                <div><@osc.btn class="btn-cancel" id="top-btn" href="/home" w="52px" h="55px" img="/static/img/icons/top.svg" img_w="34" img_h="34"/></div>
                <div class="last"><@osc.btn id="help-btn" w="52px" h="55px" img="/static/img/icons/help.svg" img_w="23" img_h="35"/></div>
            </div>
            </#if>
			<#-- TODO only enable when not running in prod mode -->
			<a href="/debug">Debug</a>
        </div>
        <#if dots><div class="dots">･･･････････････････････････････････････････････････････････････････････････</div></#if>
    </div>
</#macro>

<#macro page>
    <div id="main-content">
        <#nested>
    </div>
</#macro>

<#macro footer dots=true>
    <div id="main-footer">
        <#if dots><div class="dots">･･･${FormatUtil.openify("････")}････････････････････････････････････････････････････････････････････</div></#if>
        <div id="main-footer-contents">
            <#nested>
        </div>
    </div>
</body>
</html>
</#macro>
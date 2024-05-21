<#macro btn body="" class="" id="" href="" w="" h="" img="" img_w="" img_h="" style="">
<a class="btn<#if class?has_content> ${class}</#if>"<#if id?has_content> id="${id}"</#if><#if href?has_content> href="${href}"</#if><#if w?has_content || h?has_content || style?has_content> style="<#if w?has_content> width: ${w};</#if><#if h?has_content> height: ${h};</#if><#if style?has_content> ${style}</#if>"</#if>>
	<#-- XHTML doesn't permit us to put block elements like div in an inline element like anchor, so we use span as it's the closest to a generic inline container -->
	<#if img?has_content>
	<span><span class="btn-vert-img-c"><img class="btn-img" src="${img}"<#if img_w?has_content> width="${img_w}"</#if><#if img_h?has_content> height="${img_h}"</#if>/></span></span>
	</#if>
	<#if body?has_content>
	<span><span class="btn-body">${body}</span></span>
	</#if>
</a>
</#macro>
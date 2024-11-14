<#import "../includes/base-layout.ftl" as layout>
<@layout.header.header "Shop Error">
	<style>
        #error-description {
            margin: 10px 90px 0 20px;
        }
    </style>
</@layout.header.header>

<@layout.navigation/>

<@layout.page>
	<#-- "219" will be our prefix for OSC/EC errors-->
    <p class="red heading" id="error-description">Error Code: 219${code}</p>
	<#-- TODO error desc -->
	<p class="red" id="error-description" style="font-weight: bold">ERROR_DESC</p>
	<br>
	<p class="red" id="error-description">A critical error has occurred.<br>
		Please try again later, if this continues please contact the Open Shop Channel.
	</p>
	<br>
	<@layout.osc.btn body="Wii Menu" href="javascript:shop.returnToMenu()" w="200px" h="50px" style="margin: 17px auto 0px auto"/>
</@layout.page>

<@layout.footer/>
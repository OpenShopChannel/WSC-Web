<#import "../includes/base-layout.ftl" as layout>
<@layout.header.header "404 - Not Found">
	<style>
        #error-description {
            margin: 10px 90px 0 20px;
        }
    </style>
</@layout.header.header>

<@layout.navigation/>

<@layout.page>
	<#-- "200" will be our prefix for Shop HTTP errors-->
    <p class="red heading" id="error-description">Error Code: 200404</p>
	<p class="red" id="error-description" style="font-weight: bold">Not Found</p>
	<br>
	<p class="red" id="error-description">The resource you were looking for is not here.</p>
	<br>
	<@layout.osc.btn body="Return to the Shop" href="/" w="200px" h="50px" style="margin: 59px auto 0px auto"/>
</@layout.page>

<@layout.footer/>
<#macro header title="">
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>${title}<#if title?has_content> - </#if>Open Shop Channel</title>
    <link rel="stylesheet" href="/static/css/common.css">
    <#-- gah, have to do this inline so I can url_for -->
    <style type="text/css">
        /* The SVG buttons should ONLY be used for easy design mockups, as they are responsive.
         * There are numerous problems that come with using them, such as performance and stability.
         * They should be rendered to images of specific dimensions once finished. */
        .btn {
            background-image: url("/static/img/buttons/button.svg");
        }

        /* The hover could instead be done with SVG animations/events/whatever... if we weren't using background-image and an ancient version of Opera. */
        .btn:hover {
            background-image: url("/static/img/buttons/button-hover.svg");
        }

        /* Highlighted buttons (already installed apps) */
        .btn-hl {
            background-image: url("/static/img/buttons/button-hl.svg");
        }

        .btn-hl:hover {
            background-image: url("/static/img/buttons/button-hl-hover.svg");
        }

        /* Blue buttons with inner border, used as the Download button on title pages.
         * MUST be fixed size at 241x76. The SVG isn't responsive (and likely can't be made to, grr). */
        .btn-dl {
            background-image: url("/static/img/buttons/button-dl.svg");
        }

        .btn-dl:hover {
            background-image: url("/static/img/buttons/button-dl-hover.svg");
        }

        /* Solid, circular buttons used on the home page at the bottom */
        .btn-alt {
            background-image: url("/static/img/buttons/option.svg");
        }

        .btn-alt:hover {
            background-image: url("/static/img/buttons/option-hover.svg");
        }

        .heading.link > a:hover {
            background-image: url("/static/img/link-hover.svg");
        }

        .heading.link > a:active {
            background-image: url("/static/img/link-pressed.svg");
        }
    </style>
    <#-- JS wasn't sane enough until the 2010s, so we use jQuery so DOM stuff is less of a hassle (we can't even select an array of elements by class!) -->
    <script src="/static/js/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="/static/js/common.js" type="text/javascript"></script>
    <script src="/static/js/ec.js" type="text/javascript"></script>
    <script src="/static/js/ec-watchdog.js" type="text/javascript"></script>
    <script src="/static/js/buttons.js" type="text/javascript"></script>

	<script type="text/javascript">
		var isDevelopment = false;

		function onPreload() {
			isDevelopment = ${isDevelopment};
			onLoad();
		}
	</script>

    <#nested>
</head>
</#macro>
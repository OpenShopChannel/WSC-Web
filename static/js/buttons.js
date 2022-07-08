function setupButtons() {
    $(".button").each(function(i, obj) {
        $(this).attr("onmouseover", "buttonMouseOver('" + $(this).attr('id') + "')");
        $(this).attr("onmouseout", "buttonMouseOut('" + $(this).attr('id') + "')");
        $(this).attr("onmousedown", "buttonMouseDown('" + $(this).find('.buttonLink').attr('href') + "')");
    });
}

/**
 * Plays a selection sound, and loads the given URL.
 *
 * @param url {string} The URL to navigate to.
 */
function buttonMouseDown(url) {
    playSE(SoundType.SELECT);
    window.location.href = url;
}

/**
 * Plays a hover sound and changes the button's color slightly.
 *
 * @param {string} buttonID The ID of the hovered element.
 */
function buttonMouseOver(buttonID) {
    playSE(SoundType.HOVER);
    var backgroundColor = tinycolor($("#" + buttonID).css("background-color"));
    var lighterColor = backgroundColor.lighten(10).toHexString();
    $("#" + buttonID).css("background-color", lighterColor);
}

/**
 * Reverts the button's color change from hover.
 *
 * @param {string} buttonID The ID of the hovered element.
 */
function buttonMouseOut(buttonID) {
    var backgroundColor = tinycolor($("#" + buttonID).css("background-color"));
    var darkerColor = backgroundColor.darken(10).toHexString();
    $("#" + buttonID).css("background-color", darkerColor);
}

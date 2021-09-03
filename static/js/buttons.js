function setupButtons() {
    $(".button").each(function(i, obj) {
        $(this).attr("onmouseover", "buttonMouseOver('" + $(this).attr('id') + "')");
        $(this).attr("onmouseout", "buttonMouseOut('" + $(this).attr('id') + "')");
        $(this).attr("onmousedown", "buttonMouseDown('" + $(this).find('.buttonLink').attr('href') + "')");
    });
}

function buttonMouseDown(url) {
    playSE(3);
    window.location.href = url;
}

function buttonMouseOver(buttonID) {
    playSE(2);
    var backgroundColor = tinycolor($("#" + buttonID).css("background-color"));
    var lighterColor = backgroundColor.lighten(10).toHexString();
    $("#" + buttonID).css("background-color", lighterColor);
}

function buttonMouseOut(buttonID) {
    var backgroundColor = tinycolor($("#" + buttonID).css("background-color"));
    var darkerColor = backgroundColor.darken(10).toHexString();
    $("#" + buttonID).css("background-color", darkerColor);
}
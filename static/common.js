var shop = new wiiShop();
var sound = new wiiSound();
var keypad = new wiiKeyboard();
const unused = shop.connecting;

// Shop


// Sounds
var bgm = sound.playBGM();

function playSE(num) {
    sound.playSE(num);
}

// Keyboard
function keyboard(type, rowLimit, isPassword, title) {
    // example: keyboard(0, 10, false, "title")
    keypad.call(type, rowLimit, isPassword, title);
}

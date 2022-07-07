/**
 * Channel interfaces
 */

var shop = new wiiShop();
var ec = new ECommerceInterface();
var info = ec.getDeviceInfo();
var NWC24 = new wiiNwc24();
var sound = new wiiSound();
var keypad = new wiiKeyboard();

shop.setWallpaper(2);

/**
 * Timeout prevention
 */
const unused = shop.connecting;

/**
 * Sound
 */
function playSE(num) {
    sound.playSE(num);
}

/**
 * Keyboard
 */

function keyboard(type, rowLimit, isPassword, title) {
    // example: keyboard(0, 10, false, "title")
    keypad.call(type, rowLimit, isPassword, title);
}

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
 * Enum describing sounds available to play.
 * @readonly
 * @enum {number}
 */
const SoundType = {
    PUSH: 1,
    HOVER: 2,
    SELECT: 3,
    CANCEL: 4,
    CHOICE_CHANGE: 5,
    ERROR: 6,
    ADD_POINT: 7,
    DOWNLOAD_COMPLETE: 8,
    SMALL_MARIO_JUMP: 9,
    LARGE_MARIO_JUMP: 10,
    FIRE_BALL: 11,
    COIN: 12,
    HIT_BLOCK: 13,
    COPYING: 14,
    LOADING: 15
};

/**
 * Plays the given sound type.
 * @param {SoundType} num
 */
function playSE(num) {
    sound.playSE(num);
}

/**
 * Enum describing types of available keyboards.
 * @readonly
 * @enum {number}
 */
const KeyboardType = {
    // The "default" keyboard.
    DEFAULT: 0,
    // Also the "default" keyboard.
    // This may differ across locales, but it does not appear to.
    DEFAULT_TWO: 1,
    // Provides a number entry keyboard.
    NUMBER_PAD: 2,
    // The "default" keyboard, but without word completion or a return key.
    DEFAULT_NO_COMPLETION: 3,
    // Text entered is present within a large font.
    LARGE_FONT: 4,
    // The "default" keyboard, but without word completion, return key,
    // or the switcher to a number pad.
    DEFAULT_NO_COMPLETION_PAD: 5,
    // The large font keyboard, but without word completion, return key,
    // or the switcher to a number pad.
    LARGE_FONT_NO_COMPLETION_PAD: 6,
    // The number pad keyboard, but with a decimal option.
    NUMBER_PAD_DECIMAL: 7,
    // Also the number pad keyboard with decimal option.
    // This may differ across locales, but it does not appear to.
    NUMBER_PAD_DECIMAL_TWO: 8,
    // The keyboard used for friend code entry, dividing every 4 numbers into groups.
    FRIEND_CODE_ENTRY: 9,
    // The "default" keyboard, but without a return key.
    DEFAULT_NO_RETURN: 10
};

/**
 * Brings up a keyboard.
 *
 * @param type {KeyboardType} The type of keyboard to present.
 * @param rowLimit {number} The amount of rows of text to permit.
 * @param isPassword {boolean} Whether to mask text entry with asterisks.
 * @param title {string} The title/hint to provide to the user.
 * @see https://docs.oscwii.org/wii-shop-channel/js/keyboard
 */
function keyboard(type, rowLimit, isPassword, title) {
    // example: keyboard(0, 10, false, "title")
    keypad.call(type, rowLimit, isPassword, title);
}

/**
 * Hastily displays an error message within logging.
 * Please rewrite this function later.
 *
 * @param {string} message The message to display.
 */
function error(message) {
    // TODO: should this become an enum of errors for easier localization?
    trace("An error occurred: " + message);
    window.location.href = "/debug";
}
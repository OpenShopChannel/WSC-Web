/** @type {boolean} */
const isWiiShop = navigator.userAgent.indexOf("Wii Shop") != -1;

/**
 * Channel interfaces
 */
var shop = new wiiShop();
var ec = new ECommerceInterface();
var info = ec.getDeviceInfo();
var NWC24 = new wiiNwc24();
var sound = new wiiSound();
var keypad = new wiiKeyboard();

/**
 * Enum describing the available wallpapers that show in 16:9.
 * @readonly
 * @enum {number}
 */
const WallpaperType = {
	DOTTED_HORIZONTAL_LINES: 0,
	BLACK: 1,
	WHITE: 2,
	BLUE_VERTICAL_LINES: 3
};

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

/**
 * Gets the browser to redraw the page.
 * A required hack due to a Wii Shop Channel bug with SVGs.
 * 
 * @param {HTMLElement} el Element to perform redraw on.
 * @param {number} ms Time in milliseconds to delay redraw by.
 */
function redrawElement(el, ms) {
	setTimeout(function() {
		var disp = el.style.display;
		el.style.display = "none";
		el.style.display = disp;
	}, ms);
}

/**
 * Apply miscellaneous page fixes for both the Wii Shop and other browsers (for testing).
 */
function pageFixes() {
	if (isWiiShop) {
		// Work around WSC bug where SVGs aren't shown after they're loaded unless page is redrawn
		redrawElement(document.body, $(".btn").length * 100);
	}
}

/**
 * Performs common page load tasks.
 */
function onLoadCommon() {
	if (isWiiShop)
		initializeEC();
	
	setupButtons();
	pageFixes();
}
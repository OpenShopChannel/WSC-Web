/**
 * Channel interfaces
 */

var shop = new wiiShop();
var ec = new ECommerceInterface();
var info = ec.getDeviceInfo();
var NWC24 = new wiiNwc24();
var sound = new wiiSound();
var keypad = new wiiKeyboard();

shop.setWallpaper(1);

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

/**
 * Downloading
 */

var downloaderChannelID = "0x000100084f534344";
var downloaderChannelTicketID = "0x0001000000000000";

var startingDownload = false;

function startDownload (downloadLink) {
    if (!startingDownload) {
        startingDownload = true;
        var dlTask = new wiiDlTask();
        while (!dlTask.hasDeletedDLTask()) {
            dlTask.deleteDownloadTask();
        }
        dlTask.addDownloadTask("http://!|" + downloadLink, 4919);
        setTimeout(function(){
            ec.launchTitle(downloaderChannelID, downloaderChannelTicketID);
        }, 2000);
    }
} 
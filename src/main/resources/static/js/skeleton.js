// !!! Do not include this file on the actual Wii Shop Channel !!!
// This only exists to assist with code completion for common functions.

/**
 * Outputs a trace-level message via the EC logger.
 * @param {string} message Message to trace
 */
function trace(message) {}

/**
 * Represents the wiiShop object type inserted into the engine on any Wii.
 * This object allows various interaction with the channel's runtime.
 * You should instantiate it without any parameters.
 *
 * @constructor
 */
function wiiShop() {
    /**
     * Shows the main loading spinner.
     */
    this.beginWaiting = function() {}

    /**
     * Hides the main loading spinner.
     */
    this.endWaiting = function() {}

    /**
     * Resets the channel.
     **/
    this.retry = function() {}

    /**
     * Disables the HOME menu.
     */
    this.disableHRP = function() {}

    /**
     * Enables the HOME menu.
     */
    this.enableHRP = function() {}

    /**
     * Returns the localized string for the shop connecting.
     * For the English locale, this is "Connecting. Please wait..."
     * It is mandatory to access this, such as setting its value to an unused variable.
     * This disables an internal timer that causes the error 209601.
     **/
    this.connecting = "";

    /**
    * Throws an error, going to a separate page.
    *
    * @param {number} number Number of the error code to display.
    * @param {number} type Type of error message to display.
    */
    this.error = function(number, type) {}

    /**
     * Sets the image wrapping the
     *
     * @param {number} wallpaper The type of wallpaper to set.
     *
     * See https://docs.oscwii.org/wii-shop-channel/js/shop
     */
    this.setWallpaper = function(wallpaper) {}

    /**
     * Changes the appearance of Mario.
     * 0 is small Mario
     * 1 is star Mario
     * 2 is Mario running against Bullet Bill
     * 3 is Fire Mario
     * @param {number} value
     */
    this.setSCARank = function (value) {}
}

/**
 * Represents the wiiKeyboard object type inserted into the engine on any Wii.
 * This object allows using a native keyboard.
 * You should instantiate it without any parameters.
 *
 * @constructor
 */
function wiiKeyboard() {
    /**
     * Brings up a keyboard.
     * @param {number} type Type of keyboard. See also: https://docs.oscwii.org/wii-shop-channel/js/keyboard
     * @param {number} rowLimit Number of rows the user should be able to type.
     * @param {boolean} isPasswordField Whether to treat text entered as a password or not.
     * @param {string} title Content to show as a hint while typing.
     */
    this.call = function(type, rowLimit, isPasswordField, title) {}
}

/**
 * Represents the wiiSound object type inserted into the engine on any Wii.
 * This object allows using a native keyboard.
 * You should instantiate it without any parameters.
 *
 * @constructor
 */
function wiiSound() {
    /**
     * Plays the Wii Shop Channel theme.
     */
    this.playBGM = function() {}

    /**
     * Plays the given sound.
     *
     * @param {number} sound The sound to play.
     */
    this.playSE = function(sound) {}
}

/**
 * Represents the ECTitleInfo object type inserted into the engine on any Wii.
 * This object allows using a native keyboard.
 * While this can be instantiated alone, it's not recommended.
 *
 * @see ECommerceInterface.getTitleInfo
 * @constructor
 */
function ECTitleInfo() {
    /**
     * The current title version.
     * @type {number}
     */
    this.version = 0

    /**
     * Whether the title is installed onto the device.
     * @type {boolean}
     */
    this.isOnDevice = false
}

/**
 * Represents the ECPrice object type inserted into the engine on any Wii.
 * This object represents the price a client wishes to pay when
 * sending to the server.
 * While this can be instantiated alone, it's not recommended.
 *
 * @param {string} amount The amount to pay, such as '4.99'.
 * @param {string} currency The currency desired, such as 'POINTS', or 'USD'.
 * @constructor
 */
function ECPrice(amount, currency) {

}

/**
 * A native object representing a payment with the device's shop account.
 *
 * @constructor
 */
function ECAccountPayment() {

}

/**
 * A native object representing an array of title limits.
 *
 * @constructor
 */
function ECTitleLimits() {

}

/**
 * Represents the ECommerceInterface object type inserted into the engine on any Wii.
 * This high-level object allows a great amount of interaction with the underlying EC library.
 * You should instantiate it without any parameters, and only have one per page.
 *
 * @constructor
 */
function ECommerceInterface() {
    /**
     * Sets internal engine endpoints.
     *
     * @param {string} ecsUrl The endpoint used for ECS-related requests.
     */
    this.setWebSvcUrls = function(ecsUrl) {}

    /**
     * Sets internal engine endpoints.
     *
     * @param {string} ecsUrl The endpoint used for ECS-related requests.
     * @param {string} iasUrl The endpoint used for IAS-related requests.
     */
    this.setWebSvcUrls = function(ecsUrl, iasUrl) {}

    /**
     * Sets internal engine endpoints.
     *
     * @param {string} ecsUrl The endpoint used for ECS-related requests.
     * @param {string} iasUrl The endpoint used for IAS-related requests.
     * @param {string} casUrl The endpoint used for CAS-related requests. Unused within the Wii Shop Channel.
     */
    this.setWebSvcUrls = function(ecsUrl, iasUrl, casUrl) {}

    /**
     * Sets content URLs.
     *
     * @param ccsUrl The URL to use for cached content downloads over HTTP
     */
    this.setContentUrls = function(ccsUrl) {}

    /**
     * Sets content URLs.
     *
     * @param ccsUrl The URL to use for cached content downloads over HTTP
     * @param ucsUrl The URL to use for uncached content downloads over HTTPS
     */
    this.setContentUrls = function(ccsUrl, ucsUrl) {}

    /**
     * Retrieves the current log.
     *
     * @returns {string}
     */
    this.getLog = function() {}

    /**
     * Requests for a challenge from the server.
     *
     * Note that with WiiSOAP as the backend,
     * the challenge is hardcoded to "NintyWhyPls".
     *
     * @see getChallengeResp
     * @returns {ECProgress}
     */
    this.sendChallengeReq = function() {}

    /**
     * Returns the challenge as requested from the server.
     *
     * @returns {string}
     */
    this.getChallengeResp = function() {}

    /**
     * Returns progress for the foremost operation.
     *
     * @returns {ECProgress}
     */
    this.getProgress = function() {}

    /**
     * Synchronizes identifiers such as ticket sync times
     * and the device account's balance.
     *
     * @returns {ECProgress}
     */
    this.checkDeviceStatus = function() {}

    /**
     * Returns information about this device's identifiers,
     * storage, and service status.
     *
     * @returns {ECDeviceInfo}
     */
    this.getDeviceInfo = function() {}

    /**
     * Syncronizes the device's registration status.
     *
     * @see ECDeviceInfo.registrationStatus
     * @returns {ECProgress}
     */
    this.checkRegistration = function() {}

    /**
     * Requests for this console to be registered.
     *
     * @param {string} challenge The challenge returned from the server.
     * @returns {ECProgress}
     */
    this.register = function(challenge) {}

    /**
     * Syncs the device's tokens from the server.
     *
     * @param {string} challenge The challenge returned from the server.
     * @returns {ECProgress}
     */
    this.syncRegistration = function(challenge) {}

    /**
     * Sets a persistent value within the device's EC configuration.
     *
     * By default, this is the configuration file present within
     * "/title/00010002/48414241/data/ec.cfg".
     * OSC patches rename it to "osc.cfg" to avoid conflict.
     *
     * @param {string} key Name of the config key to set.
     * @param {string} value Contents of the value to set.
     */
    this.setPersistentValue = function(key, value) {}

    /**
     * Launches the given channel by title ID and ticket ID.
     *
     * @param {string} titleId Title ID of the channel.
     * @param {string} ticketId Ticket ID of the channel.
     */
    this.launchTitle = function(titleId, ticketId) {}

    /**
     * Returns title metadata for the given title ID.
     *
     * @param {string} titleId The title ID to retrieve metadata for.
     * @returns {ECTitleInfo} Title metadata.
     */
    this.getTitleInfo = function(titleId) {}

    /**
     * Purchases a title.
     *
     * @param {string} titleId The title ID to purchase.
     * @param {string} itemId Unknown.
     * @param {ECPrice} price The price the client wishes to use.
     * @param {ECAccountPayment} payment The payment method to use. Note that ECard/CreditCard payment types are also available.
     * @param {ECTitleLimits} limits An array of limits to apply with this title.
     * @param {boolean} downloadContent Whether to download title upon purchase.
     * @param {string} [taxes]
     * @param {string} [purchaseInfo]
     * @param {string} [discount]
     * @returns {ECProgress}
     */
    this.purchaseTitle = function(titleId, itemId, price, payment, limits, downloadContent, taxes, purchaseInfo, discount) {}

    /**
     * Quite possibly downloads a title.
     *
     * @param {string} titleId
     */
    this.downloadTitle = function (titleId) {}
}

/**
 * SD Card innit
 *
 * @constructor
 */
function wiiSDCard() {
    /**
     *
     * @param {string} titleId
     */
    this.backupToSDCard = function (titleId) {}

    /**
     *
     * @param {string} titleId
     */
    this.setJournalFlag = function (titleId) {}

    /**
     *
     * @returns Number
     */
    this.hasProgressFinished = function () {}

	/**
	 *
	 * @returns Number
	 */
	this.getFreeKBytes = function () {}
}

/**
 * Represents the ECDeviceInfo object type inserted into the engine on any Wii.
 * This high-level object exposes many device identifiers.
 *
 * @constructor
 */
function ECDeviceInfo() {
	/**
	 * The amount of used blocks in the device.
	 * @type {number}
	 */
	this.usedBlocks = 0;

	/**
	 * The total amount of blocks on the device
	 * @type {number}
	 */
	this.totalBlocks = 0;

    /**
     * The state of the console's registration.
     * To populate, please call ec.checkDeviceStatus();
     * @returns {ECRegistrationStates}
     */
    this.registrationStatus = ""
}

/**
 * Represents the progress of an asynchronous operation performed by EC.
 * This should not be instantiated by itself.
 *
 * @constructor
 */
function ECProgress() {
    /**
     * Status returned by EC internally.
     * @returns
     */
    this.status = 0
    /**
     * Operation title.
     */
    this.operation = ""
    /**
     * Operation description.
     */
    this.description = ""
    /**
     * Unknown.
     */
    this.phase = 0
    /**
     * State of cancellation.
     */
    this.isCancelRequested = false
    /**
     * Size currently downloaded. Most useful for a title contents-related operation, 0 otherwise.
     */
    this.downloadedSize = 0
    /**
     * Size of the finished contents. Most useful for a title contents-related operation, 0 otherwise.
     */
    this.totalSize = 0
    /**
     * Error code returned from operation.
     */
    this.errCode = 0
    /**
     * Information about the error. TODO: find how this is set
     */
    this.errInfo = ""
}

/**
 * Represents the wiiDlTask object type inserted into the engine on any Wii.
 * This high-level object allows management of download operations via the
 * WiiConnect24 scheduler. Typically, files such as banners are downloaded.
 *
 * @constructor
 */
function wiiDlTask() {
    /**
     * Adds a task to be downloaded.
     *
     * @param {string} url The URL to register for download.
     * @param {number} interval The interval of minutes to download this file over.
     */
    this.addDownloadTask = function(url, interval) {}

    /**
     * Deletes one registered download task.
     */
    this.deleteDownloadTask = function() {}

    /**
     * Returns whether the amount of registered tasks is 0.
     *
     * @returns {boolean}
     */
    this.hasDeletedDLTask = function() {}
}
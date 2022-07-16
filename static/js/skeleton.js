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
     *
     * @returns {ECProgress}
     */
    this.sendChallengeReq = function() {}

    /**
    *
    * @returns {string}
    */
    this.getChallengeResp = function() {}

    /**
    *
    * @returns {ECProgress}
    */
    this.getProgress = function() {}

    /**
     *
     * @returns {ECProgress}
     */
    this.checkDeviceStatus = function() {}

    /**
     *
     * @returns {ECDeviceInfo}
     */
    this.getDeviceInfo = function() {}

    /**
     *
     * @returns {ECProgress}
     */
    this.checkRegistration = function() {}

    /**
     * @param {string} challenge The challenge returned from the server.
     * @returns {ECProgress}
     */
    this.register = function(challenge) {}

    /**
     * @param {string} challenge The challenge returned from the server.
     * @returns {ECProgress}
     */
    this.syncRegistration = function(challenge) {}
}

/**
 * Represents the ECDeviceInfo object type inserted into the engine on any Wii.
 * This high-level object exposes many device identifiers.
 *
 * @constructor
 */
function ECDeviceInfo() {
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
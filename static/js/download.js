/**
 * The title ID of our download manager channel ("OSCD").
 */
var downloaderChannelID = "0x000100084f534344";
var downloaderChannelTicketID = "0x0001000000000000";
var downloaderChannelVersion = 1;
 
 /**
  * Whether an existing download operation is ongoing.
  */
var startingDownload = false;
 
 /**
  * Begins downloading for the passed title ID.
  * 
  * @param {string} titleId The title ID to begin downloading  
  */
function startDownload(titleId) {
    if (!startingDownload) {
        startingDownload = true;

        // TODO: somehow ensure download manager is up-to-date
        // TODO: separate flow to inform user download manager is being installed
        const managerTitle = ec.getTitleInfo(downloaderChannelID);
        if (managerTitle instanceof Number) {
            // An error occurred.
            if (managerTitle === ECReturnCodes.TITLE_NOT_INSTALLED) {
                // Install the title!
                installChannel(downloaderChannelID);
            } else {
                // Unknown error.
                error("Encountered while checking for download manager: " + managerTitle);
            }
        } else {
            if (managerTitle.version !== downloaderChannelVersion) {
                error("TODO: Please update the download manager.");
            }
        }

        // Install the current contents for our download manager to extract.
        installChannel(titleId);

        // Our download manager reads the persistent value "titleId".
        ec.setPersistentValue('titleId', titleId);
        setTimeout(function(){
            ec.launchTitle(downloaderChannelID, downloaderChannelTicketID);
        }, 2000);
    }
}

/**
 * Installs a channel for the given title ID.
 *
 * @param {string} titleId The title ID to install.
 */
function installChannel(titleId) {
    // We do not actually support paying for titles.
    const price = new ECPrice('0.00', 'DANBOS');
    const method = new ECAccountPayment();

    // Apply empty limits.
    const limits = new ECTitleLimits();

    const result = ec.purchaseTitle(titleId, '0', price, method, limits, true);
    if (result !== ECReturnCodes.COMPLETE) {
        error("Encountered error while downloading title: " + result);
    }
}
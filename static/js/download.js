/**
  * Whether an existing download operation is ongoing.
 */
var startingDownload = false;


/**
 * Installs a channel for the given title ID.
 *
 * @param {string} titleId The title ID to install.
 * @param {string} itemId The item ID of the title
 */
function installChannel(titleId, itemId) {
    if (!startingDownload) {
        startingDownload = true;

        // We do not actually support paying for titles.
        const price = new ECPrice('0.00', 'POINTS');
        const method = new ECAccountPayment();

        // Apply empty limits.
        const limits = new ECTitleLimits();


        const result = ec.purchaseTitle(titleId, itemId, price, method, limits, true);
        if (result !== ECReturnCodes.COMPLETE) {
            error("Encountered error while purchasing title: " + result);
        }
    }
}
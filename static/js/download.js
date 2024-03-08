/**
 * Whether an existing download operation is ongoing.
 */
var startingDownload = false;

/**
 * Current title ID for download
 */
var _titleId = "";


function preDownload(titleId) {
	_titleId = titleId;
	// TODO: Allow installation to the SD Card.
	/*
	ec.setParameter("SPACE_CHECK_POLICY", "SPACE_CHECK_ENTIRE_FS");
	sdCard.isJournaling();
	const journalRet = sdCard.setJournalFlag(titleId);
	if (journalRet !== 0) {
		error("setJournalFlag failed with " + journalRet);
	}

	pollSDProgress(noop, installChannel);
	 */
	installChannel();
}

/**
 * Installs a channel for the given title ID.
 */
function installChannel() {
	if (!startingDownload) {
		startingDownload = true;

		// We do not actually support paying for titles.
		const price = new ECPrice('0.00', 'POINTS');
		const method = new ECAccountPayment();

		// Apply empty limits.
		const limits = new ECTitleLimits();

		const result = ec.purchaseTitle(_titleId, "0", price, method, limits, true);
		completeOp(result, function () {
			window.location.href = "/finishdownload";
		});
	}
}
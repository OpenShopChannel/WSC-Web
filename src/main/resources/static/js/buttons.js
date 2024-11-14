/**
 * Setup and listen to specific events on buttons, as to play the hover and selection sounds.
 */
function setupButtons() {
	$(".btn").each(function(i) {
		$(this).mouseenter(function(e) {
			// too bad optional chaining is too new
			if (sound)
				sound.playSE(SoundType.HOVER);

			// ditto
			if (isWiiShop)
				redrawElement(e.currentTarget, 100);
		});

		$(this).mousedown(function(e) {
			if (sound) {
				if ($(this).hasClass("btn-cancel"))
					sound.playSE(SoundType.CANCEL);
				else
					sound.playSE(SoundType.SELECT);
			}
		});
	});
}
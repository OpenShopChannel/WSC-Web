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
			if (sound)
				sound.playSE(SoundType.SELECT);
		});
	});
}